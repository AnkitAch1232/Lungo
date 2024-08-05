import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future Signup(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
