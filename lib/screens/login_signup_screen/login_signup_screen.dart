import 'package:flutter/material.dart';
import 'package:movieapp2/style/colors.dart';

import '../../bloc/theme_bloc/theme_controller.dart';
import '../../repositories/movie_repository.dart';
import '../main_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key, required this.themeController, required this.movieRepository}) : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {

  bool isSignupScreen = true;
  final _signUpFormKey = GlobalKey<FormState>();
  final _logInFormKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  bool _isValidate(){

    dynamic formKey = isSignupScreen? _signUpFormKey : _logInFormKey;

    final isValid = formKey.currentState!.validate();

    if(isValid) {
      formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body:  GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            //배경
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Welcome',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                                text: isSignupScreen ? ' to MOVIE APP!' : ' Back!',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )
                          ]
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      isSignupScreen ? 'Signup to Continue' : 'Login to Continue',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),

            //텍스트 폼 필드
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20.0),
                height: isSignupScreen ? 280.0 : 250.0,
                width: MediaQuery.of(context).size.width-40,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5
                      )
                    ]
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen ? CustomColors.textColor1 : CustomColors.activeColor
                                  ),
                                ),
                                if(!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen ? CustomColors.activeColor : CustomColors.textColor1,
                                  ),
                                ),
                                if(isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                      if(isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _signUpFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  key: ValueKey(1),
                                  validator: (value){
                                    if(value!.isEmpty || value!.length < 4){
                                      return 'Please enter at least 4 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userName = value!;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: CustomColors.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)
                                          )
                                      ),
                                      hintText: 'nickname',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  key: ValueKey(2),
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: CustomColors.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)
                                          )
                                      ),
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  key: ValueKey(3),
                                  validator: (value){
                                    if(value!.isEmpty || value!.length < 6){
                                      return 'Password must be at least 7 characters long';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: CustomColors.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)
                                          )
                                      ),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if(!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _logInFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  key: ValueKey(4),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: CustomColors.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)
                                          )
                                      ),
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  key: ValueKey(5),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: CustomColors.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: CustomColors.textColor1
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)
                                          )
                                      ),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: CustomColors.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),

            //전송버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 430 : 390,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if(isSignupScreen){
                        if(_isValidate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('회원가입이 정상적으로 처리되었습니다.'),
                              backgroundColor: Colors.blue,
                            )
                          );
                          setState(() {
                            isSignupScreen = false;
                          });
                        }
                      } else {
                        if(_isValidate()){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MainScreen(
                              themeController: widget.themeController,
                              movieRepository: widget.movieRepository,
                            ),
                          ));
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.white
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0,1)
                            )
                          ]
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}