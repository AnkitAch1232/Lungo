import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn gSignIn = GoogleSignIn();

  Future login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future Signup(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future loginWithGoogle() async {
    GoogleSignInAccount? googleUser = await gSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

    AuthCredential creds = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCreds = await auth.signInWithCredential(creds);
  }

  Future signOut() async {
    gSignIn.disconnect();
    auth.signOut();
  }

  Future addProduct()async{

  }

  Future editSelectedProduct()async{

  }
  Future deleteSelectedProduct()async{

  }


  Future getAllProduct()async{
    
  }
}
