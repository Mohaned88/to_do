import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/control/local/task_cubit.dart';
import 'package:to_do/control/local/task_states.dart';
import 'package:to_do/model/task_model.dart';
import 'package:to_do/view/02_widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController statusController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool bottomSheetEnabler = false;
  IconData floatingButtonIcon = Icons.task;

  @override
  void initState() {
    BlocProvider.of<TaskCubit>(context).createDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TaskCubit cubit = TaskCubit.get(context);
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {
        if (state is AppInsertTask) {
          Navigator.pop(context);
          titleController.clear();
          timeController.clear();
          dateController.clear();
          statusController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          //backgroundColor: Colors.teal,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'To-Do',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: cubit.tasks.isNotEmpty,
            builder: (BuildContext context) {
              return cubit.screens[cubit.currentIndex];
            },
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          //cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () async {
              if (cubit.isShowBottom) {
                /*bottomSheetEnabler = false;
            Navigator.pop(context);
            floatingButtonIcon = Icons.task;
            setState(() {});*/
                if (formKey.currentState!.validate()) {
                  cubit.taskModel = TaskModel(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                    status: statusController.text,
                  );
                  await cubit.insertToDb();
                }
              } else {
                // bottomSheetEnabler = true;
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        //color: Colors.indigoAccent,
                        height: size.height * 0.5,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  hintText: "Title",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Title Should not be empty";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: dateController,
                                  keyboardType: TextInputType.text,
                                  hintText: "Date",
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2023-12-20'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Date Should not be empty";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: timeController,
                                  keyboardType: TextInputType.text,
                                  hintText: "Time",
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text = TimeOfDay(
                                              hour: value!.hour,
                                              minute: value.minute)
                                          .format(context);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Time Should not be empty";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  controller: statusController,
                                  keyboardType: TextInputType.text,
                                  hintText: "Status",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Status Should not be empty";
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.teal,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheet(
                    isShowBottom: false,
                    icon: Icons.edit,
                  );
                });
                cubit.changeBottomSheet(
                  isShowBottom: true,
                  icon: Icons.done,
                );
                /*  floatingButtonIcon = Icons.done;
            setState(() {});*/

              }
            },
            child: Icon(cubit.icon, color: Colors.white, size: 30),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.teal,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "Task",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: "Done",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: "Archived",
              ),
            ],
          ),
        );
      },
    );
  }
}
