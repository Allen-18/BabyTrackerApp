import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/mainScreen/provider/selected_index_provider.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/features/drawer/user_drawer.dart';
import '../children/kids_repository.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key, required this.currentUser, required this.kid});
  final User currentUser;
  final Kid kid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = ref.watch(selectedIndexProvider);
    final kidFuture = ref.watch(getKidFutureProvider(kidId: kid.id!));

    return kidFuture.when(
      data: (kid) {
        void onItemTapped(int index) {
          ref.read(selectedIndexProvider.notifier).state = index;
          switch (index) {
            case 0:
              context.pushNamed(AppRoutes.homeScreen.name, extra: currentUser);
              break;
            case 1:
              context.pushNamed(AppRoutes.kidProfile.name, extra: kid);
              break;
            case 2:
              context.pushNamed(AppRoutes.progress.name, extra: kid);
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
                    kid?.name ?? '',
                    style: getMediumStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    kid?.gender == "Boy"
                        ? 'Născut la data de ${kid?.dateOfBirth ?? ''}'
                        : 'Născută la data de ${kid?.dateOfBirth ?? ''}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.primary,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30, width: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.trackMotorSkill.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.physical,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Dezvoltare Motorie",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.trackCognitiveSkill.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.cognitive,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Dezvoltare Cognitivă",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30, width: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.trackLinguisticSkill.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.language,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Dezvoltare Lingvistică",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.trackSocialSkill.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.social,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Dezvoltare Socială",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30, width: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.healthPage.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.health,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Monitorizare Sănătate",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.growthPage.name,
                              extra: kid);
                        },
                        child: categoryCard(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  AppAssets.growth,
                                  scale: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Monitorizare creștere",
                                style: getMediumStyle(
                                    color: AppColors.grey, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            selectedItemColor: AppColors.primary,
            onTap: onItemTapped,
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
