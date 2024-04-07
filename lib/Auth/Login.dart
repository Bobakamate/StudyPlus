import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: MediaQuery.of(context).size.height * 0.20),
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Mot de passe",
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(200, 50),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "Home");
                    },
                    child: Text(
                      "connexion",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 1,
                  width: MediaQuery.of(context).size.width - 100,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pas de compte ? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "SignUp");
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Transform.rotate(
                angle: 49 * 3.14 / 180,
                child: Image.asset(
                  "assets/images/bg_liquid.png",
                  height: 200,
                  width: 200,
                ),
              )),
          Positioned(
              bottom: -10,
              right: 0,
              child: Transform.rotate(
                angle: 20 * 3.14 / 180,
                child: Image.asset(
                  "assets/images/bg_liquid.png",
                  height: 200,
                  width: 200,
                ),
              ))
        ],
      ),
    );
  }
}
