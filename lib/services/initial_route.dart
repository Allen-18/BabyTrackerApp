import 'package:tracker/authentication/auth/domain/user.dart';

import 'app_router.dart';

AppRoutes getInitialRoute(User? user) {
  AppRoutes initialRoute = AppRoutes.login;
  if (user != null && user.isActive == false) {
    return AppRoutes.login;
  }
  if (user != null && user.isActive && user.hasChild) {
    return AppRoutes.home;
  }
  if (user != null && user.isActive == true && user.hasChild == false) {
    return AppRoutes.addBabyData;
  }
  return initialRoute;
}
