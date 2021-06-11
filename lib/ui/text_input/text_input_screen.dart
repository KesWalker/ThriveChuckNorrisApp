import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrive_chuck_norris_kw/repo/chuckRepo.dart';

import '../dialog_utils.dart';

class TextInputScreen extends StatelessWidget {
  final BuildContext context;

  TextInputScreen({required this.context});

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle thriveBtnStyle = ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))));

    return Scaffold(
      appBar: AppBar(
        title: Text("Text Input"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              child: TextField(
                  controller: textController,
                  decoration:
                      InputDecoration(hintText: "First & last name")),
              padding: EdgeInsets.all(32.0),
            ),
            ElevatedButton(
              onPressed: searchClick,
              child: Text("SEARCH"),
              style: thriveBtnStyle,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  void searchClick() {
    var words = textController.value.text
        .split(" ")
        .where((element) => element.trim().length > 0)
        .toList();
    if (words.length > 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please only enter your first & last name.")));
    } else if (words.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your first & last name.")));
    } else {
      var first = words[0];
      var last = words[1];
      ChuckRepo()
          .getJoke({'firstName': first, 'lastName': last})
          .then((value) => {DialogUtil.showJokeDialog(value.joke, context)})
          .catchError((e) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Sorry an error has occurred. Please try again later.")))
              });
    }
  }
}
