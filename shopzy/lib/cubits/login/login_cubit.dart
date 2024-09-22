import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({ required AuthRepository authRepository })
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(
        email: value,
        status: LoginStatus.initial
    )
    );
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
        password: value,
        status: LoginStatus.initial
    )
    );
  }

  // Future<void> logInWithCredentials() async {
  //   if (state.status == LoginStatus.submitting) return;
  //
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     await _authRepository.logInWithEmailAndPassword(
  //       email: state.email,
  //       password: state.password,
  //     );
  //     emit(state.copyWith(status: LoginStatus.success));
  //   } catch (_) {
  //     // emit(state.copyWith(status: LoginStatus.error));
  //   }
  // }


  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;

    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      print("Login failed: $error");
      emit(state.copyWith(status: LoginStatus.error));
    }
  }



  Future<void> logInWithGoogle() async {
    if (state.status == LoginStatus.submitting) return;

    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithGoogle();

      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {}
  }

}