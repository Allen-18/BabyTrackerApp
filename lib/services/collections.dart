import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/authentication/domain/user.dart';

CollectionReference<User> userCollection() {
  return FirebaseFirestore.instance.collection('users').withConverter(
      fromFirestore: User.fromFirstore, toFirestore: User.toFirestore);
}

CollectionReference<Kid> kidsCollection() {
  return FirebaseFirestore.instance.collection('kids').withConverter(
      fromFirestore: Kid.fromFirstore, toFirestore: Kid.toFirestore);
}
