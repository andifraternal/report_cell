import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:report_cell/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'selesai.dart';
import 'login.dart';
import 'home.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';


String username = '';
String nama = '';
String viewAll = '';
String nik = '';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}


class _ProgressState extends State<Progress> {

  List getDataReportProgress = [];
  // String 

   @override
  void initState() {
    super.initState();
    setState(() {
      _getData();
      getReportProgress();
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
    runApp(const MaterialApp(home: LoginApp()));
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => const LoginApp(),
    //   ),
    //   (route) => false,
    // );  
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

  Future getReportProgress() async{
   
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportProgress/index_get?id=1708008681&view=y"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportProgress = data;
          print(getDataReportProgress.length);
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
      backgroundColor: const Color.fromARGB(255, 192, 173, 0),
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
          backgroundColor: Color.fromARGB(255, 192, 173, 0),
          title: Center(
            child: Text('In Progress'),
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
                              '(${getDataReportProgress[index]['no_urut']}) ${getDataReportProgress[index]['cell']} - ${getDataReportProgress[index]['bagian']} - ${getDataReportProgress[index]['detail']} (${getDataReportProgress[index]['NAMA']})',
                              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  ),
                            ),
                            const SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
            },
            childCount: getDataReportProgress.length, 
          ),
        ),
        

      ],
    )
    
    );
  }
}
