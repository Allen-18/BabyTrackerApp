import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/authentication/auth/domain/user.dart';

CollectionReference<User> userCollection() {
  return FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: User.fromFirstore, toFirestore: User.toFirestore);
}
