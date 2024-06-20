import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/authentication/forgot_password/forgot_password.dart';
import 'package:tracker/authentication/signin/log_in.dart';
import 'package:tracker/authentication/signup/sign_up.dart';
import 'package:tracker/features/Growth/growth_page.dart';
import 'package:tracker/features/Health/health_page.dart';
import 'package:tracker/features/homePage/home_page.dart';
import 'package:tracker/features/mainScreen/progress_page.dart';
import 'package:tracker/features/milestone/cognitive_skill/track_cognitive_skill.dart';
import 'package:tracker/features/userData/kid/add_baby_data.dart';
import 'package:tracker/features/userData/parent/add_parent_data.dart';
import 'package:tracker/features/userData/kid/add_new_baby.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/authentication/repository/auth_repo.dart';
import 'package:tracker/authentication/repository/users.dart';
import '../features/children/kids.dart';
import '../features/mainScreen/categories_page.dart';
import '../features/mainScreen/home_screen.dart';
import '../features/milestone/linguistic_skill/track_linguistic_skill.dart';
import '../features/milestone/motor_skill/track_motor_skill.dart';
import '../features/milestone/social_skill/track_social_skill.dart';
import '../features/profile/kid_profile_page.dart';
import '../features/profile/profile_page.dart';
import 'initial_route.dart';

part 'app_router.g.dart';

enum AppRoutes {
  login,
  signUp,
  forgetPassword,
  addParentData,
  addBabyData,
  addNewBaby,
  homeScreen,
  healthPage,
  growthPage,
  trackMotorSkill,
  trackCognitiveSkill,
  trackSocialSkill,
  trackLinguisticSkill,
  homePage,
  category,
  progress,
  profile,
  kidProfile,
}

//Transitions
CustomTransitionPage<dynamic> buildPageWithFadeTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

