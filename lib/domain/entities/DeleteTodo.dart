/// id : 1
/// todo : "Do something nice for someone I care about"
/// completed : true
/// userId : 26
/// isDeleted : true
/// deletedOn : "ISOTime"

class DeleteTodo {
  DeleteTodo({
      this.id, 
      this.todo, 
      this.completed, 
      this.userId, 
      this.isDeleted, 
      this.deletedOn,});

  DeleteTodo.fromJson(dynamic json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
    isDeleted = json['isDeleted'];
    deletedOn = json['deletedOn'];
  }
  int? id;
  String? todo;
  bool? completed;
  int? userId;
  bool? isDeleted;
  String? deletedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['todo'] = todo;
    map['completed'] = completed;
    map['userId'] = userId;
    map['isDeleted'] = isDeleted;
    map['deletedOn'] = deletedOn;
    return map;
  }

}