import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/mainScreen/progress_page.dart';
import 'package:tracker/features/mainScreen/provider/selected_index_provider.dart';
import 'package:tracker/features/milestone/cognitive_skill/track_cognitive_skill.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/features/growth/growth_page.dart';
import 'package:tracker/features/health/health_page.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/features/milestone/motor_skill/track_motor_skill.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/features/drawer/user_drawer.dart';
import 'home_screen.dart';

class Categories extends ConsumerWidget {
  Categories({super.key, required this.currentUser, required this.kid});
  final User currentUser;
  final List data = [];
  final Kid kid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = ref.watch(selectedIndexProvider);

    void onItemTapped(int index) {
      ref.read(selectedIndexProvider.notifier).state = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        parent: currentUser,
                      )));
          break;
        case 1:
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const );
          break;
        case 2:
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProgressPage(
                        currentKid: kid,
                      )));
          break;
      }
    }

    return Scaffold(
      endDrawer: const ParentDrawer(
        selectedScreen: AppRoutes.homeScreen,
      ),
      appBar: AppBar(
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                kid.name,
                style: getMediumStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                'Născută la data de ${kid.cognitiveSkills.length}',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MotorSkillTracker(
                              currentUser: currentUser, kid: kid),
                        )),
                    child: categoryCard(
                        widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Image.asset(
                          AppAssets.physical,
                          scale: 1,
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Dezvoltare Motorie",
                          style: getMediumStyle(
                              color: AppColors.grey, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ))),
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CognitiveSkillTracker(
                            currentUser: currentUser,
                            kid: kid,
                          ),
                        )),
                    child: categoryCard(
                        widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Image.asset(
                          AppAssets.cognitive,
                          scale: 1,
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Dezvoltare Cognitivă",
                          style: getMediumStyle(
                              color: AppColors.grey, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Health(),
                        )),
                    child: categoryCard(
                        widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Image.asset(
                          AppAssets.health,
                          scale: 1,
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Monitorizare Sănătate",
                          style: getMediumStyle(
                              color: AppColors.grey, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ))),
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Growth(),
                        )),
                    child: categoryCard(
                        widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Image.asset(
                          AppAssets.growth,
                          scale: 1,
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Monitorizare creștere",
                          style: getMediumStyle(
                              color: AppColors.grey, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pagina de start',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progres',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
