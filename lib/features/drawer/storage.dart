import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class Storage {

  Future<String> getProfilePicUrl(String fileName) async {
    final ref = FirebaseStorage.instance.refFromURL(fileName);
    final url = ref.getDownloadURL();
    return url;
  }
  Future<String> getKidProfilePicUrl(String kidId) async {
    final kidPicPath = "${getGsBaseDirProfilePicsPath()}kids/$kidId.jpg";
    final ref = FirebaseStorage.instance.refFromURL(kidPicPath);
    final url = await ref.getDownloadURL();
    return url;
  }


  String getGsBaseDirProfilePicsPath() {
    return "gs://kid-tracker-425b3.appspot.com/clients/profile_pics/";
  }

  String _f(int d) => d.toString().padLeft(2, '0');

  String getGsProfilePicPathBasedOnDate(String fileName) {
    final ext = p.extension(fileName);
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year.toString()}-${_f(now.month)}-${_f(now.day)}_${_f(now.hour)}-${_f(now.minute)}-${_f(now.second)}";
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user_id';
    return p.join(getGsBaseDirProfilePicsPath(), '$uid/$formattedDate$ext');
  }

  Future<bool> uploadFile(String gsFilePath, String localDeviceFilePath) async {
    final ref = FirebaseStorage.instance.refFromURL(gsFilePath);
    final normalFile = File(localDeviceFilePath);
    try {
      await ref.putFile(normalFile);
      return true;
    } catch (ex, st) {
      if (kDebugMode) {
        print(
            'Could not upload file $gsFilePath from $localDeviceFilePath $ex $st');
      }
      return false;
    }
  }
}
