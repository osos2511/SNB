import 'package:flutter/material.dart';
import 'package:gallary_system/provider/qr_code_provider.dart';
import 'package:provider/provider.dart';
import 'package:gallary_system/core/routes_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QrCodeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.splashRoute,
    );
  }
}
