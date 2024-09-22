import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shopzy/blocs/blocs.dart';
import 'package:shopzy/blocs/auth/auth_bloc.dart';  // Ensure correct path
import 'package:shopzy/repositories/user/user_repository.dart';  // Ensure correct path

// import 'package:shopzy/blocs/blocs.dart';
import 'package:shopzy/repositories/repositories.dart';

import '../../models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final AuthBloc _authBloc;
//   final UserRepository _userRepository;
//
//   StreamSubscription? _authSubscription;
//
//   ProfileBloc({
//     required AuthBloc authBloc,
//     required UserRepository userRepository,
//   })  : _authBloc = authBloc,
//         _userRepository = userRepository,
//         super(ProfileLoading()) {
//     on<LoadProfile>(_onLoadProfile);
//     on<UpdateProfile>(_onUpdateProfile);
//
//     _authSubscription = _authBloc.stream.listen((state) {
//       if (state.user != null) {
//         add(LoadProfile(state.authUser));
//       }
//     });
//   }
//
//   void _onLoadProfile(
//       LoadProfile event,
//       Emitter<ProfileState> emit,
//       ) {
//     if (event.authUser != null) {
//       _userRepository.getUser(event.authUser!.uid).listen((user) {
//         add(UpdateProfile(user as auth.User?));
//
//       });
//     } else {
//       emit(ProfileUnauthenticated());
//     }
//   }
//
//   void _onUpdateProfile(
//       UpdateProfile event,
//       Emitter<ProfileState> emit,
//       ) {
//     _userRepository.updateUser(event.user!);
//     emit(ProfileLoaded(user: event.user!));
//   }
//
//   @override
//
//   Future<void> close() async {
//     await _authSubscription?.cancel();
//     return super.close();
//   }
// }






class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(state.authUser));  // Pass authUser here
      }
    });
  }

  // void _onLoadProfile(
  //     LoadProfile event,
  //     Emitter<ProfileState> emit,
  //     ) {
  //   if (event.authUser != null) {
  //     // Listen to Firestore user data stream and map authUser to app's User model
  //     _userRepository.getUser(event.authUser!.uid).listen((user) {
  //       add(UpdateProfile(user));
  //     });
  //   } else {
  //     emit(ProfileUnauthenticated());
  //   }
  // }




  void _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) {
    if (event.authUser != null) {
      // Listen to Firestore user data stream and map authUser to app's User model
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        add(UpdateProfile(
            user
          : user
        ));  // Use named parameter 'user'
      });
    } else {
      emit(ProfileUnauthenticated());
    }
  }





  void _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) {
    // if (event.user != null) {
      _userRepository.updateUser(event.user);
      emit(ProfileLoaded(user: event.user));
    // } else {
    //   emit(ProfileUnauthenticated());
    // }
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
