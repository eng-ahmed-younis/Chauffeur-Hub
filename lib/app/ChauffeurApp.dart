import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/services/di/service_locator.dart';

final class ChauffeurApp extends StatelessWidget {
  const ChauffeurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design canvas size (width x height) from Figma or design specs
      designSize: const Size(375, 812),
      // Adapts font sizes to prevent text overflowing on smaller screens
      minTextAdapt: true,
      // Enables layout adaptation for split-screen and multi-window modes
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: "Chauffeur Hub",
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          routerConfig: serviceLocator<GoRouter>(),
          builder: (context, child) => child ?? const SizedBox.shrink()
        );
      },
    );
  }
}
