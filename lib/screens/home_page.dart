import 'package:flutter/material.dart';
import 'package:simple_login_api/screens/login_page.dart';
import 'package:simple_login_api/widgets/rectangular_button_health.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset("assets/heart.png"),
                ),
                Text(
                  "Healthy Corp.",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Image.asset('assets/holding_hand.jpg'),
            Text(
              "A health care app for family.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "A unique platform where people and doctors come under same umbrella. Search and book a doctor with a tap of button.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            RectangularButtonsHealth(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              label: "Log In",
            ),
            RectangularButtonsHealth(
              onPressed: () {},
              label: "Create Account",
            ),
          ],
        ),
      ),
    );
  }
}
