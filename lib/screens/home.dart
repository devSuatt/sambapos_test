// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sambapos_test_skills_project/controller/initialize.dart';
import 'package:sambapos_test_skills_project/models/item.dart';
import 'package:sambapos_test_skills_project/screens/main_menu_content.dart';
import 'package:sambapos_test_skills_project/screens/discounted_menu.dart';
import 'package:sambapos_test_skills_project/widgets/decoration.dart';
import 'package:yaml/yaml.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text('SambaPos Test'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Initialize.getMainMenuList(context),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            List<dynamic>? menuList = snapshot.data;
            if (snapshot.hasData) {
              var data = loadYaml(snapshot.data.toString());
              return GridView.builder(
                gridDelegate: gridDelegateDecoration(92),
                itemCount: menuList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:() => menuPageRoute(index, data),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: boxDecoration(Colors.white, 15, Colors.red.shade600),
                      child: Column(
                        children: [
                          mainMenuImage(context, "assets/" + Item.fromJson(data[index]).image.toString()),
                          mainMenuTitle(Item.fromJson(data[index]).name.toString(), 16),
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
    );
  }

  void menuPageRoute(index, data) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountedMenu(data: Item.fromJson(data[index]).name.toString(),)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainMenuContent(data: Item.fromJson(data[index]).name.toString(), index: index)));
    }
  }
}
