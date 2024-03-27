import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String? quizId;
  String? score;
  Timestamp? datePlayed;
  bool? done;

  QuizModel(this.quizId,this.score,this.datePlayed,this.done);

  QuizModel.fromDocumentSnapshot(DocumentSnapshot doc){ //for assign new values from db
    quizId = doc.id;
    score = doc.get('score');
    datePlayed = doc.get('datePlayed');
    done = doc.get('done');
  }

}