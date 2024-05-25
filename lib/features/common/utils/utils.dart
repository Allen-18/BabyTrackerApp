import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/sorted_list.dart';

import '../../children/kids.dart';

extension ChangesOnStream<T> on Stream<QuerySnapshot<T>> {
  Stream<List<T>> toStreamChanges(StreamProviderRef ref,
      int Function(T a, T b) comparer, String streamName) {
    final list = SortedUniqueList<T>(comparer);
    final controller = StreamController<List<T>>();

    final sub = listen((event) {
      final isFromCache = event.metadata.isFromCache;
      for (var change in event.docChanges) {
        final k = change.doc.data();
        if (kDebugMode) {
          print(
              'toStreamChanges $streamName read doc ${change.doc.id} ${k.runtimeType} ${change.type}, isFromCache: $isFromCache');
        }
        if (k == null) {
          continue;
        }
        switch (change.type) {
          case DocumentChangeType.added:
            list.add(k);
            break;
          case DocumentChangeType.modified:
            list.update(k);
            break;
          case DocumentChangeType.removed:
            list.remove(k);
            break;
        }
      }
      controller.sink.add(list.items);
    }, onError: (err) => ('OH NO, FIREBASE STREAM CRASHED'));
    ref.onDispose(() {
      ('toStreamChanges.onDispose Disposing stream',);
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  }
}

extension DocumentOnStream<T> on Stream<DocumentSnapshot<T>> {
  Stream<T?> toStreamDoc({required String parentId}) {
    return map((e) {
      final p = e.data();
      return p;
    });
  }
}

Future<Kid?> returnKid(Kid kid) async {
  return Kid(
    id: kid.id,
    name: kid.name,
    dateOfBirth: kid.dateOfBirth,
    gender: kid.gender,
    isPremature: kid.isPremature,
    isHasTwin: kid.isHasTwin,
    childWeight: kid.childWeight,
    childHeight: kid.childHeight,
    childHeadCircumference: kid.childHeadCircumference,
    assignedParentId: kid.assignedParentId,
    motorSkills: kid.motorSkills,
    cognitiveSkills: kid.cognitiveSkills,
    socialSkills: kid.socialSkills,
    linguisticSkills: kid.linguisticSkills,
    weightMeasurements: kid.weightMeasurements,
    heightMeasurements: kid.heightMeasurements,
    headCircumferenceMeasurements: kid.headCircumferenceMeasurements,
  );
}

String getTextForMonth(int month) {
  switch (month) {
    case 1:
      return 'Prima lună';
    case 2:
      return 'A doua lună';
    default:
      return '$month luni';
  }
}
String formatTimestamp(DateTime timestamp) {
  // Format day, month, and year
  String formattedDate = '${timestamp.day.toString().padLeft(2, '0')}/'
      '${timestamp.month.toString().padLeft(2, '0')}/'
      '${timestamp.year}';

  // Format hour and minutes
  String formattedTime = 'la ora ${timestamp.hour.toString().padLeft(2, '0')}:'
      '${timestamp.minute.toString().padLeft(2, '0')}';

  // return concatenate both format
  return '$formattedDate $formattedTime';
}
