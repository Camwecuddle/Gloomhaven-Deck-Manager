import 'package:GHDeckCalculator/spellweaver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GH Deck Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

        primaryColor: Colors.white,

        disabledColor: Colors.grey[200],

        backgroundColor: Colors.white,

        buttonColor: Colors.white,

        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          disabledColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),

        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
            fontSize: 100,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
            fontSize: 40,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),

        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Choose Character'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _deckSize = 0;

  @override
  Widget build(BuildContext context) {
    // To stop the orienttion from flipping for now, because I haven't implemented sideways view
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridView.count(
          padding: EdgeInsets.all(30),
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          children: [
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Spellweaver(8)),
                  );
                }),
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {}),
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {}),
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {}),
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {}),
            RaisedButton(
                child: Image(image: AssetImage('images/spellweaver.png')),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
