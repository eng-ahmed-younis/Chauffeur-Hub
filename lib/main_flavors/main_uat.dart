import '../app/chauffeur_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/services/di/service_locator.dart';
// ignore_for_file: directives_ordering




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await configureDependencies();

  runApp(const ChauffeurApp());
}
