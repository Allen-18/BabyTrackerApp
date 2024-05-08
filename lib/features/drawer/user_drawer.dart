import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/features/drawer/parent_avatar.dart';
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
                  child: Column(children: [
            Expanded(
                child: ListView(
              children: [
                const SizedBox(height: 20),
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  accountName: Text(
                    user.name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  accountEmail: Text(user.relationship!.toUpperCase(),
                      style: const TextStyle(fontSize: 15)),
                  currentAccountPicture: ParentNetworkAvatar(
                    parent: user,
                    avatarSize: AvatarSize.drawerBig,
                  ),
                ),
                LogOffListTile(parent: user),
              ],
            )),
          ])));
        });
  }
}
