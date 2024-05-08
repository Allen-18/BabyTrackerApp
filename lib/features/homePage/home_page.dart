import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tracker/authentication/components/loading_error.dart';
import 'package:tracker/features/children/get_kids.dart';
import 'package:tracker/features/homePage/get_scaffold_my_kids.dart';
import 'package:tracker/authentication/domain/user.dart';

class Home extends ConsumerWidget {
  const Home({super.key, required this.currentUser});

  final User currentUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamOfMyKids = ref.watch(getKidForCurrentParentProvider);

    return streamOfMyKids.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        error: (err, st) => Text(
              'Error: $err, $st',
              style: const TextStyle(color: Colors.red),
            ),
        loading: () => const LoadingSheet(),
        data: (myKids) {
          return GetScaffoldMyKids(myKids: myKids, currentUser: currentUser);
        });
  }
}
