import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/show_read_err.dart';
import 'package:tracker/services/app_router.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(getGoRouterProvider);
    return goRouter.when(
        data: (goRouter) {
          if (goRouter == null) {
            return ShowReadErr(
                err: Exception('Eroare: Nu am putut sa citim ruta initiala.'),
                stack: StackTrace.current,
                retry: () => ref.invalidate(getGoRouterProvider));
          }
          return MaterialApp.router(
              routerConfig: goRouter,
              title: 'Tracker',
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme());
        },
        error: (err, stack) => ShowReadErr(
            err: err,
            stack: stack,
            retry: () => ref.invalidate(getGoRouterProvider)),
        loading: () => const CircularProgressIndicator());
  }
}
