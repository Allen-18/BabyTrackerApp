import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../authentication/auth/auth_repo.dart';
import '../authentication/auth/domain/user.dart';
import '../authentication/auth/users.dart';
import '../authentication/forgot_password/forgot_password.dart';
import '../authentication/signin/log_in.dart';
import '../authentication/signup/sign_up.dart';
import '../features/Growth/growth_page.dart';
import '../features/Health/health_page.dart';
import '../features/mainScreen/navigation_bar.dart';
import '../features/milestone/cognitive_skill/track_cognitive_skill.dart';
import '../features/milestone/motor_skill/track_motor_skill.dart';
import '../features/userData/add_baby_data.dart';
import '../features/userData/add_mother_data.dart';
import '../features/userData/add_new_baby.dart';
import 'initial_route.dart';

part 'app_router.g.dart';

enum AppRoutes {
  login,
  signUp,
  forgetPassword,
  addMotherData,
  addBabyData,
  addNewBaby,
  home,
  healthPage,
  growthPage,
  trackMotorSkill,
  trackCognitiveSkill,
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
          name: AppRoutes.addMotherData.name,
          path: "/addMotherData",
          pageBuilder: (context, state) {
            if (state.extra == null) {
              throw Exception(
                  "Can't navigate to addTimelineItem because patient is null");
            }
            final parent = state.extra as User;
            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: MotherProfile(
                parent: parent,
              ),
            );
          }),
      GoRoute(
        name: AppRoutes.addBabyData.name,
        path: "/addBabyData",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const BabyProfile(),
        ),
      ),
      GoRoute(
          name: AppRoutes.login.name,
          path: "/login",
          pageBuilder: (context, state) => buildPageWithFadeTransition(
                context: context,
                state: state,
                child: const Login(),
              )),
      GoRoute(
        name: AppRoutes.home.name,
        path: "/navigationBar",
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
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
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: const Growth()),
      ),
      GoRoute(
        name: AppRoutes.addNewBaby.name,
        path: "/addNewBaby",
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const AddAnotherChild(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.trackMotorSkill.name,
        path: "/trackMotorSkill",
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const MotorSkillTracker(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.trackCognitiveSkill.name,
        path: "/trackCognitiveSkill",
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: const CognitiveSkillTracker(),
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
