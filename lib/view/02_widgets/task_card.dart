import 'package:flutter/material.dart';
import 'package:to_do/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback? doneOnPressed;
  final VoidCallback? archivedOnPressed;
  final VoidCallback? deleteOnPressed;

  const TaskCard({
    Key? key,
    required this.taskModel,
    this.doneOnPressed,
    this.archivedOnPressed,
    this.deleteOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Center(child: Text(taskModel.time)),
          backgroundColor: Colors.teal,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskModel.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                taskModel.date,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: doneOnPressed,
              icon: Icon(
                Icons.check_box,
                size: 30,
                color: taskModel.status == 'done'? Colors.teal : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: archivedOnPressed,
              icon:  Icon(
                Icons.archive_outlined,
                size: 30,
                color: taskModel.status == 'archived'? Colors.teal : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: deleteOnPressed,
              icon: const Icon(
                Icons.delete_rounded,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
    /*  ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Text(taskModel.time),
      ),
      title: Text(taskModel.title,overflow: TextOverflow.ellipsis,maxLines: 1),
      subtitle: Text(taskModel.time,overflow: TextOverflow.ellipsis,maxLines: 1),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_box),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
    );*/
  }
}
