import 'package:flutter/material.dart';
import 'package:report_cell/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// final Uri _url = Uri.parse('https://flutter.dev');

String username = '';
String nama = '';

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
      nama = (pref.getString('nama')??'');
    });
  }


  void Hapuslogin() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginApp(),
      ),
      (route) => false,
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cloud_sync),
        // title : Text(username),
        title: new InkWell(
          child: new Text('$nama (logout)'),
          onTap: () => Hapuslogin(),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.cloud_done),
        ],
      ),

    );
  }
}