import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/authentication/controller/authentication_controller.dart';
import 'authentication/signin/log_in.dart';
import 'features/mainScreen/navigation_bar.dart';
import 'helpers/routes_manager.dart';
import 'helpers/themes_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationState = ref.watch(authProvider);

    Widget getHome() {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        return const HomeScreen();
      } else if (authenticationState.status ==
          AuthenticationStatus.unauthenticated) {
        return const Login();
      } else {
        return const Login();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.login,
      theme: getApplicationTheme(),
      home: getHome(),
    );
  }
}
