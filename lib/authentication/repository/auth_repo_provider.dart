import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/authentication/auth/auth_repo.dart';

final authRepoProvider = Provider<AuthenticationRepository>(
  (_) => AuthenticationRepository(),
);
