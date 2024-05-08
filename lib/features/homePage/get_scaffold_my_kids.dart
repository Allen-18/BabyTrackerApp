import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/homePage/list_of_my_kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/features/drawer/user_drawer.dart';

class GetScaffoldMyKids extends ConsumerWidget {
  const GetScaffoldMyKids(
      {required this.myKids, super.key, required this.currentUser});
  final List<Kid> myKids;
  final User currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      endDrawer: const ParentDrawer(
        selectedScreen: AppRoutes.homeScreen,
      ),
      appBar: AppBar(
          title: Text('Bine ati venit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: AppColors.black,
              ))),
      body:
          SafeArea(child: ListOfMyKids(kids: myKids, currentUser: currentUser)),
    );
  }
}
