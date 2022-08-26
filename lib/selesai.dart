import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:report_cell/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'login.dart';
import 'progress.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';


String username = '';
String nama = '';
String viewAll = '';
String nik = '';

class Selesai extends StatefulWidget {
  const Selesai({Key? key}) : super(key: key);

  @override
  State<Selesai> createState() => _SelesaiState();
}


class _SelesaiState extends State<Selesai> {

  List getDataReportDoneA = [];
  List getDataReportDoneB = [];
  List getDataReportDoneC = [];
  List getDataReportDoneD = [];
  List getDataReportDoneE = [];
  List getDataReportDoneH = [];
  // List getDataReportOpen = [];
  // String 

   @override
  void initState() {
    super.initState();
    setState(() {
      _getData();
      getReportDoneA();
      getReportDoneB();
      getReportDoneC();
      getReportDoneD();
      getReportDoneE();
      getReportDoneH();
    });
    
  }

  void _getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = (pref.getString('sessionUsername')??'');
      nama = (pref.getString('sessionNama')??'');
      viewAll = (pref.getString('sessionViewAll')??'');
      nik = (pref.getString('sessionNik')??'');
    });
  }


  void hapuslogin() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
    if (!mounted) return;
    // runApp(const MaterialApp(home: LoginApp()));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginApp(),
      ),
      (route) => false,
    );  
  }

  void reportDone() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Selesai(),
      ),
      (route) => false,
    );
  }

  void reportOpen() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Home(),
      ),
      (route) => false,
    );
  }

  void reportProgress() async{
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const Progress(),
      ),
      (route) => false,
    );
  }

  tanggalSekarang(){
    var now = DateTime.now();
    var formatter = DateFormat('yyyyMMdd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future getReportDoneA() async{
    // print(tanggalSekarang());
    var sekarang = tanggalSekarang();
    // var sekarang = '20220822';
    // print(sekarang);
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=a'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneA = data;
          // print(getDataReportDoneA.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future getReportDoneB() async{
    var sekarang = tanggalSekarang();
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=b'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneB = data;
          // print(getDataReportDoneB.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future getReportDoneC() async{
    var sekarang = tanggalSekarang();
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=c'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneC = data;
          // print(getDataReportDoneC.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future getReportDoneD() async{
    var sekarang = tanggalSekarang();
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=d'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneD = data;
          // print(getDataReportDoneD.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future getReportDoneE() async{
    var sekarang = tanggalSekarang();
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=e'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneE = data;
          // print(getDataReportDoneE.length);
        });
      }

    } catch (e) {
      print(e);
    }
    // print(username);
  }

  Future getReportDoneH() async{
    var sekarang = tanggalSekarang();
    try {
      final response = await http.get(Uri.parse(
        'http://10.10.40.40/report-cell-api/index.php/reportDone/index_get?tanggal=$sekarang&gedung=h'
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportDoneH = data;
          // print(getDataReportDoneH.length);
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
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.open_in_browser),
          onTap: () => reportOpen(),
        ),
        title:  Transform(
          transform:  Matrix4.translationValues(-60.0, 0.0, 0.0),
          child: Text(
            nama,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(Icons.cloud_sync),
            ),
            onTap: () => reportProgress(),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(Icons.cloud_done),
            ),
            onTap: () => reportDone(),
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Icon(Icons.logout),
            ),
            onTap: () => hapuslogin(),
          )
        ],
      ),

      body: CustomScrollView(
      slivers: [
        // Gedung A
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneA[index]['no_urut']}) ${getDataReportDoneA[index]['cell']} - ${getDataReportDoneA[index]['bagian']} - ${getDataReportDoneA[index]['detail']} (${getDataReportDoneA[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneA.length, 
          ),
        ),
        // gedung B
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneB[index]['no_urut']}) ${getDataReportDoneB[index]['cell']} - ${getDataReportDoneB[index]['bagian']} - ${getDataReportDoneB[index]['detail']} (${getDataReportDoneB[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneB.length, 
          ),
        ),
        // gedung C
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneC[index]['no_urut']}) ${getDataReportDoneC[index]['cell']} - ${getDataReportDoneC[index]['bagian']} - ${getDataReportDoneC[index]['detail']} (${getDataReportDoneC[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneC.length, 
          ),
        ),
      // gedung D
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneD[index]['no_urut']}) ${getDataReportDoneD[index]['cell']} - ${getDataReportDoneD[index]['bagian']} - ${getDataReportDoneD[index]['detail']} (${getDataReportDoneD[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneD.length, 
          ),
        ),
        // gedung E
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneE[index]['no_urut']}) ${getDataReportDoneE[index]['cell']} - ${getDataReportDoneE[index]['bagian']} - ${getDataReportDoneE[index]['detail']} (${getDataReportDoneE[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneE.length, 
          ),
        ),
        // gedung H
        const SliverAppBar(
          backgroundColor: Colors.green,
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
                              '(${getDataReportDoneH[index]['no_urut']}) ${getDataReportDoneH[index]['cell']} - ${getDataReportDoneH[index]['bagian']} - ${getDataReportDoneH[index]['detail']} (${getDataReportDoneH[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportDoneH.length, 
          ),
        ),



      ],
    )
    
      
    );
  }
}

