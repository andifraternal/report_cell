import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:report_cell/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'selesai.dart';

String username = '';
String nama = '';
String viewAll = '';
String nik = '';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  List getDataReport = [];

   @override
  void initState() {
    super.initState();
    _GetData();
    GetReport();
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

  Future GetReport() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = (pref.getString('username')??'');
      nama = (pref.getString('nama')??'');
      viewAll = (pref.getString('viewAll')??'');
      nik = (pref.getString('nik')??'');
    });

    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/report/index_get?id=$nik&view=$viewAll"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReport = data;
        });
        print(data);
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.cloud_sync),
          onTap: () => reportOpen(),
        ),
        title: new InkWell(
          child: new Text('$nama(logout)'),
          onTap: () => Hapuslogin(),
        ),
        backgroundColor: Colors.red,
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
      body: 
      
      ListView.builder(
        // back
        itemCount: getDataReport.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            tileColor: Colors.black,
            title: Text('${getDataReport[index]['cell']} - ${getDataReport[index]['bagian']} - ${getDataReport[index]['detail']} (${getDataReport[index]['NAMA']})', 
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
          )
          // return  Text('${getDataReport[index]['cell']}-${getDataReport[index]['bagian']}-${getDataReport[index]['detail']}(${getDataReport[index]['NAMA']})', 
          //         style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255))

          );
        }
      ),
        
      
    );
  }
}