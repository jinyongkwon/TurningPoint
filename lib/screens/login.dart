import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turningpoint/screens/firebase.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _signIn() async {
      if (!_formKey.currentState.validate()) return;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _usernameControl.text, password: _passwordControl.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text('이메일을 확인하여주세요\n등록되지 않은 이메일입니다.'));
              });
        } else if (e.code == 'wrong-password') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text('비밀번호가 틀렸습니다\n다시 확인하여주세요'));
              });
        }
      }
    }

    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "메일 로그인",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "이메일 주소",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                        ),
                      ),
                      maxLines: 1,
                      controller: _usernameControl,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return '이메일을 입력하여주세요';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
                elevation: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "비밀번호",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: true,
                        maxLines: 1,
                        controller: _passwordControl,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return '비밀번호를 입력하여주세요';
                          return null;
                        },
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  "비밀번호를 까먹으셨나요?",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 50.0,
              child: ElevatedButton(
                child: Text(
                  "로그인".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor, // background
                  onPrimary: Colors.white, // foreground
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              color: Theme.of(context).accentColor,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Text(
                "간편 로그인",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Firebaseinit();
                            },
                          ),
                        );
                      },
                      fillColor: Colors.blue[800],
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
//              size: 24.0,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: signInWithGoogle,
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.blue[800],
//              size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
