import 'package:createdb_sqllite/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{
  // Private Constructor - (Singleton)
  AppDataBase._() ;
  static final AppDataBase instance = AppDataBase._();
  // table
  static final String tablename = "notes";
  // columns
  static final String colid = "id";
  static final String coltitle = "title";
  static final String coldesc = "desc";
  static final String colpriority = "priority";


  Database? myDB;
  // Set DB Path & Create it
  Future<Database> initDB () async{
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path , "noteDB.db");

    return await openDatabase(
      dbPath,
      version: 1,
      // Create all Your Table Here
      onCreate: (db, version) async{
        return await db.execute(
            "CREATE TABLE $tablename("
            "$colid NUMERIC PRIMARY KEY AUTOINCREMENT,"
            "$coltitle TEXT NOT NULL,"
            "$coldesc TEXT NOT NULL,"
            "$colpriority TEXT NOT NULL);"
        );
      });
  }
  // Check DB & Assign It
  Future<Database> getDB() async{
    if(myDB !=null){
      return myDB!;
    }else{
      myDB = await initDB();
      return myDB!;
    }
  }

  // Insert/Add Records as per Model Class
  void insertNotes(NotesModel notesModel) async{
    var db = await getDB();
    db.insert(tablename, notesModel.toMap()  );
  }

  // Fetch All Data
  Future<List<NotesModel>>  fetchNotes() async{
    var db = await getDB();
    List<NotesModel> listNotes = [];

    var data = await db.query(tablename);

    for (Map<String,dynamic> eachdata in data ){
      NotesModel notesModel = NotesModel.fromMap(eachdata);
      listNotes.add(notesModel);
    }
    return listNotes;
  }

  void updateNotes(NotesModel updateModel) async{
    var db = await getDB();
    db.update(tablename, updateModel.toMap(),
        where: "$colid = ?", whereArgs: ["${updateModel.id}" ] );
  }

  void deleteNotes(int id) async{
    var db = await getDB();
    db.delete(tablename,
        where: "$colid = ?", whereArgs: ["${id}"]
    );
  }

}