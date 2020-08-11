import 'dart:convert';
import 'package:authentication_ui/models/Employee.dart';
import 'package:http/http.dart' as http;

class Service {
  static const ROOT = "https://test.champandy.com/tasks"; // define the resource url

  // Method to get EMployee
  static Future<List<Employee>> getEmployee() async {
    try {
      final response = await http.get(ROOT); // get API resource from url
      if (response.statusCode == 200) {
        List<Employee> list = parseResponse(response.body);

        return list;
      } else {
        return List<Employee>(); // return an empty list on exception error
      }
    } catch (e) {
      return List<Employee>(); // return an empty list on exception error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    // map Json data from response to Employee Model
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Methpod tp add Employee
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      //map['action'] = "get";
      map['task'] = firstName;
      map['status'] = lastName;
      final response = await http.post(ROOT, body: map);
      print("added table response ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee
  static Future<String> updateEmployee(
      int empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "update";
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(ROOT, body: map);
      print("Updated table response ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee
  static Future<String> deleteEmployee(int empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "delete";
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print("deleted table response ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
