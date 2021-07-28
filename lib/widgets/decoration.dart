// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

BoxDecoration boxDecoration(Color boxColor, double radius, Color borderColor) {
  return BoxDecoration(
    color: boxColor,
    border: Border.all(color: borderColor, width: 0.8),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

Widget mainMenuImage(BuildContext context, String imagePath) {
  return GestureDetector(
    onTap: () => showDialogPitcureDetail(context, imagePath),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget mainMenuTitle(String title, double fontSize) {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.all(8),
    child: Text(
      title,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    ),
  );
}

SliverGridDelegateWithMaxCrossAxisExtent gridDelegateDecoration(double ratio) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: ratio / 100,
    crossAxisSpacing: 1,
    mainAxisSpacing: 20,
  );
}

showDialogPitcureDetail(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          "",
          style: TextStyle(color: Theme.of(context).primaryColor),
          textAlign: TextAlign.center,
        ),
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red.shade700,
                child: Text(
                  "KAPAT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
