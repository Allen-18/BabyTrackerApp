import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/homePage/list_of_my_kids.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/helpers/colors_manager.dart';

import '../../services/app_router.dart';
import '../common/utils/utils.dart';
import '../drawer/user_drawer.dart';

class GetScaffoldMyKids extends ConsumerWidget {
  const GetScaffoldMyKids(
      {required this.myKids, super.key, required this.currentUser});
  final List<Kid> myKids;
  final User currentUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstKidName = getFirstKidName(myKids);
    final kidNames = myKids.map((kid) => kid.name).join(' și ');
    final welcomeMessage = myKids.length > 1
        ? 'Bine ați venit ${currentUser.name} și copii $kidNames'
        : 'Bine ați venit ${currentUser.name} & $firstKidName';

    return Scaffold(
      endDrawer: const ParentDrawer(
        selectedScreen: AppRoutes.homeScreen,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
              right: 8.0, bottom: 20.0, top: 20.0, left: 8.0),
          child: Text(
            welcomeMessage,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColors.lightPrimary,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body:
          SafeArea(child: ListOfMyKids(kids: myKids, currentUser: currentUser)),
    );
  }
}
