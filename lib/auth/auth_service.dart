import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

void signIn(String email, String password) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    print(user);
  } catch (e) {
    print(e);
  }
}

void signUp(String email, String password, String name) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    print(user);
    if (user != null) {
      createUserInFirestore(user, name);
    }
  } catch (e) {
    print(e);
  }
}

void signout() async {
  try {
    await auth.signOut();
  } catch (e) {
    print(e);
  }
}

void createUserInFirestore(User user, String name) async {
  try {
    await firestore.collection('users').doc(user.uid).set({
      "name": name,
      "email": user.email,
    });
  } catch (e) {
    print(e);
  }
}

User? getCurrentUser() {
  try {
    User? user = auth.currentUser;
    return user;
  } catch (e) {
    print(e);
  }

  return null;
}

Future<Map?> getDataFromFirestore() async {
  User? user = getCurrentUser();
  if (user == null) {
    print("Error");
    return null;
  }
  try {
    DocumentSnapshot doc =
        await firestore.collection("users").doc(user.uid).get();
    Map? docData = doc.data() as Map?;
    return docData;
  } catch (e) {
    print(e);
  }
  return null;
}
