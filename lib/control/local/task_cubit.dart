import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do/model/task_model.dart';
import 'package:to_do/view/01_screens/body/archived_screen.dart';
import 'package:to_do/view/01_screens/body/done_screen.dart';
import 'package:to_do/view/01_screens/body/tasks_screen.dart';
import 'task_states.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitial());

  static TaskCubit get(context) => BlocProvider.of(context);

  late Database database;
  late TaskModel taskModel;

  Future<void> createDb() async {
    //Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'task.db');
    print(path);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, int version) async {
        await db
            .execute("CREATE TABLE Task (id INTEGER PRIMARY KEY,"
                " title TEXT, date TEXT, time TEXT,status TEXT)")
            .then((value) => print("table created"))
            .catchError((onError) => print("error when create table $onError"));
      },
      onOpen: (db) {
        //get(db)
        //getDataBase();
        print("tasks");
      },
    );
  }

  insertToDb() async {
    await database.transaction(
      (txn) async {
        await txn
            .rawInsert('INSERT INTO Task(title,date,time,status)'
                'VALUES("${taskModel.title}",'
                '"${taskModel.date}","${taskModel.time}","${taskModel.status}")')
            .then((value) => print("insert successfully"));
        getDataBase();
        emit(AppInsertTask());
      },
    ).catchError((onError) {
      print("error when insert new record ${onError.toString()}");
    });
  }

  bool isShowBottom = false;
  IconData icon = Icons.edit;

  changeBottomSheet({required bool isShowBottom, required IconData icon}) {
    this.isShowBottom = isShowBottom;
    this.icon = icon;
    emit(AppChangeBottomState());
  }

  int currentIndex = 0;

  changeIndex(index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  List screens = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<TaskModel> tasks = [];
  List<TaskModel> doneTasks = [];
  List<TaskModel> archivedTasks = [];

  void getDataBase() async{
    tasks.clear();
    doneTasks.clear();
    archivedTasks.clear();
    //emit loading
    await database
        .rawQuery('SELECT * FROM Task')
        .then((value) {
          value.forEach((element){
            tasks.add(TaskModel.fromMap(element));
            switch(element['status']){
              case 'done':
                doneTasks.add(TaskModel.fromMap(element));
                break;
              case 'archived':
                archivedTasks.add(TaskModel.fromMap(element));
                break;
            }
          });
        });
    emit(AppGetDataBaseState());
  }

  void deleteRecord(int i) async{
    await database
        .rawDelete('DELETE FROM Task WHERE id = ?', ['$i']);
    getDataBase();
    emit(AppDeleteRecordState());
  }

  void updateRecord({required String columnName, required String valueToUpdate, required int id}) async{
    await database
        .rawUpdate('UPDATE Task SET $columnName = ? WHERE id = ?',
        [valueToUpdate, '$id']);
    emit(AppUpdateRecordState());
  }
}
