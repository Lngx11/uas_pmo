import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/signin.dart';
import 'package:flutter_application_1/login/signup.dart';



class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          color: Colors.white,
          width: 430,
          height: 932,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFA80303),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                  width: 430,
                  height: 418,
                ),
              ),
              Positioned(
                left: 130,
                top: 350,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 120, // Position where you want the image
                top: 330, // Position where you want the image
                child: Image.asset('aset/image 2.png', width: 150, height: 150),
                // For a network image use:
                // child: Image.network('https://example.com/example_image.png', width: 100, height: 100),
              ),
              Positioned(
                left: 138,
                top: 589,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text and icon color
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.72,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4, // Shadow depth
                  ),
                  onPressed: () {
                    // Action to perform on button press
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text('Sign Up'),
                ),
              ),
              Positioned(
                left: 144,
                top: 657,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text and icon color
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.72,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4, // Shadow depth
                  ),
                  onPressed: () {
                    // When the button is pressed, navigate to a new page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
                  },
                  child: Text('Sign In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
