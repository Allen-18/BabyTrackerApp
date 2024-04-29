import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/authentication/controller/authentication_controller.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider.notifier);
    final authUser = ref.watch(authProvider).user;
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
            Text("user id: ${authUser.id}"),
            Text("user email: ${authUser.email}"),
            Text("email verified: ${authUser.emailVerified}"),
            TextButton(
              child: const Text("SignOut"),
              onPressed: () {
                authController.onSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
