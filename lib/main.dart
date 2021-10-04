import 'package:catvsdog/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CatyDogy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySplash(),
    );
  }
}


class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    /*
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: MyHomePage(title: "CatyDoGy App",),
      image: Image.asset("assets/images/logo.png"),
      backgroundColor: Colors.blueGrey,
      photoSize: 60,
      loaderColor: Colors.redAccent,
      title: Text("CatyDogy", style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),),
    );
    */
    return SplashScreenView(
      navigateRoute: MyHomePage(title: "CatyDoGy",),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/logo.png",
      backgroundColor: Colors.blueGrey,
      text: "CatyDoGy",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
    );
  }
}
