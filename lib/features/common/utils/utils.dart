import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/sorted_list.dart';

import '../../children/cognitiveMilestone/cognitive_kid_skills.dart';
import '../../children/kids.dart';
import '../../children/linguisticMilestone/linguistic_kid_skills.dart';
import '../../children/motorMilestone/motor_kid_skills.dart';
import '../../children/socialMilestone/social_kid_skills.dart';

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
  Stream<T?> toStreamDoc({required String kidId}) {
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

String formatDateOnly(DateTime timestamp) {
  // Format day, month, and year
  String formattedDate = '${timestamp.day.toString().padLeft(2, '0')}/'
      '${timestamp.month.toString().padLeft(2, '0')}/'
      '${timestamp.year}';

  // Return the formatted date
  return formattedDate;
}

String getFirstKidName(List<Kid> myKids) {
  if (myKids.isNotEmpty) {
    return myKids.first.name;
  } else {
    return 'Nu sunt copii înregistrați';
  }
}

String getNewestMotorSkillTimestamp(List<MotorKidSkills> motorSkills) {
  if (motorSkills.isEmpty) {
    return 'Nu sunt înregistrate abilități motorii';
  }

  DateTime newestTimestamp = motorSkills.first.timestamp;

  for (var skill in motorSkills) {
    if (skill.timestamp.isAfter(newestTimestamp)) {
      newestTimestamp = skill.timestamp;
    }
  }

  return newestTimestamp.toIso8601String();
}

String getNewestCognitiveSkillTimestamp(
    List<CognitiveKidSkills> cognitiveSkills) {
  if (cognitiveSkills.isEmpty) {
    return 'Nu sunt înregistrate abilități cognitive';
  }

  DateTime newestTimestamp = cognitiveSkills.first.timestamp;

  for (var skill in cognitiveSkills) {
    if (skill.timestamp.isAfter(newestTimestamp)) {
      newestTimestamp = skill.timestamp;
    }
  }

  return newestTimestamp.toIso8601String();
}

String getNewestSocialSkillTimestamp(List<SocialKidSkills> socialSkills) {
  if (socialSkills.isEmpty) {
    return 'Nu sunt înregistrate abilități sociale';
  }

  DateTime newestTimestamp = socialSkills.first.timestamp;

  for (var skill in socialSkills) {
    if (skill.timestamp.isAfter(newestTimestamp)) {
      newestTimestamp = skill.timestamp;
    }
  }

  return newestTimestamp.toIso8601String();
}

String getNewestLinguisticSkillTimestamp(
    List<LinguisticKidSkills> linguisticSkills) {
  if (linguisticSkills.isEmpty) {
    return 'Nu sunt înregistrate abilități lingvistice';
  }

  DateTime newestTimestamp = linguisticSkills.first.timestamp;

  for (var skill in linguisticSkills) {
    if (skill.timestamp.isAfter(newestTimestamp)) {
      newestTimestamp = skill.timestamp;
    }
  }

  return newestTimestamp.toIso8601String();
}

String timeAgo(String? pastDateString) {
  if (pastDateString == null) {
    return '';
  }

  DateTime? pastDate;
  try {
    pastDate = DateTime.parse(pastDateString);
  } catch (e) {
    return pastDateString;
  }

  Duration timeDifference = DateTime.now().difference(pastDate.toLocal());
  if (timeDifference.inDays > 365) {
    int ani = (timeDifference.inDays / 365).floor();
    int remainingDays = timeDifference.inDays - (ani * 365);
    int luni = (remainingDays / 30).floor();
    String yearString = ani == 1 ? 'an' : 'ani';
    String monthString = luni == 1 ? 'lună' : 'luni';
    return '$ani $yearString și $luni $monthString';
  } else if (timeDifference.inDays > 0) {
    int remainingDays = timeDifference.inDays;
    int ore = timeDifference.inHours.remainder(24);
    String dayString = remainingDays == 1 ? 'zi' : 'zile';
    String hourString = ore == 1 ? 'oră' : 'ore';
    if (ore == 0) {
      return '$remainingDays $dayString';
    } else {
      return '$remainingDays $dayString și $ore $hourString';
    }
  } else if (timeDifference.inHours > 0) {
    int remainingHours = timeDifference.inHours;
    int minute = timeDifference.inMinutes.remainder(60);
    String hourString = remainingHours == 1 ? 'oră' : 'ore';
    String minuteString = minute == 1 ? 'minut' : 'minute';
    if (minute == 0) {
      return '$remainingHours $hourString';
    } else {
      return '$remainingHours $hourString și $minute $minuteString';
    }
  } else if (timeDifference.inMinutes > 0) {
    int remainingMinutes = timeDifference.inMinutes;
    String minuteString = remainingMinutes == 1 ? 'minut' : 'minute';
    return '$remainingMinutes $minuteString';
  } else {
    return 'câteva momente';
  }
}
