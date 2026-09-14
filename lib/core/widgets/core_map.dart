import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CoreMap extends StatefulWidget {
  const CoreMap({
    super.key,
    this.initialCameraPosition = const CameraPosition(
      target: LatLng(30.0444, 31.2357), // Default coordinate (Cairo)
      zoom: 15.0,
    ),
    this.onMapCreated,
    this.markers = const <Marker>{},
    this.polylines = const <Polyline>{},
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.zoomControlsEnabled = false,
    this.compassEnabled = false,
    this.trafficEnabled = false,
    this.mapType = MapType.satellite,
    this.onCameraMove,
    this.onTap,
  });

  final CameraPosition initialCameraPosition;
  final MapCreatedCallback? onMapCreated;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool compassEnabled;
  final bool trafficEnabled;
  final MapType mapType;
  final ValueChanged<CameraPosition>? onCameraMove;
  final ArgumentCallback<LatLng>? onTap;

  @override
  State<CoreMap> createState() => _CoreMapState();
}

class _CoreMapState extends State<CoreMap> {
  GoogleMapController? _controller;
  Marker? _currentLocationMarker;

  @override
  void initState() {
    super.initState();
    unawaited(_determinePositionAndMoveCamera());
  }

  Future<void> _determinePositionAndMoveCamera() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      final currentLocation = LatLng(position.latitude, position.longitude);

      if (!mounted) {
        return;
      }

      setState(() {
        _currentLocationMarker = Marker(
          markerId: const MarkerId('current_location'),
          position: currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: const InfoWindow(title: 'Current Location'),
        );
      });

      if (_controller != null) {
        await _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentLocation,
              zoom: 16.0,
            ),
          ),
        );
      }
    } catch (_) {
      // Fallback if current position cannot be retrieved immediately
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{...widget.markers};
    if (_currentLocationMarker != null) {
      markers.add(_currentLocationMarker!);
    }

    return GoogleMap(
      initialCameraPosition: widget.initialCameraPosition,
      onMapCreated: (controller) async {
        _controller = controller;
        widget.onMapCreated?.call(controller);
        unawaited(_determinePositionAndMoveCamera());
      },
      markers: markers,
      polylines: widget.polylines,
      myLocationEnabled: widget.myLocationEnabled,
      myLocationButtonEnabled: widget.myLocationButtonEnabled,
      zoomControlsEnabled: widget.zoomControlsEnabled,
      compassEnabled: widget.compassEnabled,
      trafficEnabled: widget.trafficEnabled,
      mapType: widget.mapType,
      onCameraMove: widget.onCameraMove,
      onTap: widget.onTap,
    );
  }
}
