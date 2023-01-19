import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../control/local/task_cubit.dart';
import '../../../control/local/task_states.dart';
import '../../02_widgets/task_card.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    return Scaffold(
      body: BlocConsumer<TaskCubit, TaskStates>(
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              return TaskCard(
                taskModel: cubit.doneTasks[index],
                deleteOnPressed: () {
                  cubit.deleteRecord(cubit.doneTasks[index].id as int);
                },
                doneOnPressed: () {
                  cubit.updateRecord(
                    columnName: 'status',
                    valueToUpdate: 'done',
                    id: cubit.doneTasks[index].id as int,
                  );
                },
                archivedOnPressed: () {
                  cubit.updateRecord(
                    columnName: 'status',
                    valueToUpdate: 'archived',
                    id: cubit.doneTasks[index].id as int,
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: cubit.doneTasks.length,
          );
        },
        listener: (context, state) {
          if (state is TaskInitial) {
            cubit.getDataBase();
          }
        },
      ),
    );
  }
}