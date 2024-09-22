import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/models.dart';
import '/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required UserRepository userRepository
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard(scopes: ['email']),
        _userRepository = userRepository;  // Initialize _userRepository properly here

  @override
  Future<auth.User?> signUp({
    required User user,
    required String password,
  }) async {
    try {
      // Wait for the UserCredential to be created before accessing uid
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Now access the uid properly from userCredential.user
      if (userCredential.user != null) {
        await _userRepository.createUser(
          user.copyWith(id: userCredential.user!.uid),
        );
      }

      return userCredential.user;
    } catch (e) {
      print("Error during sign-up: $e");
      return null;
    }
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error during log-in: $e");
    }
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


@override
Future<void> logInWithGoogle() async {
  try {
    late final auth.AuthCredential credential;
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    if (userCredential.user != null) {
      await _userRepository.createUser(User(
        id: userCredential.user!.uid,
        fullName: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
      ));
    }
  } catch (e) {
    print("Error during Google sign-in: $e");
  }

}
}