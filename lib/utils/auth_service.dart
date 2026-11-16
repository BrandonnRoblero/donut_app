import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Inicio y cierre de sesión con Google + Firebase Auth
class AuthService {
  static bool _initialized = false;

  //Prepara Google Sign-In (toma el client ID de google-services.json)
  static Future<void> _init() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  //Usuario con sesión activa (null si nadie ha iniciado sesión)
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  //1. Elige cuenta de Google  2. Entra a Firebase con esa cuenta
  static Future<User?> signInWithGoogle() async {
    await _init();
    final GoogleSignInAccount account = await GoogleSignIn.instance
        .authenticate();
    final String? idToken = account.authentication.idToken;

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    return result.user;
  }

  //Cierra sesión en Google y en Firebase
  static Future<void> signOut() async {
    await _init();
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
