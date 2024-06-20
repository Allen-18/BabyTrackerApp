import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/authentication/repository/users.dart';

class LogOffListTile extends ConsumerWidget {
  const LogOffListTile({super.key, required this.parent});

  final User parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.hourglass_bottom_sharp, color: Colors.blue),
      title: const Text("Dezactivare"),
      onTap: () async {
        debugPrint('LogOffTile | deactivate | pop all routes...');
        Navigator.of(context).popUntil((route) => route.isFirst);
        if (context.mounted) {
          Scaffold.of(context).closeEndDrawer();
          if (parent.isActive) {
            final ur = UsersRepository();
            final newDoc = parent.copyWith(
              isActive: false, // <- auto-redirects to LoginScreen
            );
            await ur.updateUser(newDoc);
          }
          debugPrint("Signing out ...");
          fa.FirebaseAuth.instance.signOut();
        }
      },
    );
  }
}
