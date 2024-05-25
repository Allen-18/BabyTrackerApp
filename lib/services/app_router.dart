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
import 'package:tracker/features/milestone/cognitive_skill/track_cognitive_skill.dart';
import 'package:tracker/features/userData/kid/add_baby_data.dart';
import 'package:tracker/features/userData/parent/add_parent_data.dart';
import 'package:tracker/features/userData/kid/add_new_baby.dart';
import 'package:tracker/authentication/domain/user.dart';
import 'package:tracker/authentication/repository/auth_repo.dart';
import 'package:tracker/authentication/repository/users.dart';
import 'package:tracker/features/mainScreen/home_screen.dart';
import '../features/children/kids.dart';
import '../features/milestone/motor_skill/track_motor_skill.dart';
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
  homePage,
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
          name: AppRoutes.addBabyData.name,
          path: "/addBabyData",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to addBabyData because parent is null");
            }
            final parent = state.extra as User;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: BabyProfile(parent: parent),
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
        name: AppRoutes.healthPage.name,
        path: "/healthPage",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const Health(),
        ),
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
            final parent = state.extra as User;
            final kid = state.extra as Kid;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: MotorSkillTracker(
                currentUser: parent,
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
          final parent = state.extra as User;
          final kid = state.extra as Kid;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: CognitiveSkillTracker(
              currentUser: parent,
              kid: kid,
            ),
          );
        },
      ),
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
