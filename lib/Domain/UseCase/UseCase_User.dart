import 'package:flutter_school/Data/Models/Model_User.dart';
import 'package:flutter_school/Data/Repository/Repository_User.dart';

class SignInUseCase {
  final AuthenticationRepository repository;

  SignInUseCase(this.repository);

  Future<UserModel> execute(String email, String password) {
    return repository.signIn(email, password);
  }
}

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<UserModel> execute(String email, String password, String name) {
    return repository.signUp(email, password, name);
  }
}