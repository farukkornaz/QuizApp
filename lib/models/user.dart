import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String? id;
  String? name;
  String? email;
  String? tel;
  String? birthday;

  UserModel({this.id,this.name,this.email,this.tel,this.birthday});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc){ //for assign new values from db
    id = doc.id;
    name = doc['name'];
    email = doc['email'];
    tel = doc['tel'];
    birthday = doc['birthday'];

  }

}