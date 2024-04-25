import 'package:flutter/material.dart';
import 'package:tracker/features/Registration/log_in.dart';
import 'helpers/routes_manager.dart';
import 'helpers/themes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.login,
        theme: getApplicationTheme(),
        home: const Login());
  }
}