@riverpod
Future<GoRouter?> getGoRouter(GetGoRouterRef ref) async {
  final faUser = await ref.watch(authStateChangeProvider.future);
  if (kDebugMode) {
    print('$faUser');
  }
  if (faUser == null) {
    try {
      await fa.FirebaseAuth.instance.signInAnonymously();
    } catch (ex) {
      if (kDebugMode) {
        print('Could not sign in anonymously');
      }
    }
  }
  var initialRouteStr = '/${AppRoutes.login.name}';
  User? currentUser;
  if (faUser != null && !faUser.isAnonymous) {
    if (kDebugMode) {
      print('Trying to get user data ...');
    }
    final user = await ref.watch(getCurrentUserStreamProvider
        // this method (getGoRouter) will be called each time the values in the string
        // change in the firestore database
        .selectAsync((u) {
      if (u != null) {
        if (kDebugMode) {
          print('$u');
        }
      }
      return 'IsActive: ${u?.isActive}, UserRelationship: ${u?.relationship}';
    }));

    if (kDebugMode) {
      print(user);
    }
    currentUser = await ref.read(getCurrentUserStreamProvider.future);
    final initialRoute = getInitialRoute(currentUser);
    initialRouteStr = '/${initialRoute.name}';
  }
  if (kDebugMode) {
    print('InitialRouteStr $initialRouteStr');
  }

  return GoRouter(
    initialLocation: initialRouteStr,
    debugLogDiagnostics: false,
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutes.signUp.name,
        path: "/signUp",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const SignUp(),
        ),
      ),
      GoRoute(
          name: AppRoutes.addParentData.name,
          path: "/addParentData",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to addParentData because parent is null");
            }
            final parent = state.extra as User;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: Parent(
                parent: parent,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes.profile.name,
          path: "/profilePage",
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: ProfileScreen(),
            );
          }),
      GoRoute(
          name: AppRoutes.addBabyData.name,
          path: "/addBabyData",
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: BabyProfile(),
            );
          }),
      GoRoute(
          name: AppRoutes.login.name,
          path: "/login",
          pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const Login(),
              )),
      GoRoute(
          name: AppRoutes.homePage.name,
          path: "/homePage",
          pageBuilder: (context, state) {
            var parent = state.extra as User?;
            parent ??= currentUser;
            if (parent == null) {
              throw Exception(
                "Could not navigate to homePage because parent is null",
              );
            }
            if (parent.id == null) {
              throw Exception(
                "Could not navigate to homePage because parent.id is null",
              );
            }
            if (parent.id!.isEmpty) {
              throw Exception(
                "Could not navigate to homePage because parent.id is empty",
              );
            }
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: Home(
                currentUser: parent,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes.homeScreen.name,
          path: "/homeScreen",
          pageBuilder: (context, state) {
            var parent = state.extra as User?;
            parent ??= currentUser;
            if (parent == null) {
              throw Exception(
                "Could not navigate to homeScreen because parent is null",
              );
            }
            if (parent.id == null) {
              throw Exception(
                "Could not navigate to homeScreen because parent.id is null",
              );
            }
            if (parent.id!.isEmpty) {
              throw Exception(
                "Could not navigate to homeScreen because parent.id is empty",
              );
            }
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: HomeScreen(
                parent: parent,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes.kidProfile.name,
          path: "/kidProfilePage",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to kidProfilePage because kid is null");
            }
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: KidProfileScreen(
                kidData: kid,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes.healthPage.name,
          path: "/healthPage",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to healthPage because parent is null");
            }
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: Health(kid: kid),
            );
          }),
      GoRoute(
        name: AppRoutes.category.name,
        path: '/categoriesPage',
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final user = args['user'] as User;
          final kid = args['kid'] as Kid;
          return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: Categories(currentUser: user, kid: kid));
        },
      ),
      GoRoute(
        name: AppRoutes.growthPage.name,
        path: "/growthPage",
        pageBuilder: (context, state) {
          if (state.extra == null) {
            throw Exception(
                "Can't navigate to growthPage because parent is null");
          }
          final kid = state.extra as Kid;
          return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: Growth(
                currentKid: kid,
              ));
        },
      ),
      GoRoute(
        name: AppRoutes.progress.name,
        path: "/progressPage",
        pageBuilder: (context, state) {
          if (state.extra == null) {
            throw Exception(
                "Can't navigate to growthPage because parent is null");
          }
          final kid = state.extra as Kid;
          return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: ProgressPage(
                currentKid: kid,
              ));
        },
      ),
      GoRoute(
        name: AppRoutes.addNewBaby.name,
        path: "/addNewBaby",
        pageBuilder: (context, state) {
          if (state.extra == null) {
            throw Exception(
                "Can't navigate to addNewBaby because parent is null");
          }
          final parent = state.extra as User;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: AddAnotherChild(
              parent: parent,
            ),
          );
        },
      ),
      GoRoute(
          name: AppRoutes.trackMotorSkill.name,
          path: "/trackMotorSkill",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to trackMotorSkill because parent is null");
            }
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: MotorSkillTracker(
                kid: kid,
              ),
            );
          }),
      GoRoute(
        name: AppRoutes.trackCognitiveSkill.name,
        path: "/trackCognitiveSkill",
        pageBuilder: (context, state) {
          if (state.extra == null) {
            throw Exception(
                "Can't navigate to trackMotorSkill because parent is null");
          }
          final kid = state.extra as Kid;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: CognitiveSkillTracker(
              kid: kid,
            ),
          );
        },
      ),
      GoRoute(
          name: AppRoutes.trackSocialSkill.name,
          path: "/trackSocialSkill",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to trackSocialSkill because parent is null");
            }
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: SocialSkillTracker(
                kid: kid,
              ),
            );
          }),
      GoRoute(
          name: AppRoutes.trackLinguisticSkill.name,
          path: "/trackLinguisticSkill",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to trackLinguisticSkill because parent is null");
            }
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: LinguisticSkillTracker(
                kid: kid,
              ),
            );
          }),
      GoRoute(
        name: AppRoutes.forgetPassword.name,
        path: "/forgotPassword",
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const ForgotPasswordView(),
          );
        },
      ),
    ],
  );
}
