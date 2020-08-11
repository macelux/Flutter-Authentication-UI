import 'package:authentication_ui/models/Employee.dart';
import 'package:authentication_ui/services/Service.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Flutter demo table";

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;

  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a snakbar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
  }

// method to update title in the AppBar
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  _createTable() {
    _showProgress("Creting Table ....");
    //Service.createTable().then()
  }

  // add an Employee
  _addEmployees() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print("Empty Fields");
      return;
    }
    _showProgress("Adding Employee.....");
    Service.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if (result == 'success') {
        _clearTextField();
        _getEmployees();
      }
    });
  }

  _getEmployees() {
    _showProgress("getting Employee.....");
    Service.getEmployee().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title
      print(employees);
      print("length ${employees.length}");
    });
  }

  _updateEmployees(Employee employee) {
    setState(() {
      _isUpdating = false;
    });
    _showProgress("updating Employee ....");
    Service.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if (result == 'success') {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _clearTextField();
      }
    });
  }

  _deleteEmployees(Employee employee) {
    _showProgress("deleting Employee ....");
    Service.deleteEmployee(employee.id).then((result) {
      if (result == 'success') {}
    });
  }

  // Method to clear Textfield values
  _clearTextField() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee){
    // _firstNameController.text = employee.firstName;
    // _lastNameController.text = employee.lastName;
    _firstNameController.text = employee.task;
    _lastNameController.text = employee.status;
  }

  // create Datatables and show the employee list
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horizontal
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("ID"),
            ),
             DataColumn(
              label: Text("FIRST NAME"),
            ),
             DataColumn(
              label: Text("LAST NAME"),
            ),
            DataColumn(
              label: Text("Action"),
            ),
          ],
          rows: _employees.map(
            (employee) => DataRow(
              cells: [
                DataCell(Text(employee.id.toString()),
                // Add tap event in the row
                onTap: () {
                  _showValues(employee);
                  _selectedEmployee = employee; // set the selected employee to be updated
                  // set flag updating to true
                  setState(() {
                    _isUpdating = true;
                  });
                }
                ),
                DataCell(Text(employee.task.toUpperCase()),
                onTap: () {
                  _selectedEmployee = employee; // set the selected employee to be updated
                  _showValues(employee); 
                }),
                DataCell(Text(employee.status.toUpperCase()),
                onTap: () {
                  _selectedEmployee = employee; // set the selected employee to be updated
                  _showValues(employee); 
                }),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                    _deleteEmployees(employee);
                  },)
                ),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // show the progress in the title
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: "first Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: "last Name",
                ),
              ),
            ),
            // Add an update button and a camcel button
            // show these buttons only when updating
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text("Update"),
                        onPressed: () {
                          _updateEmployees(_selectedEmployee);
                        },
                      ),
                      OutlineButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearTextField();
                        },
                      ),
                    ],
                  )
                : Container(),
                Expanded(child: _dataBody(),)
                
          ],
        ),
      ),
      // add floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
