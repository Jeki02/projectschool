import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Domain/UseCase/UseCase_User.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_event.dart';
import 'package:flutter_school/Presentation/Bloc/Authentication/Authentication_state.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthenticationBloc({required this.signInUseCase, required this.signUpUseCase})
      : super(AuthenticationInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    
  }

  void _onSignInEvent(
      SignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await signInUseCase.execute(event.email, event.password);
      emit(AuthenticationSuccess(user));
    } catch (error) {
      emit(AuthenticationFailure(error.toString()));
    }
  }

  void _onSignUpEvent(
    SignUpEvent event, Emitter<AuthenticationState> emit) async {
  emit(AuthenticationLoading());
  try {
    final user = await signUpUseCase.execute(event.email, event.password, event.name);
    emit(AuthenticationSuccess(user));
  } catch (error) {
    emit(AuthenticationFailure(error.toString()));
  }
  }

  
}