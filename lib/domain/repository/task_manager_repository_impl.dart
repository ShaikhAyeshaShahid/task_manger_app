import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task_manger_app/domain/entities/AddTask.dart';
import 'package:task_manger_app/domain/entities/UpdateTodo.dart';
import 'package:task_manger_app/domain/entities/UserLogin.dart';

import '../../constants/logger.dart';
import '../../data/task_manager_repository.dart';
import '../entities/DeleteTodo.dart';
import '../entities/TodoList.dart';

class TaskManagerRepositoryImpl implements TaskManagerRepository {
  final baseUrl = 'https://dummyjson.com';

  String token = '';
  var headers = <String, String>{
    "Content-Type": "application/json",
    // 'auth': token,
  };

  List<TodoList> todos = []; // List to hold todos
  int currentPage = 0; // Current page of pagination
  int pageSize = 10; // Number of items to fetch per page
  bool hasMoreData = true; // Indicates whether there are more pages to fetch


  UserLogin user = UserLogin();

  @override
  Future<UserLogin> signIn(String username, String password) async {
    try {
      var url = Uri.parse('$baseUrl/auth/login');
      LogManager.info('repository::signIn::url = $url');

      String jsonBody = jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      });

      LogManager.info('repository::signIn::body = $jsonBody');
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      var responseBody = jsonDecode(response.body);
      LogManager.debug("repository::signIn::responseBody: $responseBody\n");
      log("repository::signIn::responseBody: $responseBody\n");

      UserLogin user = UserLogin.fromJson(responseBody);
      this.user = user;

      return user;
    } on Exception catch (e) {
      LogManager.error('repository::signIn::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<List<TodoList>> getTodo() async {
    var url = Uri.parse('$baseUrl/todos');
    LogManager.info('repository::getTodo::url = $url');
    try {
      http.Response response = await http.get(url, headers: headers);
      var responseBody = jsonDecode(response.body);
      log("repository::getTodoList::responseBody: ${response.body}\n");

      if (response.statusCode != 200) {
        throw Exception(responseBody['message']);
      }

      List data = responseBody['todos'] as List;
      List<TodoList> getTodoList = [];

      if (data.isNotEmpty) {
        data.forEach((element) => getTodoList.add(TodoList.fromJson(element)));
        LogManager.info(
          'repository::getTodoList::response = ${responseBody['todos']}',
        );
      }
      return getTodoList;
    } on Exception catch (e) {
      LogManager.error('repository::getTodoList::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<AddTask> addTask(String todo, bool completed, int? userId) async {
    try {
      var url = Uri.parse('$baseUrl/todos/add');
      LogManager.info('repository::addTodo::url = $url');

      String jsonBody = jsonEncode(<String, dynamic>{
        'todo': todo,
        'completed': completed,
        'userId': userId,
      });

      LogManager.info('repository::addTodo::body = $jsonBody');
      http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      var responseBody = jsonDecode(response.body);
      LogManager.debug("repository::addTodo::responseBody: $responseBody\n");
      log("repository::addTodo::responseBody: $responseBody\n");

      AddTask addTask = AddTask.fromJson(responseBody);

      return addTask;
    } on Exception catch (e) {
      LogManager.error('repository::addTodo::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<UpdateTodo> updateTask(bool completed) async {
    try {
      var url = Uri.parse('$baseUrl/todos/1');
      LogManager.info('repository::updateTask::url = $url');

      String jsonBody = jsonEncode(<String, dynamic>{
        'completed': completed,
      });

      LogManager.info('repository::updateTask::body = $jsonBody');
      http.Response response = await http.put(
        url,
        headers: headers,
        body: jsonBody,
      );

      var responseBody = jsonDecode(response.body);
      LogManager.debug("repository::updateTask::responseBody: $responseBody\n");
      log("repository::updateTask::responseBody: $responseBody\n");

      UpdateTodo updateTask = UpdateTodo.fromJson(responseBody);

      return updateTask;
    } on Exception catch (e) {
      LogManager.error('repository::updateTask::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }

  @override
  Future<DeleteTodo> deleteTask() async {
    try {
      var url = Uri.parse('$baseUrl/todos/1');
      LogManager.info('repository::updateTask::url = $url');

      /* String jsonBody = jsonEncode(<String, dynamic>{
        'completed': completed,
      });*/

      // LogManager.info('repository::updateTask::body = $jsonBody');
      http.Response response = await http.delete(
        url,
        headers: headers,
        // body: jsonBody,
      );

      var responseBody = jsonDecode(response.body);
      LogManager.debug("repository::deleteTask::responseBody: $responseBody\n");
      log("repository::deleteTask::responseBody: $responseBody\n");

      DeleteTodo deleteTask = DeleteTodo.fromJson(responseBody);

      return deleteTask;
    } on Exception catch (e) {
      LogManager.error('repository::deleteTask::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
  @override
  Future<List<TodoList>> fetchTodo() async {
    var url = Uri.parse('$baseUrl/todos?limit=$pageSize&skip=${currentPage * pageSize}');
    LogManager.info('repository::getTodo::url = $url');
    try {
      http.Response response = await http.get(url, headers: headers);
      var responseBody = jsonDecode(response.body);
      log("repository::getTodoList::responseBody: ${response.body}\n");

      if (response.statusCode != 200) {
        throw Exception(responseBody['message']);
      }

      List data = responseBody['todos'] as List;
      List<TodoList> getTodoList = [];

      if (data.isNotEmpty) {
        data.forEach((element) => getTodoList.add(TodoList.fromJson(element)));
        LogManager.info(
          'repository::getTodoList::response = ${responseBody['todos']}',
        );
      }

      // Update the current page for the next fetch
      currentPage++;

      return getTodoList;
    } on Exception catch (e) {
      LogManager.error('repository::getTodoList::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }

}

@override
Future getUserDataLocally() async {}

@override
Future getDonorDataLocally() async {}
