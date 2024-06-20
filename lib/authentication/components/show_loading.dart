import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/helpers/themes_manager.dart';

class ShowLoading extends ConsumerWidget {
  const ShowLoading(
      {super.key,
      this.size = 50,
      this.text = 'Se încarcă ...',
      this.includeMaterialApp = false});
  final String text;
  final bool includeMaterialApp;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return includeMaterialApp
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            home: Scaffold(body: loading()))
        : loading();
  }

  Widget loading() {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: size,
              width: size,
              child: const CircularProgressIndicator()),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 30),
          )
        ])));
  }
}
