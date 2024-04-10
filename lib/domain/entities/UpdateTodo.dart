/// id : "1"
/// todo : "Do something nice for someone I care about"
/// completed : false
/// userId : 26

class UpdateTodo {
  UpdateTodo({
      this.id, 
      this.todo, 
      this.completed, 
      this.userId,});

  UpdateTodo.fromJson(dynamic json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
  String? id;
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