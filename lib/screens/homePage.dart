import 'package:authentication_ui/screens/DatatableDemo.dart';
import 'package:authentication_ui/screens/LoginScreen.dart';
import 'package:authentication_ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    //checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text("Auth UI", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //sharedPreferences.clear();
              //sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      // App Sidebar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            // DrawerHeader(
            //   child: Text("Menu", style: TextStyle(fontSize: 19, color: Colors.white),),
            //   decoration: BoxDecoration(
            //     color: Colors.red[400],
            //   ),
            // ),
            UserAccountsDrawerHeader(
              accountName: Text("Fikayomi Chibueze",
                  style: TextStyle(
                    fontSize: 23,
                  )),
              accountEmail: Text("mac@gmail.com",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.grey),
            ),

            InkWell(
              child: ListTile(
                title: Text("Datatable", style: TextStyle(fontSize: 18)),
                leading: IconButton(icon: Icon(Icons.alarm), onPressed: () {}), 
              ),
              onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => DataTableDemo()));
                },
            ),
          ],
        ),
      ),


      // body 
      body: Center(child: Text("Main Page")),
    );
  }
}
