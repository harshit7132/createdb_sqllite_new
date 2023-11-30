
import 'package:createdb_sqllite/service/database.dart';

class NotesModel{

  final int? id;
  final String title;
  final String desc;
  final String priority;

  const NotesModel({required this.id, required this.title, required this.desc, required this.priority});

  factory NotesModel.fromMap(Map<String,dynamic> resp )=> NotesModel(
    id : resp[AppDataBase.colid],
    title : resp[AppDataBase.coltitle],
    desc : resp[AppDataBase.coldesc],
    priority : resp[AppDataBase.colpriority]
  );

  Map<String,dynamic> toMap(){
    return {
      AppDataBase.colid : id,
      AppDataBase.coltitle : title,
      AppDataBase.coldesc : desc,
      AppDataBase.colpriority : priority
    };
  }
}