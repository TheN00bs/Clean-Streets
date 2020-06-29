import '../models/shared-data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> getCurrentUser() async {
  try {
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(currentUser.email != null);
    assert(currentUser.displayName != null);
    assert(currentUser.photoUrl != null);

    SharedData.name = currentUser.displayName;
    SharedData.email = currentUser.email;
    SharedData.profileUrl = currentUser.photoUrl;
    print(SharedData.name);
    print(SharedData.email);
    print(SharedData.profileUrl);
    return 'success';
  } catch (e) {
    return 'fail';
  }
}

Future<String> signInWithGoogle() async {
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    await getCurrentUser();

    // final FirebaseUser currentUser = await _auth.currentUser();
    // assert(user.uid == currentUser.uid);

    // assert(user.email != null);
    // assert(user.displayName != null);
    // assert(user.photoUrl != null);

    // SharedData.name = user.displayName;
    // SharedData.email = user.email;
    // SharedData.profileUrl = user.photoUrl;

    return 'signInWithGoogle succeeded: $user';
  } catch (e) {
    return 'error';
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Sign Out");
}
