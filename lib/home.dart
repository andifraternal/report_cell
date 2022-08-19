import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:report_cell/main.dart';
// import 'login.dart';

String username = '';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

   @override
  void initState() {
    super.initState();
    _GetData();
  }

  void _GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = (pref.getString('username')??'');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cloud_sync),
        title : Text(username),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.cloud_done),
        ],
      ),

    );
  }
}