part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}



class LoadProfile extends ProfileEvent {
  final auth.User? authUser;  // Firebase Auth User

  const LoadProfile(this.authUser);

  @override
  List<Object?> get props => [authUser];

}




class UpdateProfile extends ProfileEvent {
  final User user;

  const UpdateProfile({required this.user});  // Changed to named parameter

  @override
  List<Object?> get props => [user];
}

