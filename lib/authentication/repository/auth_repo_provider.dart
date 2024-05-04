import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repo.dart';

final authRepoProvider = Provider<AuthenticationRepository>(
  (_) => AuthenticationRepository(),
);
