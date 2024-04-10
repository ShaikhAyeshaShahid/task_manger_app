/// id : 1
/// todo : "Do something nice for someone I care about"
/// completed : true
/// userId : 26

class TodoList {
  TodoList({
      this.id, 
      this.todo, 
      this.completed, 
      this.userId,});

  TodoList.fromJson(dynamic json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['todo'] = todo;
    map['completed'] = completed;
    map['userId'] = userId;
    return map;
  }

}