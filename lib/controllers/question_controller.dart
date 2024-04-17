import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/quiz_controller.dart';
import 'package:quiz_test_app/models/Questions.dart';
import 'package:quiz_test_app/models/quizes.dart';
import 'package:quiz_test_app/screens/online_score_screen.dart';
import 'package:quiz_test_app/screens/quiz_screen.dart';
import 'package:quiz_test_app/screens/score_screen.dart';
import 'package:quiz_test_app/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

//get is for state management

class QuestionController extends GetxController with GetTickerProviderStateMixin  {
  AuthController _controller = Get.put(AuthController());

  late AnimationController _animationController; // _variable means private type

  late Animation _animation;

  Animation get animation => this._animation; // getter method

  late PageController _pageController;

  PageController get pageController => this._pageController;

  List<Question> _survivalQuestions = survival_questions
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          questionsId: question['questionsId'],
          options: question['options'],
          answer: question['answer_index'],
        ),
      )
      .toList();

  List<Question>? databaseQuestions;

  List<Question> _allQuestion = allQuestions
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          questionsId: question['questionsId'],
          options: question['options'],
          answer: question['answer_index'],
        ),
      )
      .toList();

  List<Question> _questions = testQ
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          questionsId: question['questionsId'],
          options: question['options'],
          answer: question['answer_index'],
        ),
      )
      .toList();

  List<Quizes> _quizes = quiz_list
      .map(
        (qCatalog) => Quizes(
          id: qCatalog['id'],
          quizName: qCatalog['quizName'],
          questionsId: qCatalog['questionsId'],
          category: qCatalog['category'],
          popular: qCatalog['popular'],
        ),
      )
      .toList();

  List<Question> get survivalQuestions => this._survivalQuestions;

  List<Question> get allQuestion => this._allQuestion;

  List<Question> get questions => this._questions;

  List<Quizes> get quizes => this._quizes;

  List<Quizes>? popularQuizes;

  bool _isAnswered = false;

  bool get isAnswered => this._isAnswered;

  bool alreadyAnswered = false;

  bool survivalActive = false;

  bool onlineActive = false;

  int? onlineTrueAnswerIndex;

  int? _onlineSelectedAnswer;

  int? get onlineSelectedAnswer => this._onlineSelectedAnswer;

  var selectedOnlineAnswers;

  int? _correctAns;

  int? get correctAns => this._correctAns;

  int? _selectedAns;

  int? get selectedAns => this._selectedAns;

  RxInt skipped = 0.obs;
  RxInt correct = 0.obs;
  RxInt wrong = 0.obs;
  RxInt score = 0.obs;

  var prefss;

  int sModeLength = 102;

  int? activeQuiz;

  String? activeSurvivalQuiz;

  List<Question>? _pSurvivalQuestions;

  List<Question>? get pSurvivalQuestions => this._pSurvivalQuestions;

  RxBool _isVisible = false.obs;

  RxBool get isVisible => this._isVisible;

  // obs type variable , can change from another class
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => this._numOfCorrectAns;

  RxList<int> quizesScores = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;

  RxList<int> survivalScores = [0, 0, 0].obs;

  RxInt onlineQuizScore = 0.obs;

  int quizesScoresSum = 0;
  int survivalScoresSum = 0;

  late AudioPlayer Aplayer;

  Timer? _timer;
  RxInt timerStart = 0.obs;
  RxInt timerMinute = 0.obs;

  String onlineTestName = "";
  RxInt survHigh = 0.obs;

  void getQuizesScores() async {
    /// Get scores of local quizes locally
    quizesScoresSum = 0;
    for (int i = 0; i < _quizes.length; i++) {
      quizesScores[i] = await getLocalQuizesScoreData(i);
      quizesScoresSum += quizesScores[i];
    }

    /// This is overload read from DB when login account
    /*if(!_controller.guest){
      quizesScoresSum = 0;
      for(int i = 0;i<_quizes.length;i++){
        if(i == 0){
          await Future.delayed(Duration(milliseconds: 500));
        }
        quizesScores[i] = await Database().getQuizResultDB(i,_controller.user.uid);
        quizesScoresSum += quizesScores[i];
      }
    }else{
      quizesScoresSum = 0;
      for(int i = 0;i<_quizes.length;i++){
        quizesScores[i] = await getLocalQuizesScoreData(i);
        quizesScoresSum += quizesScores[i];
      }
    }*/
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        timerStart.value++;
        if (timerStart.value > 59) {
          timerStart.value = 0;
          timerMinute.value++;
        }
        /*if(timerMinute.value == databaseQuestions!.length){
          onlineTestTimeEnd();
        }*/
        // TODO 10 min remaning
      },
    );
  }

  void onlineTestTimeEnd() async {
    if (_controller.guest) {
      checkOnlineAnswers();
      Get.off(OnlineScoreScreen());
    } else {
      checkOnlineAnswers();
      try {
        await Database().storeOnlineExam(
            onlineTestName, numOfCorrectAns, (databaseQuestions?.length ?? 0) * 300, _controller.user?.email ?? '');
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purpleAccent.withOpacity(0.5),
          colorText: Colors.white,
          borderColor: Colors.purpleAccent,
          borderWidth: 1.5,
          isDismissible: true,
          icon: Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          shouldIconPulse: false,
        );
      }
      _controller.onlineExamChecker = 1;
      print(numOfCorrectAns);
      questReset();
      resetStatus();
      onlineActive = false;
      onlineSelectedReset();
      resetOnlineTimer();
      isVisible.value = false;
      Get.off(OnlineScoreScreen());
    }
  }

  @override
  void onInit() {
    _animationController = AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        //update like setState
        update();
      });
    //animation starter
    // after 60 sn go to next question
    //_animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    _pSurvivalQuestions = List.filled(sModeLength, Question());
    getQuizesScores();
    getPopularQuizes();
    /*if(_controller.guest == true){
      getLocalDataHighScore();
    }*/
    getLocalDataHighScore();
    //generateSurvivalQuestions();
    Aplayer = AudioPlayer();
    super.onInit(); // super. because of @override
  }

  storeLocalDataHighScore(int data, String sId) async {
    // save local data
    final prefs = await SharedPreferences.getInstance();
    int _data = (prefs.getInt(sId) ?? 0);
    if (data > _data) prefs.setInt(sId, data);
  }

  getLocalDataHighScore() async {
    // get local and DB data
    /*if(!_controller.guest){
      survivalScoresSum = 0;
      for(int i = 0;i<survivalScores.length;i++){
        survivalScores[i] = await Database().getSurvivalResultDB(i,_controller.user.uid);
        survivalScoresSum += survivalScores[i];
      }
    }else{
      survivalScoresSum = 0;
      final prefs = await SharedPreferences.getInstance();
      for(int i = 0;i<survivalScores.length;i++){
        int _data = (prefs.getInt("surv_${i+1}")?? 0);
        survivalScores[i] = _data;
        survivalScoresSum += survivalScores[i];
      }
    }*/
    survivalScoresSum = 0;
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < survivalScores.length; i++) {
      int _data = (prefs.getInt("surv_${i + 1}") ?? 0);
      survivalScores[i] = _data;
      survivalScoresSum += survivalScores[i];
    }
  }

  storeLocalQuizesScore(int data, int x) async {
    final prefs = await SharedPreferences.getInstance();
    int _data = (prefs.getInt("$x") ?? 0);
    if (data > _data) prefs.setInt("$x", data);
  }

  Future<int> getLocalQuizesScoreData(int x) async {
    // get local data
    final prefs = await SharedPreferences.getInstance();
    int _data = (prefs.getInt("$x") ?? 0);
    return _data;
  }

  void getOnlineQuizesScoreData() async {
    if (!_controller.guest) {
      final _data = await Database().getOnlineQuizResultDB(_controller.user?.email ?? '');
      onlineQuizScore.value = _data;
    }
  }

  resetLocalQuizesScore() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < quizes.length; i++) {
      prefs.setInt("$i", 0);
    }
    prefs.setInt("surv_1", 0);
    prefs.setInt("surv_2", 0);
    prefs.setInt("surv_3", 0);
  }

  //called just before the controller delete from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
    Aplayer.dispose();
  }

  void playCorrectSound() async {
    await Aplayer.setAsset('assets/sounds/true.mp3');
    Aplayer.play();
  }

  void playWrongSound() async {
    await Aplayer.setAsset('assets/sounds/wrong.mp3');
    Aplayer.play();
  }

  void newOnlineSelectedValue(int qid, int index) {
    selectedOnlineAnswers[qid - 1] = index;
    update();
  }

  void checkAns(Question question, int selectedIndex) {
    //when user pressed button it will run
    if (!alreadyAnswered) {
      _isAnswered = true;
      _correctAns = question.answer;
      _selectedAns = selectedIndex;
      _isVisible.value = true;

      if (_correctAns == _selectedAns) {
        playCorrectSound();
        _numOfCorrectAns++;
        correct++;
        score += 10;
        survHigh.value += 10;
      } else {
        playWrongSound();
        wrong++;
      }

      //stop counter
      animationStop();

      update();

      //after 3 seconds go to the next page
      /*  Future.delayed(Duration(seconds: 3), () {
    nextQuestion();
    }); */
    }
  }

  void onlineAnswered(Question question, int selectedIndex) {
    _onlineSelectedAnswer = selectedIndex;
    onlineTrueAnswerIndex = question.answer;

    update();
  }

  void onlineSelectedReset() {
    _onlineSelectedAnswer = null;
  }

  void checkOnlineAnswers() {
    if (databaseQuestions == null) return;
    for (int i = 0; i < databaseQuestions!.length; i++) {
      if (selectedOnlineAnswers[i] == databaseQuestions![i].answer) {
        _numOfCorrectAns++;
      }
    }
  }

  void resetOnlineTimer() {
    _timer?.cancel();
    timerStart.value = 0;
    timerMinute.value = 0;
  }

  void survivalNextQuestion() {
    if (_questionNumber.value != sModeLength) {
      _isAnswered = false;
      //_pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.ease);
      _pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.easeIn);
      _isVisible.value = false;
    } else {
      //get package's simple navigation to another page
      Get.off(ScoreScreen());
      /*if(!_controller.guest){
        Database().setQuizScore(
            '${numOfCorrectAns * 10}',
            Get.find<AuthController>().user.uid,
            'quiz001');
      }*/
      //Database().storeData('quiz1','${numOfCorrectAns * 10}', Get.find<AuthController>().user.uid);
    }
  }

  void onlineNextQuestion() {
    if (databaseQuestions == null) return;
    if (_questionNumber.value != databaseQuestions!.length + 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 50), curve: Curves.easeIn);
    }
  }

  void onlinePreviousQuestion() {
    if (_questionNumber.value != 1) {
      _pageController.previousPage(duration: Duration(milliseconds: 50), curve: Curves.easeIn);
    }
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      if (!_isAnswered) {
        skipped.value++;
      }
      _isAnswered = false;
      //_pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.ease);
      _pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.easeIn);

      //reset counter
      cooldownReset();

      //then start again
      animationAssign();

      _isVisible.value = false;
    } else {
      //get package's simple navigation to another page
      Get.off(ScoreScreen());
      cooldownReset();
      /*if(!_controller.guest){
        Database().setQuizScore(
            '${numOfCorrectAns * 10}',
            Get.find<AuthController>().user.uid,
            'quiz001');
      }*/
      //Database().storeData('quiz1','${numOfCorrectAns * 10}', Get.find<AuthController>().user.uid);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void cooldownReset() {
    _animationController.reset();
  }

  void animationStop() {
    _animationController.stop();
  }

  void animationAssign() {
    _animationController.forward().whenComplete(nextQuestion);
  }

  void questReset() {
    _questionNumber.value = 1;
    _isVisible.value = false;
    _isAnswered = false;
    cooldownReset();
    _numOfCorrectAns = 0;
  }

  void printTest() {
    print("finished");
  }

  bool popValue(bool value) {
    return value;
    update();
  }

  bool hsCheck(String quizID) {
    //high score checker , finds desired quiz info score and compere
    var _updaterList = Get.find<QuizController>().quizinfo.where((i) => i.quizId == quizID).toList();
    if (_updaterList.length == 0 || int.parse(_updaterList[0].score ?? '') < (numOfCorrectAns * 10)) {
      return true;
    } else {
      return false;
    }
  }

  void getPopularQuizes() {
    popularQuizes = quizes.where((i) => i.popular == true).toList();
  }

  void resetStatus() {
    skipped.value = 0;
    correct.value = 0;
    wrong.value = 0;
    score.value = 0;
  }

  void survivalEndCheck() {
    if (wrong.value == 3) {
      Get.off(ScoreScreen());
      alreadyAnswered = false;
    }
  }

  void getQuizScreen() {
    //questReset();
    _animationController.forward().whenComplete(nextQuestion);
    Get.to(QuizScreen());
  }

  void getTheRightQuestions(String qId) {
    var rightList = allQuestion.where((i) => i.questionsId == qId).toList();
    _questions = rightList;
  }

  void getTheRightSurvivalQuestions(String qId) {
    var rightSList = survivalQuestions.where((i) => i.questionsId == qId).toList();
    activeSurvivalQuiz = qId;
    rightSList.shuffle();
    for (int i = 0; i < sModeLength; i++) {
      pSurvivalQuestions![i] = rightSList[i];
    }
  }
}
