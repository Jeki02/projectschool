import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/Data/DataSource/DataSource_Authentication.dart';
import 'package:flutter_school/Data/Models/Model_User.dart';

class AuthenticationRepository {
  final AuthenticationDataSource dataSource;
  final FirebaseFirestore firestore;
  AuthenticationRepository({required this.dataSource, required this.firestore});
  Future<UserModel> signIn(String email, String password) async {
    var userCredential =
        await dataSource.signInWithEmailAndPassword(email, password);
    return UserModel.fromFirebase(userCredential.user!);
  }

    Future<UserModel> signUp(String email, String password, String name) async {
    var userCredential = await dataSource.createUserWithEmailAndPassword(email, password);
    UserModel user = UserModel.fromFirebase(userCredential.user!, name: name);
    await firestore.collection("users").doc(user.id).set({
      'name': name,
      'email': email,
    });
    return user;
  }
}