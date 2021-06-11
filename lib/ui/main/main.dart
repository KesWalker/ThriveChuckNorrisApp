import 'package:flutter/material.dart';
import 'package:thrive_chuck_norris_kw/repo/chuckRepo.dart';
import 'package:thrive_chuck_norris_kw/ui/dialog_utils.dart';
import 'package:thrive_chuck_norris_kw/ui/text_input/text_input_screen.dart';
import '../never_ending/never_ending_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Chuck Norris App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle thriveBtnStyle = ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: randomJokeClick,
              child: Text("RANDOM JOKE"),
              style: thriveBtnStyle,
            ),
            ElevatedButton(
              onPressed: textInputClick,
              child: Text("TEXT INPUT"),
              style: thriveBtnStyle,
            ),
            ElevatedButton(
              onPressed: neverEndingClick,
              child: Text("NEVER-ENDING JOKES"),
              style: thriveBtnStyle,
            ),
          ],
        ),
      ),
    );
  }

  randomJokeClick() async {
    ChuckRepo()
        .getJoke({
          'exclude': ['explicit']
        })
        .then((value) => {DialogUtil.showJokeDialog(value.joke, context)})
        .catchError((e) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Sorry an error has occurred. Please try again later.")))
            });
  }

  textInputClick() {
    Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => TextInputScreen(context: ctx)));
  }

  neverEndingClick() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => NeverEndingJokesList(
                  repo: ChuckRepo(),
                )));
  }
}
