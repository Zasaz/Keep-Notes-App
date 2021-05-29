import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_notes/Helper/images.dart';
import 'package:keep_notes/Helper/strings.dart';
import 'package:keep_notes/Services/google_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashData();
  }
}

class SplashData extends StatefulWidget {
  @override
  _SplashDataState createState() => _SplashDataState();
}

class _SplashDataState extends State<SplashData> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(Images.notes),
              ),
              InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [Colors.grey.shade800, Colors.grey.shade800]),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 55.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                            image: AssetImage(Images.google),
                            width: 20.0,
                            height: 20),
                        SizedBox(width: 20.0),
                        Text(
                          Strings.google,
                          style: GoogleFonts.alegreya(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    signInWithGoogle(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
