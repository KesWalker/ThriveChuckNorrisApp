import 'package:flutter/material.dart';

class DialogUtil{
  static showJokeDialog(String joke, BuildContext context){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Joke:"),
          content: Text(joke),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ));
  }
}