// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, deprecated_member_use, unused_label

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sambapos_test_skills_project/controller/initialize.dart';
import 'package:sambapos_test_skills_project/models/item.dart';
import 'package:sambapos_test_skills_project/widgets/decoration.dart';
import 'package:yaml/yaml.dart';

class MainMenuContent extends StatefulWidget {
  final String data;
  final int index;

  const MainMenuContent({Key? key, required this.data, required this.index}) : super(key: key);

  @override
  State<MainMenuContent> createState() => _MainMenuContentState();
}

class _MainMenuContentState extends State<MainMenuContent> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menüler',
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.red[600],
          title: Text(widget.data),
        ),
        body: Center(
          child: Container(
            child: FutureBuilder(
              future: Initialize.getMenuItemsList(context, widget.index),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                List<dynamic>? menuList = snapshot.data;
                if (snapshot.hasData) {
                  var data = loadYaml(snapshot.data.toString());
                  return GridView.builder(
                    gridDelegate: gridDelegateDecoration(72),
                    itemCount: menuList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => isSelected = !isSelected);
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: boxDecoration(isSelected ? Colors.yellow.shade100 : Colors.white, 15, Colors.red.shade600),
                          child: Column(
                            children: [
                              mainMenuImage(context, "assets/" + Item.fromJson(data[index]).image.toString()),
                              SizedBox(
                                height: 60,
                                child: mainMenuTitle(Item.fromJson(data[index]).name.toString(), 14),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    data[index]['price'].toString() + " ₺",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink[800], fontSize: 17),
                                  ),
                                  RaisedButton(child: Text("SEÇ"), onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
