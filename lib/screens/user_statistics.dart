import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';

//Text("${_controller.survivalScores[0]}",style: TextStyle(fontSize: 20)), // TODO NAMAZ KİTABI SURVİVAL
/*Row( //TODO ALL STARS
                                children: [
                                  Icon(Icons.star_rounded,color: Colors.yellow,size: 40,),
                                  SizedBox(width: 10,),
                                  Text("${_controller.quizesScoresSum} / ${_controller.quizesScores.length*3}",style: TextStyle(fontSize: 20),)
                                ],
                              ),*/
//Text("${_controller.quizesScores[0]+_controller.quizesScores[1]+_controller.quizesScores[2]} / 9"), // TODO NAMAZ KİTABI YILDIZLAR

class UserStatistics extends GetWidget<AuthController> {
  const UserStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    //AuthController _aController = Get.put(AuthController());
    QuestionController questionController = Get.find<QuestionController>();
    //AuthController _aController = Get.put(AuthController());
    questionController.getOnlineQuizesScoreData();

    return Scaffold(
      extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        title: Text('İstatistikler'),
        centerTitle: true,
      ),*/
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height: 285,
                  color: const Color(0xFF4c03a2),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(questionController.quizesScoresSum * 10 + questionController.survivalScoresSum + questionController.onlineQuizScore.value)}",
                        style: const TextStyle(
                            color: Color(0xFFDFDFDF), fontSize: 45),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Geçen Hafta",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("- Puan",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("(-.Sıra)",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Bu Hafta",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("- Puan",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("(-.Sıra)",
                                  style: TextStyle(color: Color(0xFFDFDFDF))),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "${(questionController.quizesScoresSum * 10 + questionController.survivalScoresSum) ~/ 50}",
                              style: const TextStyle(
                                  color: Color(0xFFDFDFDF), fontSize: 50)),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/diamondIcon.png",
                            width: 35,
                            height: 35,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFFfcb075),
                                Color(0xFFfed083),
                              ],
                              begin: FractionalOffset(0.5, 1.0),
                              end: FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Hayatta Kalma ${questionController.survivalScoresSum} Puan",
                          style: const TextStyle(
                            color: Color(0xFFDFDFDF),
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                blurRadius: 50.0,
                                color: Colors.black87,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFFfd5d8c),
                                Color(0xFFfd78a3),
                              ],
                              begin: FractionalOffset(0.5, 1.0),
                              end: FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Klasik Testler ${questionController.quizesScoresSum * 10} Puan",
                          style: const TextStyle(
                            color: Color(0xFFDFDFDF),
                            fontSize: 20,
                            shadows: [
                              Shadow(
                                blurRadius: 50.0,
                                color: Colors.black87,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8260f6),
                                Color(0xFFaa81fb),
                              ],
                              begin: FractionalOffset(0.5, 1.0),
                              end: FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Obx(
                          () => Text(
                            "Yarışma Dereceleri ${questionController.onlineQuizScore.value} Puan",
                            style: const TextStyle(
                              color: Color(0xFFDFDFDF),
                              fontSize: 20,
                              shadows: [
                                Shadow(
                                  blurRadius: 50.0,
                                  color: Colors.black87,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        // provides clickable and cool click animation
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          //margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
