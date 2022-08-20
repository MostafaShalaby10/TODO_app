import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/blocks/states.dart';
import 'package:tasks_app/other/components.dart';
import 'package:tasks_app/pages/archive.dart';
import 'package:tasks_app/pages/done.dart';
import 'package:tasks_app/pages/tasks.dart';

class cub extends Cubit<states> {
  cub() : super(initil());

  static cub get(context) => BlocProvider.of(context);
  List pages = [task(), done(), archive()];
  List title = ["tasks", "done", "archived"];

  int current_index = 0;
  bool isshow = false;

  IconData ficcon = Icons.edit;

  void switchpages(int value) {
    current_index = value;
    emit(changepages());
  }

  void opensheet({required bool isshown, required IconData icon}) {
    isshow = isshown;
    ficcon = icon;
    emit(sheet());
  }

  String dbName = "TODO";
  List<Map> tasks = [];

  List<Map> dones = [];

  List<Map> archives = [];

  String tableName = "Tasks";

  int version_code = 1;
  Database? data;

  void createdb() async {
    await openDatabase(dbName, version: version_code,
        onCreate: (database, version) {
      database
          .execute(
              "create table $tableName (id integer primary key , name text , date text , time text , status text)")
          .then((value) {
        print("database create successfully");
      }).catchError((onError) {
        print("error in create database");
      });
    }, onOpen: (database) {
      print("database opend successfully");
      getdata(database);
    }).then((value) {
      data = value;
      emit(createdatabase());
    });
  }

  insert({
    required String name,
    required String date,
    required String time,
  }) async {
    await data?.transaction((txn) async {
      await txn
          .rawInsert(
              "insert into $tableName (name , date , time , status) values ('$name' ,  '$date' , '$time', 'new')")
          .then((value) {
        print("Insert successfully");
        emit(insertdata());
        getdata(data);
      }).catchError((onError) {
        print("Insert failed");
      });
      return null;
    });
  }

  void getdata(database) {
    tasks = [];
     dones = [];
     archives = [];
    emit(gettdata());
    database.rawQuery('SELECT * FROM $tableName').then((value) {
value.forEach((element) {
  if(element['status'] == 'new')
    tasks.add(element);
  else if(element['status'] == 'done')
    dones.add(element);
  else archives.add(element);
}) ;
      emit(gettdata());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    data?.rawUpdate(
      'UPDATE $tableName SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getdata(data);
      emit(updatetdata());
    });
  }



  void delete({
    required int id,
  }) async {
    data?.rawUpdate(
      'DELETE FROM $tableName  WHERE id = ?',
      [ id],
    ).then((value) {
      getdata(data);
      emit(deletetdata());
    });
  }
}
