import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:report_cell/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'selesai.dart';
import 'login.dart';
import 'progress.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

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

  List getDataReportOpenA = [];
  List getDataReportOpenB = [];
  List getDataReportOpenC = [];
  List getDataReportOpenD = [];
  List getDataReportOpenE = [];
  List getDataReportOpenH = [];
  // String 

   @override
  void initState() {
    super.initState();
    setState(() {
      _GetData();
      GetReportOpenA();
      GetReportOpenB();
      GetReportOpenC();
      GetReportOpenD();
      GetReportOpenE();
      GetReportOpenH();
    });
    
  }

  void _GetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = (pref.getString('sessionUsername')??'');
      nama = (pref.getString('sessionNama')??'');
      viewAll = (pref.getString('sessionViewAll')??'');
      nik = (pref.getString('sessionNik')??'');
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

  void reportProgress() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Progress(),
      ),
      (route) => false,
    );
  }

  Future GetReportOpenA() async{
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=a"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenA = data;
          print(getDataReportOpenA.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future GetReportOpenB() async{
    
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=b"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenB = data;
          print(getDataReportOpenB.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future GetReportOpenC() async{
    
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=c"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenC = data;
          print(getDataReportOpenC.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future GetReportOpenD() async{
    
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=d"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenD = data;
          print(getDataReportOpenD.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future GetReportOpenE() async{
    
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=e"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenE = data;
          print(getDataReportOpenE.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future GetReportOpenH() async{
    
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportOpen/index_get?gedung=h"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportOpenH = data;
          print(getDataReportOpenH.length);
        });
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
          child: Icon(Icons.open_in_browser),
          onTap: () => reportOpen(),
        ),
        title:  Transform(
          transform:  Matrix4.translationValues(-60.0, 0.0, 0.0),
          child: Text(
            nama,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.cloud_sync),
            ),
            onTap: () => reportProgress(),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.cloud_done),
            ),
            onTap: () => reportDone(),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(Icons.logout),
            ),
            onTap: () => Hapuslogin(),
          )
        ],
      ),
      
      body: CustomScrollView(
      slivers: [
        // Gedung A
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung A'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenA[index]['cell']} - ${getDataReportOpenA[index]['bagian']} - ${getDataReportOpenA[index]['detail']} ',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenA.length, 
          ),
        ),
        // gedung B
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung B'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenB[index]['cell']} - ${getDataReportOpenB[index]['bagian']} - ${getDataReportOpenB[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenB.length, 
          ),
        ),
        // gedung C
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung C'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenC[index]['cell']} - ${getDataReportOpenC[index]['bagian']} - ${getDataReportOpenC[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenC.length, 
          ),
        ),
      // gedung D
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung D'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenD[index]['cell']} - ${getDataReportOpenD[index]['bagian']} - ${getDataReportOpenD[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenD.length, 
          ),
        ),
        // gedung E
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung E'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenE[index]['cell']} - ${getDataReportOpenE[index]['bagian']} - ${getDataReportOpenE[index]['detail']} ',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenE.length, 
          ),
        ),
        // gedung H
        const SliverAppBar(
          backgroundColor: Colors.red,
          title: Center(
            child: Text('Gedung H'),
          ),
          // floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenH[index]['cell']} - ${getDataReportOpenH[index]['bagian']} - ${getDataReportOpenH[index]['detail']} ',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 9, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportOpenH.length, 
          ),
        ),



      ],
    )
    );
  }
}

class Tile {
}