import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'AyurvedaDB.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AyurvedaDB.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'AyurvedaDB'
          '.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getCategoryDetail() async {
    Database db = await initDatabase();

    List<Map<String, dynamic>> data = await db.rawQuery('''
      SELECT 
        cd.Detail_Cat_Id,
        cd.Cat_Id,
        cd.Detail_Cat_Name,
        cd.Remark,
        cd.IsFavourite,
        c.Cat_Name_ENG as Name_ENG,
        c.Cat_Name_HIN as Name_HIN
      FROM 
        Category_Detail cd
      JOIN 
        Category c
      ON 
        cd.Cat_Id = c.Cat_Id
    ''');
    return data;
  }

  Future<List<Map<String, dynamic>>> getMedicineDetail() async {
    Database db = await initDatabase();

    List<Map<String, dynamic>> data = await db.rawQuery('''
      SELECT 
        dmd.Disease_Medicine_Detail_Id,
        dmd.Disease_Name,
        dm.Disease_Name_ENG as Name_ENG,
        dm.Disease_Name_HIN as Name_HIN,
        dmd.Discription,
        dmd.IsFavourite,
        dmd.Remarks
      FROM 
        Disease_Medicines_Detail dmd
      JOIN 
        Disease_Medicines dm
      ON 
        dmd.Disease_Id = dm.Disease_Id
    ''');

    // Now, 'data' will contain the joined results
    return data;
  }

  Future<List<Map<String, dynamic>>> getRemedies() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Remedies');
    return data;
  }

  Future<List<Map<String, dynamic>>> getSubRemedies() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.rawQuery('Sub_Cat_Remedy');
    return data;
  }

  //remedy wise
  Future<List<Map<String, dynamic>>> getSubCatRemedyDetail(int id) async{
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.rawQuery('''
      SELECT 
        scd.Sub_Cat_Remedy_Detail_Id,
        scd.Sub_Cat_Remedy_Detail_Name,
        scd.Remedy_Id,
        scd.Sub_Cat_Remedy_Id,
        scd.Description,
        scd.IsFavourite,
        scd.Remarks,
        sc.Sub_Cat_Name_ENG as Name_ENG,
        sc.Sub_Cat_Name_HIN as Name_HIN
      FROM 
        Sub_Cat_Remedy_Detail scd
      JOIN 
        Sub_Cat_Remedy sc
      ON 
        scd.Sub_Cat_Remedy_Id = sc.Sub_Cat_Remedy_Id
        where scd.Remedy_Id = ${id}
    ''');
    return data;
  }

  Future<int> updateFavouriteCategory(int id, int favourite) async {
    Database db= await initDatabase();
    Map<String, dynamic> updatedValues = {
      'IsFavourite': favourite, // Set IsFavourite to 1
    };

    int noOfRows = await db.update(
      'Category_Detail', // Table name
      updatedValues,     // New values to set
      where: 'Detail_Cat_Id = ?', // Condition for the update
      whereArgs: [id],   // Arguments for the where clause
    );
    return noOfRows;
  }

  Future<List<Map<String, dynamic>>> getCategoryDetailItem(int id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Category_Detail',where: 'Detail_Cat_Id = ?',whereArgs: [id]);
    return data;
  }

  Future<int> updateFavouriteMedicine(int id, int favourite) async {
    Database db= await initDatabase();
    Map<String, dynamic> updatedValues = {
      'IsFavourite': favourite, // Set IsFavourite to 1
    };

    int noOfRows = await db.update(
      'Disease_Medicines_Detail', // Table name
      updatedValues,     // New values to set
      where: 'Disease_Medicine_Detail_Id = ?', // Condition for the update
      whereArgs: [id],   // Arguments for the where clause
    );
    return noOfRows;
  }

  Future<List<Map<String, dynamic>>> getMedicineDetailItem(int id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Disease_Medicines_Detail',where: 'Disease_Medicine_Detail_Id = ?',whereArgs: [id]);
    return data;
  }

  Future<int> updateFavouriteSubRemedy(int id, int favourite) async {
    Database db= await initDatabase();
    Map<String, dynamic> updatedValues = {
      'IsFavourite': favourite, // Set IsFavourite to 1
    };

    int noOfRows = await db.update(
      'Sub_Cat_Remedy_Detail', // Table name
      updatedValues,     // New values to set
      where: 'Sub_Cat_Remedy_Detail_Id = ?', // Condition for the update
      whereArgs: [id],   // Arguments for the where clause
    );
    return noOfRows;
  }

  Future<List<Map<String, dynamic>>> getSubRemedyDetailItem(int id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Sub_Cat_Remedy_Detail',where: 'Sub_Cat_Remedy_Detail_Id = ?',whereArgs: [id]);
    return data;
  }

  Future<List<Map<String, dynamic>>> getFavouriteMedicine() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Disease_Medicines_Detail',where: 'IsFavourite = ?',whereArgs: [1]);
    return data;
  }

  Future<List<Map<String, dynamic>>> getFavouriteCategory() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> data = await db.query('Category_Detail',where: 'IsFavourite = ?',whereArgs: [1]);
    return data;
  }

  Future<List<Map<String, dynamic>>> getFavouriteRemedy() async {
    Database db = await initDatabase();
    //List<Map<String, dynamic>> data = await db.query('Sub_Cat_Remedy_Detail',where: 'IsFavourite = ?',whereArgs: [1]);
    // Perform the JOIN query
    List<Map<String, dynamic>> data = await db.rawQuery('''
    SELECT Sub_Cat_Remedy_Detail.*, Remedies.Remedy_Name
    FROM Sub_Cat_Remedy_Detail
    JOIN Remedies ON Sub_Cat_Remedy_Detail.Remedy_Id = Remedies.Remedy_Id
    WHERE Sub_Cat_Remedy_Detail.IsFavourite = 1
  ''');
    return data;
  }
}