import 'package:cloud_firestore/cloud_firestore.dart';

class Databaseservice {
  final String uid;
  Databaseservice({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String name, phonenumber, birth, gender, num age) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phonenumber': phonenumber,
      'birth': birth,
      'age': age,
      'gender': gender
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  /*List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
          age: doc.data() //F['age'] ?? 'doesn\'nt exist uid'
          ,
          birth: doc.data() //['birth'] ?? ''
          ,
          gender: doc.data() //['gender'] ?? ''
          ,
          name: doc.data() //['name'] ?? ''
          ,
          phonenumber: doc.data() //['phonenumber'] ?? ''
          );
    }).toList();
  }*/
}

class UserModel {
  final String age;
  final String birth;
  final String gender;
  final String name;
  final String phonenumber;

  UserModel({this.age, this.birth, this.gender, this.name, this.phonenumber});
}
