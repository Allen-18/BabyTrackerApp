import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'log_of.dart';

class ParentDrawer extends HookConsumerWidget {
  const ParentDrawer({super.key, required this.selectedScreen});
  final AppRoutes selectedScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getCurrentUserStreamProvider);
    return user.when(
      error: (err, st) => const Drawer(),
      loading: () => const Drawer(),
      data: (User? userNullable) {
        if (userNullable == null) return const Drawer();
        User user = userNullable;
        return SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 64.0,
                              height: 64.0,
                            ),
                            const SizedBox(width: 16.0),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kid Tracker',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.blue),
                        title: const Text('Gestionează profilul'),
                        selected: selectedScreen == AppRoutes.profile,
                        onTap: () {
                          context.pushReplacementNamed(AppRoutes.profile.name);
                        },
                      ),
                      LogOffListTile(parent: user),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
