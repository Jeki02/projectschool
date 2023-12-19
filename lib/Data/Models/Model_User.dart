import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String name;


  UserModel({required this.id, required this.email, this.name = ''});

  factory UserModel.fromFirebase(User firebaseUser, {String name = ''}) {
    return UserModel(
      id: firebaseUser.uid, 
      email: firebaseUser.email ?? '',
      name: name,

    );
  }
}