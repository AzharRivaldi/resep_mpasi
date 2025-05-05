import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class ModelHome {
  final String? strRecipesId;
  final String? strNameMenu;
  final String? strInstruction;
  final String? strImageMenu;
  final String? strTime;
  final String? strServings;
  final String? strCalories;
  final String? strIngredients;

  ModelHome({
    this.strRecipesId,
    this.strNameMenu,
    this.strInstruction,
    this.strImageMenu,
    this.strTime,
    this.strServings,
    this.strCalories,
    this.strIngredients
  });

  Future<List<ModelHome>> getListData({String? strCategories}) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'mpasibayi.db');

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join('assets', 'mpasibayi.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    final database = await openDatabase(path, version: 1);
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM recipes WHERE category_id = '${strCategories!}'");
    return List.generate(maps.length, (i) {
      return ModelHome(
        strRecipesId: maps[i]['id'].toString(),
        strNameMenu: maps[i]['name'],
        strInstruction: maps[i]['instruction'],
        strImageMenu: maps[i]['image'],
        strTime: maps[i]['time'].toString(),
        strServings: maps[i]['servings'].toString(),
        strCalories: maps[i]['calories'].toString(),);
    });
  }

  Future<List<ModelHome>> getRecipes({String? strRecipesId}) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'mpasibayi.db');

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join('assets', 'mpasibayi.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    final database = await openDatabase(path, version: 1);
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT name FROM ingredients WHERE recipe_id = '${strRecipesId!}'");
    return List.generate(maps.length, (i) {
      return ModelHome(
          strIngredients: maps[i]['name'].toString());
    });
  }
}
