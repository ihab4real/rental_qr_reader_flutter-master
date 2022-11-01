import 'package:flutter/material.dart';
import 'package:qr_reader/ScanChoicesPage.dart';
import 'package:qr_reader/components/RoundedButton.dart';
import 'package:qr_reader/constants.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({Key? key}) : super(key: key);

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
  Future<void> login() async {
    final route = MaterialPageRoute(builder: (context) => ScanChoicesPage());
    Navigator.of(context).pushReplacement(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(8.0),
                        child:
                            Image(image: AssetImage("images/rental_logo.png"))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Righteous',
                            color: gSecondaryTextColor,
                          ),
                        ),
                        Text(
                          "Welcome to RentLee app",
                          style: TextStyle(
                            color: gSecondaryTextColor,
                            fontFamily: "RussoOne",
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              RoundedButton(
                text: "Login",
                onPressed: login,
                color: gDarkPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}