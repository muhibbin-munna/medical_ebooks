import 'dart:io';

import 'package:medical_pdf/models/book_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String book_table = 'book_table';
  String col_id = 'id';
  String col_item_id = 'item_id';
  String col_name = 'name';
  String col_intro = 'intro';
  String col_author = 'author';
  String col_edition = 'edition';
  String col_size = 'size';
  String col_rating = 'rating';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
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
    String path = directory.path + 'books.db';
    var booksDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return booksDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $book_table($col_id INTEGER PRIMARY KEY AUTOINCREMENT, $col_item_id TEXT, $col_name TEXT,'
        '$col_intro TEXT,$col_author TEXT,$col_edition TEXT, $col_size TEXT,$col_rating TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getBookMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(book_table, orderBy: '$col_name ASC');
    return result;
  }
  Future<List<Map<String, dynamic>>> findBookMap(String itemid) async {
    Database db = await this.database;

    var result = await db.query(book_table,
        where: '$col_item_id = ?',
        whereArgs: [itemid]);
    return result;
  }
  Future<List<Book>> findBook(String itemid) async {
    var noteMapList = await findBookMap(itemid); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Book> bookList = List<Book>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      bookList.add(Book.fromMapObject(noteMapList[i]));
    }

    return bookList;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertBook(Book book) async {
    Database db = await this.database;
    var result = await db.insert(book_table, book.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateBook(Book book) async {
    var db = await this.database;
    var result = await db.update(book_table, book.toMap(),
        where: '$col_id = ?', whereArgs: [book.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteBook(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $book_table WHERE $col_id = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $book_table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }



  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Book>> getNoteList() async {
    var noteMapList = await getBookMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Book> bookList = List<Book>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      bookList.add(Book.fromMapObject(noteMapList[i]));
    }

    return bookList;
  }
}
