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
    QuestionController _controller = Get.put(QuestionController());
    AuthController _aController = Get.put(AuthController());
    _controller.getOnlineQuizesScoreData();
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
                  color: Color(0xFF4c03a2),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(_controller.quizesScoresSum * 10 + _controller.survivalScoresSum + _controller.onlineQuizScore.value)}",
                        style: TextStyle(color: Color(0xFFDFDFDF), fontSize: 45),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Geçen Hafta", style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("- Puan", style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("(-.Sıra)", style: TextStyle(color: Color(0xFFDFDFDF))),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Bu Hafta", style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("- Puan", style: TextStyle(color: Color(0xFFDFDFDF))),
                              Text("(-.Sıra)", style: TextStyle(color: Color(0xFFDFDFDF))),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${(_controller.quizesScoresSum * 10 + _controller.survivalScoresSum) ~/ 50}",
                              style: TextStyle(color: Color(0xFFDFDFDF), fontSize: 50)),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/diamondIcon.png",
                            width: 35,
                            height: 35,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: new LinearGradient(
                              colors: [
                                const Color(0xFFfcb075),
                                const Color(0xFFfed083),
                              ],
                              begin: const FractionalOffset(0.5, 1.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Hayatta Kalma ${_controller.survivalScoresSum} Puan",
                          style: TextStyle(
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: new LinearGradient(
                              colors: [
                                const Color(0xFFfd5d8c),
                                const Color(0xFFfd78a3),
                              ],
                              begin: const FractionalOffset(0.5, 1.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Klasik Testler ${_controller.quizesScoresSum * 10} Puan",
                          style: TextStyle(
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
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: new LinearGradient(
                              colors: [
                                const Color(0xFF8260f6),
                                const Color(0xFFaa81fb),
                              ],
                              begin: const FractionalOffset(0.5, 1.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: Obx(
                          () => Text(
                            "Yarışma Dereceleri ${_controller.onlineQuizScore.value} Puan",
                            style: TextStyle(
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
                      SizedBox(
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
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(50))),
                          child: Icon(
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
