import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
//import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    //TODO: kullancının bilgileri skor ekranında gozuksun
    //AuthController _aController = Get.find<AuthController>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.purpleAccent,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Image.asset((() {
                      if (!_qnController.survivalActive && !_qnController.onlineActive) {
                        if (_qnController.correct * 3 <= _qnController.questions.length) {
                          return 'assets/images/madalyalar/bronze_medal.png';
                        } else if (_qnController.correct < _qnController.questions.length) {
                          return 'assets/images/madalyalar/silver_medal.png';
                        } else
                          return 'assets/images/madalyalar/gold_medal.png';
                      } else {
                        if (_qnController.correct * 3 <= _qnController.survivalQuestions.length) {
                          return 'assets/images/madalyalar/bronze_medal.png';
                        } else if (_qnController.correct < _qnController.survivalQuestions.length) {
                          return 'assets/images/madalyalar/silver_medal.png';
                        } else
                          return 'assets/images/madalyalar/gold_medal.png';
                      }
                    })()),
                  ),
                  //child: Image.asset(name),
                ),
                Expanded(
                  flex: 3,
                  child: getWidget(context),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding * 1.5),
                    child: InkWell(
                      // provides clickable and cool click animation
                      onTap: () {
                        if (_qnController.survivalActive) {
                          /*if(!_aController.guest){
                            Database().storeQuizResultDB(_qnController.activeSurvivalQuiz,_qnController.correct.value*10,_aController.user.uid);
                            _qnController.getLocalDataHighScore();
                          }else{
                            _qnController.storeLocalDataHighScore(_qnController.correct.value*10,_qnController.activeSurvivalQuiz);
                            _qnController.getLocalDataHighScore();
                          }*/
                          _qnController.storeLocalDataHighScore(
                              _qnController.correct.value * 10, _qnController.activeSurvivalQuiz ?? '');
                          _qnController.getLocalDataHighScore();

                          _qnController.survivalActive = false;
                        } else {
                          /*if(!_aController.guest){
                            if(_qnController.questions.length == _qnController.correct.value)
                              Database().storeQuizResultDB(_qnController.activeQuiz.toString(),3,_aController.user.uid);
                            else if(_qnController.questions.length/_qnController.correct.value >= 1 && _qnController.questions.length/_qnController.correct.value <= 2)
                              Database().storeQuizResultDB(_qnController.activeQuiz.toString(),2,_aController.user.uid);
                            else if (_qnController.correct.value == 0){}
                            else
                              Database().storeQuizResultDB(_qnController.activeQuiz.toString(),1,_aController.user.uid);
                          }
                          else{
                            if(_qnController.questions.length == _qnController.correct.value)
                              _qnController.storeLocalQuizesScore(3, _qnController.activeQuiz);
                            else if(_qnController.questions.length/_qnController.correct.value >= 1 && _qnController.questions.length/_qnController.correct.value <= 2)
                              _qnController.storeLocalQuizesScore(2, _qnController.activeQuiz);
                            else if (_qnController.correct.value == 0){}
                            else
                              _qnController.storeLocalQuizesScore(1, _qnController.activeQuiz);
                          }*/
                          if (_qnController.questions.length == _qnController.correct.value)
                            _qnController.storeLocalQuizesScore(3, _qnController.activeQuiz!);
                          else if (_qnController.questions.length / _qnController.correct.value >= 1 &&
                              _qnController.questions.length / _qnController.correct.value <= 2)
                            _qnController.storeLocalQuizesScore(2, _qnController.activeQuiz!);
                          else if (_qnController.correct.value == 0) {
                          } else
                            _qnController.storeLocalQuizesScore(1, _qnController.activeQuiz!);

                          _qnController.activeQuiz = 0;
                        }
                        _qnController.getQuizesScores();
                        _qnController.questReset();
                        _qnController.resetStatus();
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                            gradient: kPrimaryGradient, borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: AutoSizeText('Ana sayfa',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Toplam Skor', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.purple)),
        SizedBox(
          height: 10,
        ),
        Text(
            '${Get.find<QuestionController>().numOfCorrectAns * 10}${Get.find<QuestionController>().survivalActive ? " " : " / ${Get.find<QuestionController>().questions.length * 10}"}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.purple)),
      ],
    );
  }
}
