import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/services/collections.dart';
import 'kids.dart';

part 'get_kids.g.dart';

@riverpod
Stream<List<Kid>> getStreamKidsForCurrentParent(
    GetStreamKidsForCurrentParentRef ref) {
  if (kDebugMode) {
    print('getStreamKidsForCurrentParentRef, Starting stream ...');
  }
  ref.onDispose(() => ('getStreamKidsForCurrentParentRef'));
  final kids = kidsCollection()
      .where("assignedParentId",
          isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots()
      .toStreamChanges(ref, Kid.compareById, 'getStreamKidsForCurrentParent');
  return kids;
}

@riverpod
Future<List<Kid>> getKidsForCurrentParent(GetKidsForCurrentParentRef ref,
    {required List<Kid> kids}) async {
  if (kDebugMode) {
    print('kids.len=${kids.length}');
  }
  final sw = Stopwatch()..start();
  final kidsList =
      await Future.wait(kids.map((kids) async => await returnKid(kids)));

  List<Kid> finalKids = [];
  for (var i = 0; i < kidsList.length; i++) {
    final p = kidsList[i];
    if (p != null) {
      finalKids.add(kidsList[i]!);
    }
  }
  sw.stop();
  return finalKids;
}

@riverpod
Future<List<Kid>> getKidForCurrentParent(GetKidForCurrentParentRef ref) async {
  final kidsStream =
      await ref.watch(getStreamKidsForCurrentParentProvider.future);
  final pod = getKidsForCurrentParentProvider(kids: kidsStream);
  final kids = await ref.watch(pod.future);
  return kids;
}
