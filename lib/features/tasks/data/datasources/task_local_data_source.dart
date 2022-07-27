import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/error/exception.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<Unit> initialDb();
  Future<List<TaskModel>> getTasks();
  Future<Unit> createTask(TaskModel task);
  Future<Unit> updateTask(TaskModel task);
  Future<Unit> deleteTask(int taskId);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static Database? db;
  static const String _tableName = 'tasks';
  static const int _version = 1;

  static Future<void> inttDb() async {
    if (db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        // open the database
        String _path = await getDatabasesPath() + ' tasks.db';
        db = await openDatabase(
          _path,
          version: _version,
          onCreate: (Database db, int version) async {
            print('Creating a new one');
            return await db.execute(
              'CREATE TABLE $_tableName('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,'
              'isCompleted INTEGER,'
              'isFavorites INTEGER,'
              'date STRING,'
              'startTime STRING,'
              'endTime STRING,'
              'color INTEGER,'
              'remind INTEGER,'
              'repeat STRING )',
            );
          },
        );
        debugPrint('open the database With static db');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Future<Unit> initialDb() async {
    if (db != null) {
      debugPrint('db is not null');
      return Future.value(unit);
    } else {
      String _path = await getDatabasesPath() + 'tasks.db';
      db = await openDatabase(_path, version: _version, onCreate: _onCreate);
      if (db!.isOpen) {
        debugPrint('db is opened');
        return Future.value(unit);
      } else {
        debugPrint('db is not opened');
        throw DataBaseException();
      }
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    debugPrint('getTasks called');
    return await db!.query(_tableName).then((rows) {
      debugPrint('getTasks called success');
      return rows.map((row) {
        return TaskModel.fromJson(row);
      }).toList();
    }).catchError((error) {
      debugPrint('getTasks called error');
      throw EmptyDataBaseException();
    });
  }

  @override
  Future<Unit> createTask(TaskModel task) async {
    debugPrint('createTask called');
    return await db!.insert(_tableName, task.toJson()).then((_) {
      debugPrint('createTask success');
      return Future.value(unit);
    }).catchError((error) {
      debugPrint('createTask error');
      throw DataBaseException();
    });
  }

  @override
  Future<Unit> deleteTask(int taskId) async {
    debugPrint('deleteTask called');
    return await db!
        .delete(_tableName, where: 'id = ?', whereArgs: [taskId]).then((_) {
      debugPrint('deleteTask success');
      return Future.value(unit);
    }).catchError((error) {
      debugPrint('deleteTask error');
      throw DataBaseException();
    });
  }

  @override
  Future<Unit> updateTask(TaskModel task) async {
    debugPrint('updateTask called');
    return await db!.rawUpdate('''
      UPDATE $_tableName SET
      title = ?,
      isCompleted = ?,
      isFavorites = ?,
      date = ?,
      startTime = ?,
      endTime = ?,
      color = ?,
      remind = ?,
      repeat = ?
      WHERE id = ?
      
''', [
      task.title,
      task.isCompleted,
      task.isFavorites,
      task.date,
      task.startTime,
      task.endTime,
      task.color,
      task.remind,
      task.repeat,
      task.id
    ]).then((_) {
      debugPrint('updateTask success');
      return Future.value(unit);
    }).catchError((error) {
      debugPrint('updateTask error');
      throw DataBaseException();
    });
  }

  FutureOr _onCreate(Database db, int version) {
    return db.execute(
      'CREATE TABLE $_tableName('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'title STRING,'
      'isCompleted INTEGER,'
      'isFavorites INTEGER,'
      'date STRING,'
      'startTime STRING,'
      'endTime STRING,'
      'color INTEGER,'
      'remind INTEGER,'
      'repeat STRING )',
    );
  }
}
