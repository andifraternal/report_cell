import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';


String username = '';
String nama = '';
String viewAll = '';
String nik = '';

class Selesai extends StatefulWidget {
  const Selesai({Key? key}) : super(key: key);

  @override
  State<Selesai> createState() => SelesaiState();
}

class SelesaiState extends State<Selesai> {

  void initState() {
    super.initState();
    _GetData();
  }

  void _GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = (pref.getString('username')??'');
      nama = (pref.getString('nama')??'');
      viewAll = (pref.getString('viewAll')??'');
      nik = (pref.getString('nik')??'');
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

  void reportDone() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Selesai(),
      ),
      (route) => false,
    );
  }

  void reportOpen() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.cloud_sync),
          onTap: () => reportOpen(),
        ),
        title: new InkWell(
          child: new Text('$nama(logout)'),
          onTap: () => Hapuslogin(),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.cloud_done),
            ),
            onTap: () => reportDone(),
          )
        ],
      ),
      // body:
      
    );
  }
}