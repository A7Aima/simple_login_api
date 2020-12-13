import 'package:flutter/material.dart';
import 'package:simple_login_api/screens/display_screen.dart';
import 'package:simple_login_api/widgets/rectangular_button_health.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _textEmailComtroller =
      TextEditingController(text: 'eve.holt@reqres.in');
  final _textPasswordController = TextEditingController(text: 'cityslicka');
  final _formLogin = GlobalKey<FormState>();
  bool warning = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: true,
        title: Text('LOGIN'),
      ),
      body: Form(
        key: _formLogin,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                warning ? buildWarning() : Container(),
                SizedBox(height: 20),
                TextFormField(
                  controller: _textEmailComtroller,
                  decoration: buildInputDecorationEmail(),
                  validator: validateEmail,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _textPasswordController,
                  decoration: buildInputDecorationPassword(),
                  validator: validatePassword,
                  obscureText: obscureText,
                ),
                SizedBox(height: 40),
                RectangularButtonsHealth(
                  onPressed: () async {
                    if (_formLogin.currentState.validate()) {
                      print(_textEmailComtroller.text);
                      print(_textPasswordController.text);
                      String token = await postHttp(
                        email: _textEmailComtroller.text,
                        password: _textPasswordController.text,
                      );
                      print("Inside: ${token.toString()}");
                      if (token != null) {
                        print('$token');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayScreen(
                              token: token,
                            ),
                          ),
                        );
                      }

                      //_textEmailComtroller.clear();
                      //_textPasswordController.clear();
                    }
                    //print("You Didn't write anything");
                  },
                  label: "LogIn",
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('SignUp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> postHttp({String email, String password}) async {
    try {
      Response response =
          await Dio().post("https://reqres.in/api/login", data: {
        'email': email,
        "password": password,
      });
      //print(response.data['token']);
      return response.data['token'];
    } catch (e) {
      print(e);
    }
    return null;
  }

  String validateEmail(value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty || value == null) {
      changingState(true);
      return "Enter Email";
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }

    return null;
  }

  String validatePassword(value) {
    if (value.isEmpty || value == null) {
      changingState(true);
      return "Enter password";
    }
    if (value.length < 8) {
      changingState(true);
      return 'Password Is Short';
    }

    return null;
  }

  InputDecoration buildInputDecorationPassword() {
    return InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.lightBlue[100].withOpacity(0.1),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ));
  }

  InputDecoration buildInputDecorationEmail() {
    return InputDecoration(
      labelText: "Email",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      filled: true,
      fillColor: Colors.lightBlue[100].withOpacity(0.2),
    );
  }

  void changingState(bool value) {
    setState(() {
      warning = value;
    });
  }

  Container buildWarning() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.lightBlue[100].withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "For using this app",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text("Please enter your email and password"),
        ],
      ),
    );
  }
}

//  eve.holt@reqres.in
//  cityslicka
