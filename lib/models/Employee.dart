// class Employee {
//   int id;
//   String firstName;
//   String lastName;

//   Employee({ this.firstName, this.lastName, this.id});

//   factory Employee.fromJson(Map<String, dynamic> json) {
//     return Employee(
//       id: json['id'] as int,
//       firstName: json['first_name'] as String,
//       lastName: json['last_name'] as String,
//     ); 
//   }
// }

class Employee {
  int id;
  String task;
  String status;
  String created;

  Employee({ this.task, this.status, this.id, this.created});

  factory Employee.fromJson(Map<String, dynamic> json) {
    // return Employee(
    //   id: json['id'] as int,
    //   firstName: json['first_name'] as String,
    //   lastName: json['last_name'] as String,
    // );
     return Employee(
      id: json['id'] as int,
      task: json['task'] as String,
      status: json['status'] as String,
      created: json['created'] as String
    );
  }
}