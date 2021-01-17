import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User firebaseUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In Authentication'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isSignIn?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              CircleAvatar(
                radius:  90,
                backgroundImage: NetworkImage(firebaseUser.photoURL),
              ),
              SizedBox(
                height: 40,
              ),
              Text(firebaseUser.displayName, textScaleFactor: 2,),
              Text(firebaseUser.email, textScaleFactor: 2,),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
              child: Text('LogOUT'),
              onPressed: (){
                 signOut();
              }),
          ],
        ),
      ):
       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Login', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            FlatButton.icon(
                   color: Colors.blueGrey,
                  onPressed: () {
                 googlesign();          },
                                icon: Icon(EvaIcons.google),
                               label: Text('Google Sign In'),
                               textColor: Colors.black,
                               ),
          ],
        ),
      ),
    );
  }
  bool isSignIn= false;
  googlesign()async{
    GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount googleSignInAccount=   await _googleSignIn.signIn();

    GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken, accessToken: authentication.accessToken);

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserCredential result = await firebaseAuth.signInWithCredential(credential);
     firebaseUser = result.user;

     setState(() {
       isSignIn = true;
     });
  }

  signOut()async{
    _googleSignIn.signOut().then((value) {
      setState(() {
        isSignIn= false;
      });
    });
  }
}