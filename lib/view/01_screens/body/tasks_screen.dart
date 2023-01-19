import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/control/local/task_cubit.dart';
import 'package:to_do/control/local/task_states.dart';
import 'package:to_do/view/02_widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    return Scaffold(
      body: BlocConsumer<TaskCubit, TaskStates>(
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              /*cubit.updateRecord(
                columnName: 'id',
                valueToUpdate: '${index + 1}',
                id: cubit.tasks[index].id,
              );*/
              return TaskCard(
                taskModel: cubit.tasks[index],
                deleteOnPressed: () {
                  cubit.deleteRecord(cubit.tasks[index].id as int);
                },
                doneOnPressed: () {
                  if(cubit.tasks[index].status == 'done'){
                    cubit.updateRecord(
                      columnName: 'status',
                      valueToUpdate: 'not done',
                      id: cubit.tasks[index].id as int,
                    );
                  }
                  else{
                    cubit.updateRecord(
                      columnName: 'status',
                      valueToUpdate: 'done',
                      id: cubit.tasks[index].id as int,
                    );
                  }
                  setState((){});
                },
                archivedOnPressed: () {
                  if(cubit.tasks[index].status == 'archived'){
                    cubit.updateRecord(
                      columnName: 'status',
                      valueToUpdate: 'not done',
                      id: cubit.tasks[index].id as int,
                    );
                  }
                  else{
                    cubit.updateRecord(
                      columnName: 'status',
                      valueToUpdate: 'archived',
                      id: cubit.tasks[index].id as int,
                    );
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: cubit.tasks.length,
          );
        },
        listener: (context, state) {
          if (state is TaskInitial) {
            cubit.getDataBase();
          }
          else if (state is AppUpdateRecordState) {
            cubit.getDataBase();
          }
        },
      ),
    );
  }
}
