

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../app/config/app_environment.dart';
import '../../storage/session_controller.dart';
import 'base/device_metadata.dart';

final class DioFactory {

  const DioFactory(
    this._environment,
    this._session,
    this._connectivity,
    this._deviceMetadata,
  );



  final AppEnvironment _environment;
  final SessionController _session;
  final Connectivity _connectivity;
  final DeviceMetadata _deviceMetadata;
}