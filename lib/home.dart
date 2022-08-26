import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'selesai.dart';
import 'login.dart';
import 'progress.dart';
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
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      _getData();
      getReportOpenA();
      getReportOpenB();
      getReportOpenC();
      getReportOpenD();
      getReportOpenE();
      getReportOpenH();
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


  void hapusLogin() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
    // runApp(const MaterialApp(home: LoginApp()));
    if (!mounted) return;
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


  void pindahKeProgress(String idReport) async{
    // print(idReport);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          //show dialog to confirm delete data
          return 
          AlertDialog(
            content: const Text('Pindahkan report ke in progress?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Icon(Icons.cancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Icon(Icons.check_circle),
                onPressed: () => pindahProses(idReport),
              ),
            ],
          );
        },
      );
  }


  tanggalSekarang(){
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future pindahProses(context) async {
        try {
            var updateData =  await http.put(
              Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportOpen/index_put"),
              body: {
                "id"          : context,
                'updated_at'  : tanggalSekarang()
              },
            ).then((value) {
                var data = jsonDecode(value.body);
                return data['error'];
            });
            if(updateData == false){
                var insertDataLog =  await http.post(
                  Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportOpen/index_post"),
                  body: {
                    "id"                : context,
                    "nik"               : nik,
                    "status"            : 'PROGRESS',
                    "masalahSebenarnya" : '',
                    "created_at"        : tanggalSekarang()
                  },
                ).then((value) {
                    var data = jsonDecode(value.body);
                    return data['error'];
                });
                if(insertDataLog == false){
                  return reportProgress();
                }else{
                  return Navigator.of(context).pop();
                }
            }
        } catch (e) {
          print(e);
        }
      }



  Future getReportOpenA() async{
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

  Future getReportOpenB() async{
    
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

  Future getReportOpenC() async{
    
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

  Future getReportOpenD() async{
    
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

  Future getReportOpenE() async{
    
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

  Future getReportOpenH() async{
    
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
            onTap: () => hapusLogin(),
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
              return GestureDetector(
                onTap: () => pindahKeProgress(getDataReportOpenA[index]['id']),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenA[index]['cell']} - ${getDataReportOpenA[index]['bagian']} - ${getDataReportOpenA[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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
              return GestureDetector(
                onTap: () => reportProgress(),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenB[index]['cell']} - ${getDataReportOpenB[index]['bagian']} - ${getDataReportOpenB[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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
              return GestureDetector(
                onTap: () => pindahKeProgress(getDataReportOpenC[index]['id']),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenC[index]['cell']} - ${getDataReportOpenC[index]['bagian']} - ${getDataReportOpenC[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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
              return GestureDetector(
                onTap: () => pindahKeProgress(getDataReportOpenD[index]['id']),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenD[index]['cell']} - ${getDataReportOpenD[index]['bagian']} - ${getDataReportOpenD[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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
              return GestureDetector(
                onTap: () => pindahKeProgress(getDataReportOpenE[index]['id']),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenE[index]['cell']} - ${getDataReportOpenE[index]['bagian']} - ${getDataReportOpenE[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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
              return GestureDetector(
                onTap: () => pindahKeProgress(getDataReportOpenH[index]['id']),
                child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getDataReportOpenH[index]['cell']} - ${getDataReportOpenH[index]['bagian']} - ${getDataReportOpenH[index]['detail']}',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
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

