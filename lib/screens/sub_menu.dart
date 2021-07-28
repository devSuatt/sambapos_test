// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:sambapos_test_skills_project/controller/initialize.dart';
import 'package:sambapos_test_skills_project/widgets/decoration.dart';
import 'package:yaml/yaml.dart';

class SubMenu extends StatefulWidget {
  final int index;
  final String data;

  const SubMenu({Key? key, required this.data, required this.index}) : super(key: key);

  @override
  State<SubMenu> createState() => _SubMenuState();
}

class _SubMenuState extends State<SubMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SubMenu',
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
              future: Initialize.getDiscountSubMenus(context, widget.index),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                // List<dynamic>? subMenus = snapshot.data ?? [];
                if (snapshot.hasData) {
                  var data = loadYaml(snapshot.data.toString());
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(5),
                          decoration: boxDecoration(Colors.white, 5, Colors.red.shade700),
                          child: ListTile(
                            leading: Image.asset("assets/" + (data?[widget.index][index]['image']).toString()),
                            title: Text((data?[widget.index][index]['name']).toString()),
                            trailing: Text(
                              (data?[widget.index][index]['price']).toString() == "null"
                                  ? ""
                                  : (data?[widget.index][index]['price']).toString() + " ₺",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink[800], fontSize: 17),
                            ),
                          ),
                        );
                      });
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
