import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/helpers/themes_manager.dart';

typedef RetryFunc = Function();

class ShowReadErr extends ConsumerWidget {
  const ShowReadErr(
      {super.key, required this.err, required this.stack, required this.retry});
  final Object err;
  final StackTrace stack;
  final RetryFunc retry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: Scaffold(
          body: Center(
              child: Row(children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
                child: Text(
              'The following error has occured while reading data from the database: $err',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ))
          ])),
          floatingActionButton: FloatingActionButton.large(
              onPressed: doRetry, child: const Icon(Icons.refresh)),
        ));
  }

  void doRetry() {
    if (kDebugMode) {
      print('Retry pressed');
    }
    retry();
  }
}
