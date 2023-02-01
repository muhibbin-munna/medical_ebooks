import 'dart:io';
import 'package:medical_pdf/models/last_read_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LastReadDatabaseHelper {
  static LastReadDatabaseHelper _databaseHelper;
  static Database _database;
  String last_read_table = 'last_read';
  String col_id = 'id';
  String col_item_id = 'item_id';
  String col_page_no = "page_no";


  LastReadDatabaseHelper._createInstance();

  factory LastReadDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = LastReadDatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'last_read.db';
    var booksDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return booksDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $last_read_table($col_id INTEGER PRIMARY KEY AUTOINCREMENT, $col_item_id TEXT, $col_page_no INTEGER)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getBookMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(last_read_table);
    return result;
  }
  Future<List<Map<String, dynamic>>> findBookMap(String itemid) async {
    Database db = await this.database;

    var result = await db.query(last_read_table,
        where: '$col_item_id = ?',
        whereArgs: [itemid]);
    return result;
  }
  Future<List<LastRead>> findBook(String itemid) async {
    var noteMapList = await findBookMap(itemid); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<LastRead> bookList = List<LastRead>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      bookList.add(LastRead.fromMapObject(noteMapList[i]));
    }

    return bookList;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertBook(LastRead lastRead) async {
    Database db = await this.database;
    var result = await db.insert(last_read_table, lastRead.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateBook(LastRead lastRead) async {
    var db = await this.database;
    var result = await db.update(last_read_table, lastRead.toMap(),
        where: '$col_id = ?', whereArgs: [lastRead.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteBook(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $last_read_table WHERE $col_id = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $last_read_table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }



  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<LastRead>> getNoteList() async {
    var noteMapList = await getBookMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<LastRead> lastRreadList = List<LastRead>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      lastRreadList.add(LastRead.fromMapObject(noteMapList[i]));
    }

    return lastRreadList;
  }
}
