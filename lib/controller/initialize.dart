// ignore_for_file: file_names, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';

class Initialize {
  static late BuildContext context;

  static Future<String> readFile(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('assets/menu.yaml');
  }

  static Future<Map> getMenus(BuildContext context) async {
    var data = await readFile(context);
    Map yaml = loadYaml(data);
    return yaml['menus'][0];
  }

  static Future<List<int>> getIndexOfSubMenus(BuildContext context, i) async {
    var data = await readFile(context);
    Map yaml = loadYaml(data);
    List<int> listOfIndex = [];
    List<dynamic> menuList = yaml['menus'];
    List<String> keysOfmenus = [];
    List<dynamic> subMenus = await getSubMenus(context, i);
    for (var menu in menuList) {
      keysOfmenus.add(menu['key'].toString());
    }
    for (var subMenu in subMenus) {
      int index = keysOfmenus.indexOf(subMenu);
      listOfIndex.add(index);
    }

    return listOfIndex;
  }

  static Future<List<dynamic>> getDiscountSubMenus(BuildContext context, int index) async {
    List<int> list = await getIndexOfSubMenus(context, index);
    List<dynamic> itemsList = [];
    for (var i in list) {
      var data = await readFile(context);
      Map yaml = loadYaml(data);
      itemsList.add(yaml['menus'][i]['items']);
    }
    return itemsList;
  }

  static Future<List<dynamic>> getMainMenuList(BuildContext context) async {
    var data = await getMenus(context);
    return data['items'];
  }

  static Future<List<dynamic>> getMenuItemsList(BuildContext context, int index) async {
    var data = await getMenus(context);
    return data['items'][index]['items'];
  }

  static Future<List<dynamic>> getSubMenus(BuildContext context, int index) async {
    var menuList = await getMainMenuList(context);
    return menuList[0]['items'][index]['subMenus'];
  }
}
