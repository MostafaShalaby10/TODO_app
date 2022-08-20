// import 'package:sqflite/sqflite.dart';
// import 'package:tasks_app/other/components.dart';
//
// class DB {
//   String dbName = "TODO";
//
//   String tableName = "Tasks";
//
//   int version_code = 1;
//   Database? data;
//
//   void createdatabase() async {
//     data = await openDatabase(dbName, version: version_code,
//         onCreate: (database, version) {
//       database
//           .execute(
//               "create table $tableName (id integer primary key , name text , date text , time text)")
//           .then((value) {
//         print("database create successfully");
//       }).catchError((onError) {
//         print("error in create database");
//       });
//     }, onOpen: (database) {
//       print("database opend successfully");
//       getdata(database).then((value)
//       {
//         tasks = value ;
//         print(tasks) ;
//         print(tasks.length) ;
//       }) ;
//         });
//   }
//
//   Future insertindatabase(
//   {
//   required String name ,
//   required String time ,
//   required String date
//
// }
//       ) async {
//     return await data?.transaction((txn) async {
//       await txn.
//       rawInsert("insert into $tableName (name , date , time) values ('$name' ,  '$date' , '$time')").then((value)
//       {
// print("Insert successfully") ;
//       }).catchError((onError){
//         print("Insert failed") ;
//
//       });
//     });
//   }
//
// Future<List<Map>> getdata(data) async
// {
//     return await data?.rawQuery("select * from $tableName") ;
// }
//
// }
