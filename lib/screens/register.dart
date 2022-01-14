import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turningpoint/screens/database.dart';

enum Sex { MAN, WOMEN }

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _phonenumberControl = new TextEditingController();
  final TextEditingController _birthControl = new TextEditingController();
  final TextEditingController _ageControl =
      new TextEditingController(text: "나이를 입력하세요");

  int _age = 0;
  Sex _sex = Sex.MAN;
  String gender = "남자";
  void trans() {
    if (_sex == Sex.MAN) {
      gender = "남자";
    } else
      gender = "여자";
  }

  String birth;

  @override
  Widget build(BuildContext context) {
    void _signUp() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailControl.text, password: _passwordControl.text);
        var user = userCredential.user;
        await Databaseservice(uid: user.uid).updateUserData(
          _usernameControl.text,
          _phonenumberControl.text,
          _birthControl.text,
          gender,
          _age,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text('비밀번호를 확인해주세요'));
              });
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text('이미 등록된 이메일입니다'));
              });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(e));
            });
      }
    }

    yearMonthDayPicker() async {
      final year = DateTime.now().year;

      final DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(year),
        lastDate: DateTime(year + 10),
      );

      if (dateTime != null) {
        _birthControl.text = dateTime.toString().split(' ')[0];
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
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
              "간단 회원가입",
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
              child: TextField(
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
                  hintText: "이메일",
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _emailControl,
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
              child: TextField(
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
              child: TextField(
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
                  hintText: "이름",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _usernameControl,
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
              child: TextField(
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
                  hintText: "나이",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _ageControl,
                keyboardType: TextInputType.number,
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
              child: TextField(
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
                  hintText: "전화번호",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _phonenumberControl,
                keyboardType: TextInputType.number,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      title: Text('남자'),
                      value: Sex.MAN,
                      groupValue: _sex,
                      onChanged: (value) {
                        //
                        setState(() {
                          _sex = value;
                          trans();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('여자'),
                      value: Sex.WOMEN,
                      groupValue: _sex,
                      onChanged: (value) {
                        setState(() {
                          _sex = value;
                          trans();
                        });
                      },
                    ),
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
              child: GestureDetector(
                onTap: yearMonthDayPicker,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _birthControl,
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
                      hintText: "생일",
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    onSaved: (val) {
                      birth = _birthControl.text;
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: 50.0,
            child: ElevatedButton(
                child: Text(
                  "회원가입".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _age = int.parse(_ageControl.text);
                  _signUp();
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor, // background
                  onPrimary: Colors.white, // foreground
                )),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
