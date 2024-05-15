import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/quiz_controller.dart';
import 'package:quiz_test_app/models/Question.dart';
import 'package:quiz_test_app/screens/online_score_screen.dart';
import 'package:quiz_test_app/screens/quiz_screen.dart';
import 'package:quiz_test_app/screens/score_screen.dart';
import 'package:quiz_test_app/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Quiz.dart';

//get is for state management



//TODO: Firebase instance olustur.


class QuestionController extends GetxController with GetTickerProviderStateMixin  {
  Database db = Database();
  
  final AuthController _controller = Get.put(AuthController());

  late AnimationController _animationController; // _variable means private type

  late Animation _animation;

  late PageController _pageController;

  List<Question>? databaseQuestions;

  /*var survivalQuestions = survival_questions.map((e) => {
    "id": e.id,
    "question": e.question,
    "options": e.options,
    "answerIndex": e.answerIndex,
  }).toList();*/
  
  //TODO: List<Quizes> _quizes ve List<Question> _questions kullanılsa iyi olur

  List<Question>? _questionss;

  List<Question>? get questionss => _questionss;

  set questionss(List<Question>? value) {
    _questionss = value;
  }

  List<Quiz>? popularQuizes;

  bool _isAnswered = false;

  bool alreadyAnswered = false;

  bool survivalActive = false;

  bool onlineActive = false;

  int? onlineTrueAnswerIndex;

  int? _onlineSelectedAnswer;

  var selectedOnlineAnswers;

  int? _correctAns;

  int? _selectedAns;

  RxInt skipped = 0.obs;
  RxInt correct = 0.obs;
  RxInt wrong = 0.obs;
  RxInt score = 0.obs;

  var prefss;

  String? activeQuizId;

  String? activeSurvivalQuiz;

  List<Question>? _pSurvivalQuestions;

  RxBool _isVisible = false.obs;

  // obs type variable , can change from another class
  RxInt _questionNumber = 1.obs;

  int _numOfCorrectAns = 0;

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

  Animation get animation => this._animation; // getter method

  PageController get pageController => this._pageController;

  int? get selectedAns => this._selectedAns;

  bool get isAnswered => this._isAnswered;

  int? get onlineSelectedAnswer => this._onlineSelectedAnswer;

  int? get correctAns => this._correctAns;

  List<Question>? get pSurvivalQuestions => this._pSurvivalQuestions;

  RxBool get isVisible => this._isVisible;

  RxInt get questionNumber => this._questionNumber;

  int get numOfCorrectAns => this._numOfCorrectAns;

  void getQuizesScores() async {
    /// Get scores of local quizes locally
    /*quizesScoresSum = 0;
    for (int i = 0; i < _quizes.length; i++) {
      quizesScores[i] = await getLocalQuizesScoreData(i);
      quizesScoresSum += quizesScores[i];
    }*/

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
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
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
          icon: const Icon(
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
      Get.off(const OnlineScoreScreen());
    }
  }

  @override
  void onInit() {
    _animationController = AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        //update like setState
        update();
      });
    //animation starter
    // after 60 sn go to next question
    //_animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    _pSurvivalQuestions = List.filled(5, Question());
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

  //TODO: kontrol edilecek
  void getOnlineQuizesScoreData() async {
    if (!_controller.guest) {
      final _data = await Database().getOnlineQuizResultDB(_controller.user?.email ?? '');
      onlineQuizScore.value = _data;
    }
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
      _correctAns = question.answerIndex;
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
    onlineTrueAnswerIndex = question.answerIndex;

    update();
  }

  void onlineSelectedReset() {
    _onlineSelectedAnswer = null;
  }

  void checkOnlineAnswers() {
    if (databaseQuestions == null) return;
    for (int i = 0; i < databaseQuestions!.length; i++) {
      if (selectedOnlineAnswers[i] == databaseQuestions![i].answerIndex) {
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
    print(":::::::::::::::::::${_pSurvivalQuestions?.length}");
    if (_questionNumber.value != _pSurvivalQuestions!.length) {
      print("surv:::: $_pSurvivalQuestions");
      _isAnswered = false;
      //_pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.ease);
      _pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
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
      _pageController.previousPage(duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
    }
  }


  //TODO: buna bakılacak
  void nextQuestion() {
    if (true/*_questionNumber.value != _questions.length*/) {
      if (!_isAnswered) {
        skipped.value++;
      }
      _isAnswered = false;
      //_pageController.nextPage(duration: Duration(milliseconds: 1), curve: Curves.ease);
      _pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.easeIn);

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

  //TODO: Bu ne?
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
    //update();
  }

  //TODO: bu ne?
  bool hsCheck(String quizID) {
    //high score checker , finds desired quiz info score and compere
    var _updaterList = Get.find<QuizController>().quizInfo.where((i) => i.quizId == quizID).toList();
    if (_updaterList.isEmpty || int.parse(_updaterList[0].score ?? '') < (numOfCorrectAns * 10)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getPopularQuizes() async{
    popularQuizes = await db.getPoplulerQuizes();
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
    Get.to(() => QuizScreen());
  }

  //TODO: quizz sorularını cek
  Future<void> getTheRightQuestions(String quizId) async{
     //List<Quiz> quizes = await db.getQuizesByCategory("4nM9V2ISVZTpFwSGPkyN");

    var quiz = await db.getQuiz(quizId);

    questionss = quiz.questions;


    //return _questionss;
    /*var rightList = allQuestion.where((i) => i.questionsId == qId).toList();
    _questions = rightList;*/
  }

  /*void getTheRightSurvivalQuestions(String qId) {
    var rightSList = survivalQuestions;
    activeSurvivalQuiz = qId;
    rightSList.shuffle();
    for (int i = 0; i < rightSList.length; i++) {
      print(rightSList[i]);
      pSurvivalQuestions![i] = Question.fromJson(rightSList[i]);
    }
  }*/
}
