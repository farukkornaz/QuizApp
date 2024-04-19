import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/constants.dart';
import 'package:quiz_test_app/controllers/auth_controller.dart';
import 'package:quiz_test_app/controllers/question_controller.dart';
import 'package:quiz_test_app/controllers/slider_controller.dart';
import 'package:quiz_test_app/screens/pass_reset_screen.dart';
import 'package:quiz_test_app/screens/signup.dart';
import 'package:quiz_test_app/screens/welcome_screen.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SliderController sController = SliderController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: kLightPurple,
        /*appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),*/
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: kLightPurple,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/app_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    /*SizedBox(height: 20,),
                    Text(
                      'BİLGİ YARIŞMASI',style: TextStyle(color: Colors.purple,fontSize: 30),
                    ),*/
                    //SizedBox(height: 20,),
                    /*Obx((){
                      return Text('User : '
                          '${
                          (Get.find<AuthController>().user != null)
                          ? Get.find<AuthController>().user.email
                          : 'Null'
                      }'
                      );
                    }),*/
                    Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() {
                          return TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.purple,
                                ),
                                onPressed: () => controller.showOrHide(),
                              ),
                              //fillColor: Colors.blueAccent,
                              hintText: 'Şifre',
                              labelText: 'Şifre',
                            ),
                            controller: passwordController,
                            obscureText: controller.showHide.value,
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.login(emailController.text, passwordController.text);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text(
                              "Giriş",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(WelcomeScreen() ,transition: Transition.cupertino); // transition effect
                            controller.guest = true;
                            sController.current.value = 0;
                            Get.find<QuestionController>().getQuizesScores();
                            emailController.clear();
                            passwordController.clear();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.purple),
                              color: kLightPurple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text(
                              "Misafir Girişi",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
                            )),
                          ),
                        ),
                        /*ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: double.infinity,height: 50),
                          child:ElevatedButton(onPressed: (){
                            Get.to(WelcomeScreen()/*,transition: Transition.cupertino*/); // transition effect
                            controller.guest = true;
                            sController.current.value = 0;
                            Get.find<QuestionController>().getQuizesScores();
                            emailController.clear();
                            passwordController.clear();
                          }, child: Text('Misafir Giriş'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              minimumSize: Size.infinite,
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(Signup());
                            },
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(color: Colors.purple, fontSize: 16),
                            )),
                        TextButton(
                          onPressed: () {
                            Get.to(PassResetScreen());
                          },
                          child: Text(
                            'Şifremi Unuttum',
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
