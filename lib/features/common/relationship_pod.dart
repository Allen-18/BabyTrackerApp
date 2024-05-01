import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedRelationshipPod =
    StateProvider.autoDispose<String?>((ref) => null);
