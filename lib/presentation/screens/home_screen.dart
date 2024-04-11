import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/constants/size_config.dart';
import 'package:task_manger_app/domain/entities/AddTask.dart';
import 'package:task_manger_app/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:task_manger_app/presentation/cubit/delete_task/delete_task_cubit.dart';
import 'package:task_manger_app/presentation/cubit/get_todo_list/get_todo_list_cubit.dart';
import 'package:task_manger_app/presentation/cubit/update_task/update_task_cubit.dart';
import 'package:task_manger_app/presentation/widgets/task_manager_text_form_field.dart';

import '../../constants/colors.dart';
import '../../domain/entities/TaskManager.dart';
import '../../domain/entities/TodoList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetTodoListCubit getTodoListCubit;
  late AddTaskCubit addTaskCubit;
  late UpdateTaskCubit updateTaskCubit;
  late DeleteTaskCubit deleteTaskCubit;
  List<TodoList> getTodoList = [];

  final AddTask addTask = AddTask();

  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEditable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodoListCubit = BlocProvider.of<GetTodoListCubit>(context);
    addTaskCubit = BlocProvider.of<AddTaskCubit>(context);
    updateTaskCubit = BlocProvider.of<UpdateTaskCubit>(context);
    deleteTaskCubit = BlocProvider.of<DeleteTaskCubit>(context);
    getTodoListCubit.loadTodoList();
    print("Todo list length ${getTodoList.length}");
    print("Todo list length ${todosList.length}");

    _foundToDo = todosList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getTodoListCubit.close();
    addTaskCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context, 0.04),
          ),
          child: Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.height(context, 0.02),
                      ),
                      child: Text(
                        "All ToDos",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: SizeConfig.width(context, 0.06),
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.primaryColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    BlocConsumer<GetTodoListCubit, GetTodoListState>(
                      builder: (context, state) {
                        if (state is GetTodoListLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is GetTodoListLoaded) {
                          return SizedBox(
                            height: SizeConfig.height(context, 1),
                            width: SizeConfig.width(context, 1),
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width:
                                                SizeConfig.width(context, 0.55),
                                            child: isEditable
                                                ? TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border: InputBorder
                                                                .none),
                                                    initialValue:
                                                        getTodoList[index].todo,
                                                    keyboardType:
                                                        TextInputType.text)
                                                : Text(
                                                    "${index + 1}: ${getTodoList[index].todo}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeConfig.width(
                                                                context, 0.04)),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  )),
                                        SizedBox(
                                          width:
                                              SizeConfig.width(context, 0.01),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              isEditable =
                                                  !isEditable; // Change here
                                              print("isEditable $isEditable");
                                            });
                                            // updateTaskCubit.updateTask(false);
                                            if (!isEditable) {
                                              updateTaskCubit.updateTask(false);
                                            }
                                          },
                                          child: BlocConsumer<UpdateTaskCubit,
                                              UpdateTaskState>(
                                            listener: (context, state) {
                                              if (state is UpdateTaskFailed) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text(state.errorMessage),
                                                ));
                                              }
                                              if (state is UpdateTaskSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Task edit successfully"),
                                                ));
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is UpdateTaskLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return Icon(
                                                Icons.edit,
                                                color:
                                                    GlobalColors.primaryColor,
                                                size: SizeConfig.width(
                                                    context, 0.07),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.width(context, 0.01),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            deleteTaskCubit.deleteTask();
                                            print("Task deleted successfully");
                                          },
                                          child: BlocConsumer<DeleteTaskCubit,
                                              DeleteTaskState>(
                                            listener: (context, state) {
                                              if (state is DeleteTaskFailed) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                  Text(state.errorMessage),
                                                ));
                                              }
                                              if (state is DeleteTaskSuccess) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Task deleted successfully"),
                                                    ));
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is DeleteTaskLoading) {
                                                return const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                );
                                              }
                                              return Icon(
                                                Icons.delete,
                                                color:
                                                    GlobalColors.primaryColor,
                                                size: SizeConfig.width(
                                                    context, 0.07),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: SizeConfig.height(context, 0.02),
                                ); // Adjust as needed
                              },
                              itemCount: state.getTodoList.length,
                            ),
                          );
                        }
                        return Center(child: Text('state = $state'));
                      },
                      listener: (context, state) {
                        if (state is GetTodoListLoaded) {
                          setState(() {
                            getTodoList = state.getTodoList;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.height(context, 0.5),
                    )
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: SizeConfig.width(context, 0.7),
                height: SizeConfig.height(context, 0.1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: TaskManagerTextFormField(
                    validator: Validation,
                    controller: _todoController,
                    hintText: "Add a new todo item",
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addTaskCubit.addTask("Dummy Task", true, 50);
                  }
                  // _addToDoItem(_todoController.text);
                },
                child: BlocConsumer<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                      ));
                    }
                    if (state is AddTaskSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Task Added successfully"),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AddTaskLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text(
                      '+',
                      style: TextStyle(
                          fontSize: SizeConfig.width(context, 0.1),
                          color: GlobalColors.primaryColor),
                    );
                  },
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: GlobalColors.tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: GlobalColors.tdBlack,
            size: SizeConfig.width(context, 0.1),
          ),
          SizedBox(
            height: SizeConfig.height(context, 0.1),
            width: SizeConfig.width(context, 0.1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                SizeConfig.width(context, 0.1),
              ),
              child: Image.asset('assets/images/user-avatar.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Card(
      elevation: 2,
      borderOnForeground: false,
      child: TaskManagerTextFormField(
        hintText: 'Search',
        keyboardType: TextInputType.text,
        onChanged: (value) => _runFilter(value ?? ""),
        prefixIcon: const Icon(
          Icons.search,
          color: GlobalColors.tdBlack,
          size: 20,
        ),
      ),
    );
  }

  String? Validation(String? value) {
    if (value == null) {
      return 'required';
    }
    if (value.isEmpty) {
      return 'Please enter task';
    }
    return null;
  }
}
