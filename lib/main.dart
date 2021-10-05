import 'package:flutter/material.dart';
import 'ui/shared/app_locator.dart';
import 'ui/shared/app_routes.dart';
import 'ui/shared/app_theme.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context).defaultTheme,
      initialRoute: AppRoutes.loginPage,
      routes: routes,
    );
  }
}
