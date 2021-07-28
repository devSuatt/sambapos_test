// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sambapos_test_skills_project/controller/initialize.dart';
import 'package:sambapos_test_skills_project/models/item.dart';
import 'package:sambapos_test_skills_project/screens/sub_menu.dart';
import 'package:sambapos_test_skills_project/widgets/decoration.dart';
import 'package:yaml/yaml.dart';

class DiscountedMenu extends StatefulWidget {
  final String data;

  const DiscountedMenu({Key? key, required this.data}) : super(key: key);

  @override
  State<DiscountedMenu> createState() => _DiscountedMenuState();
}

class _DiscountedMenuState extends State<DiscountedMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'İndirimli Menüler',
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.red[600],
          title: Text("İndirimli Menüler"),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: Initialize.getMenuItemsList(context, 0),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                List<dynamic>? menuList = snapshot.data;
                if (snapshot.hasData) {
                  var data = loadYaml(snapshot.data.toString());
                  return Expanded(
                    child: ListView.builder(
                      itemCount: menuList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            decoration: boxDecoration(Colors.white, 5, Colors.red.shade700),
                            child: ExpansionTile(
                              leading: Image.asset("assets/" + Item.fromJson(data[index]).image.toString()),
                              title: Text(Item.fromJson(data[index]).name.toString()),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // Text(data[index]['subMenus'][0] ?? ""),
                                data[index]['subMenus'] != null
                                    ? subMenus(data[index]['subMenus'])
                                    : RaisedButton(
                                        onPressed: () {},
                                        child: Text("Menüyü Seç"),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget subMenus(subMenuList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: subMenuList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubMenu(index: index, data: subMenuList[index].toString())));
            },
            child: Container(
              decoration: boxDecoration(Colors.white, 8, Colors.blue),
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(3),
              child: ListTile(
                trailing: Icon(Icons.arrow_right),
                title: Text(subMenuList[index]),
              ),
            ),
          );
        });
  }
}
