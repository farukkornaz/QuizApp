import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/controllers/user_controller.dart';
import 'package:quiz_test_app/models/Question.dart';
import 'package:quiz_test_app/models/quiz_DB.dart';
import 'package:quiz_test_app/models/user.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserController controller = Get.put(UserController());
  QuestionController ccontroller = Get.put(QuestionController());

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set({'name': user.name, 'email': user.email, 'tel': user.tel, 'birthday': user.birthday});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createOnlineExam(UserModel user, String testName) async {
    try {
      await _firebaseFirestore.collection(testName).doc(user.id).set({
        'score': "",
        'time': "",
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getOnlineQData() async {
    var snapshot = await _firebaseFirestore.collection('online_tests').doc("online_test").collection("questions").get();
    var allData = snapshot.docs.map((doc) => doc.data()).toList();
    ccontroller.databaseQuestions = allData
        .map(
          (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answerIndex: question['answer_index'],
          ),
        )
        .toList();
    await _firebaseFirestore.collection('online_tests').doc("online_test").get().then((snapshot) {
      ccontroller.onlineTestName = snapshot["name"];
    });
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(uid).get();
      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> checkOnlineExam(String email, String testName) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection('online_tests').doc(testName).collection('sonuclar').doc(email).get();
      if (snapshot.exists) {
        print("1");
        return 1;
      } else {
        print("2");
        return 2;
      }
    } catch (e) {
      print(e);
      return 3;
    }
  }

  Future<void> storeOnlineExam(String examName, int score, int time, String email) async {
    try {
      await _firebaseFirestore.collection('online_tests').doc(examName).collection('sonuclar').doc(email).set({
        'score': score,
        'time': time,
      }, SetOptions(merge: true));

      print("11");
    } catch (e) {
      print(e);
      print("22");
    }
  }

  Future<void> storeQuizResultDB(String quizName, int score, String uid) async {
    try {
      var data = await _firebaseFirestore.collection('users').doc(uid).collection('quizes').doc(quizName).get();
      if (!data.exists) {
        await _firebaseFirestore.collection('users').doc(uid).collection('quizes').doc(quizName).set({
          'score': score,
        });
      } else if (data['score'] < score) {
        await _firebaseFirestore.collection('users').doc(uid).collection('quizes').doc(quizName).set({
          'score': score,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> getQuizResultDB(int quizName, String uid) async {
    try {
      var data =
          await _firebaseFirestore.collection('users').doc(uid).collection('quizes').doc(quizName.toString()).get();
      if (!data.exists) {
        return 0;
      } else {
        var data1 = data['score'];
        return data1;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> getSurvivalResultDB(int quizName, String uid) async {
    try {
      var data = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('quizes')
          .doc("surv_${(quizName + 1).toString()}")
          .get();
      if (!data.exists) {
        return 0;
      } else {
        var data1 = data['score'];
        return data1;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> getOnlineQuizResultDB(String email) async {
    try {
      var data = await _firebaseFirestore
          .collection('online_tests')
          .doc('online_test')
          .collection('sonuclar')
          .doc(email)
          .get();
      if (!data.exists) {
        return 0;
      } else {
        var data1 = data['score'];
        return data1;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> storeData(String content, String score, String uid) async {
    // Default store data
    try {
      await _firebaseFirestore.collection('users').doc(uid).collection('quizes').add({
        'datePlayed': Timestamp.now(),
        'content': content,
        'done': true,
        'score': score,
      });
    } catch (e) {}
  }

  Future<DateTime?> getOnlineTime() async {
    try {
      final snapshot = await _firebaseFirestore.collection('online_tests').doc('online_test').get();
      var dateTime = snapshot['time'].toDate();
      var dateTime2 = dateTime.add(const Duration(hours: 3));
      return dateTime2;
    } catch (e) {
      return null;
    }
  }

  Stream<List<QuizModel>> quizStream(String uid) {
    //getting data from Database as type of list
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('quizes')
        .orderBy('datePlayed', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuizModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(QuizModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  /*Future<void> updateQuiz(bool newValue, String uid, String quizId) async{ //update only
    try{
      _firebaseFirestore.collection('users')
          .doc(uid)
          .collection('quizes')
          .doc(quizId)
          .update({'done':newValue});

    }catch(e){
      print(e);
      rethrow;
    }
  }*/

  Future<void> setQuizScore(String newValue, String uid, String quizId) async {
    //saving quiz score and other infos, crate if not exist
    if (Get.find<QuestionController>().hsCheck(quizId)) {
      try {
        _firebaseFirestore.collection('users').doc(uid).collection('quizes').doc(quizId).set({
          'datePlayed': Timestamp.now(),
          'content': 'quizcontent',
          'done': true,
          'score': newValue,
        }, SetOptions(merge: true)); //merge provide us for rewrite data if exist
      } catch (e) {
        print(e);
        rethrow;
      }
    } else {}
  }

  Future<void> setUserInfo(String uid, String email, String name, String tel, String birthday) async {
    //saving quiz score and other infos, crate if not exist
    try {
      _firebaseFirestore.collection('users').doc(uid).set({
        'email': email,
        'name': name == "" ? controller.user.name : name,
        'tel': tel == "" ? controller.user.tel : tel,
        'birthday': birthday == "" ? controller.user.birthday : birthday,
      }, SetOptions(merge: true)); //merge provide us for rewrite data if exist
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
