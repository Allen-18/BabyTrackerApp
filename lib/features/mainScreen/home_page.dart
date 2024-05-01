import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/helpers/styles_manager.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Welcome",
          style: getMediumStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("user id: "),
            const Text("user email: "),
            const Text("email verified: "),
            TextButton(
              child: const Text("SignOut"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
