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
var _idUser;

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}


class _ProgressState extends State<Progress> {

  List getDataReportProgress = [];
  
  List<dynamic> dataUser = [];
  // String 

   @override
  void initState() {
    super.initState();
    setState(() {
      _getData();
      getReportProgress();
      getUser();
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
    var formatter = DateFormat('yyyyMMdd HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future getReportProgress() async{
   
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/reportProgress/index_get?id=$nik&view=$viewAll"
      ));

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        setState(() {
          getDataReportProgress = data;
          print(getDataReportProgress);
        });
      }

    } catch (e) {
      print(e);
    }
    // print('http://10.10.40.40/report-cell-api/index.php/reportProgress/index_get?id=$nik&view=$viewAll');
  }

  Future goOpen(context) async {
        try {
            var updateData =  await http.put(
              Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportProgress/index_put"),
              body: {
                // "jenis"       : 'goOpen',
                "id"          : context,
                'updated_at'  : tanggalSekarang()
              },
            ).then((value) {
                var data = jsonDecode(value.body);
                return data['error'];
            });
            if(updateData == false){
                var insertDataLog =  await http.post(
                  Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportProgress/index_post"),
                  body: {
                    "jenis"             : 'goOpen',
                    "id"                : context,
                    "nik"               : nik,
                    "status"            : 'OPEN',
                    "masalahSebenarnya" : '',
                    "created_at"        : tanggalSekarang()
                  },
                ).then((value) {
                    var data = jsonDecode(value.body);
                    return data['error'];
                });
                if(insertDataLog == false){
                  return reportOpen();
                }else{
                  return Navigator.of(context).pop();
                }
            }
        } catch (e) {
          print(e);
        }
      }


    Future goDone(context) async {
        try {
            var updateData =  await http.put(
              Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportDone/index_put"),
              body: {
                "id"          : context,
                "status_report" : 'Y',
                'updated_at'  : tanggalSekarang()
              },
            ).then((value) {
                var data = jsonDecode(value.body);
                return data['error'];
            });
            if(updateData == false){
                var insertDataLog =  await http.post(
                  Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportDone/index_post"),
                  body: {
                    "id"                : context,
                    "nik"               : nik,
                    "status"            : 'DONE',
                    "masalahSebenarnya" : '',
                    "created_at"        : tanggalSekarang()
                  },
                ).then((value) {
                    var data = jsonDecode(value.body);
                    return data['error'];
                });
                if(insertDataLog == false){
                  return reportDone();
                }else{
                  return Navigator.of(context).pop();
                }
            }
        } catch (e) {
          print(e);
        }
      }
      
  void showDialogWithFields(String id) {
      showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      // overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          // key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                DropdownButtonFormField (
                                  hint: Text("Pilih"),
                                  value: _idUser,
                                  items: dataUser.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['NAMA']),
                                      value: item['NIK'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                  setState(() {
                                    _idUser = value;
                                    print(_idUser);
                                  });
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    "Simpan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    pindahOrang(id, _idUser );
                                    // print(id);
                                    // print(_idUser);
                                  },
                                ),
                                // )
                              ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
    }


    Future pindahOrang(String id, String idOrang) async {
        try {
                var insertDataLog =  await http.post(
                  Uri.parse("http://10.10.40.40/report-cell-api/index.php/reportProgress/index_post"),
                  body: {
                    "jenis"             : 'pindahOrang',
                    "id"                : id,
                    "nik"               : idOrang,
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
        } catch (e) {
          print(e);
        }
        // print(id);
      }


// Future getUser(context) async {
    
    void getUser() async {
      final respose = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/user/index_get"
      ));
      var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya 
      setState(() {
        dataUser = listData; // dan kita set kedalam variable _dataProvince
      });
      print("data : $listData");
    }
// }
  

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
                        child: 
                            Column(
                              children: [
                                Text(
                                  '(${getDataReportProgress[index]['no_urut']}) ${getDataReportProgress[index]['cell']} - ${getDataReportProgress[index]['bagian']} - ${getDataReportProgress[index]['detail']} (${getDataReportProgress[index]['NAMA']})',
                                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13, fontWeight: FontWeight.w800,  ),
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            //show dialog to confirm delete data
                                            return 
                                            AlertDialog(
                                              content: const Text('Pindahkan report ke Open?'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: const Icon(Icons.cancel),
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                                ElevatedButton(
                                                  child: const Icon(Icons.check_circle),
                                                  onPressed: () => goOpen(getDataReportProgress[index]['id']),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('To Open', style: const TextStyle( fontSize: 11, fontWeight: FontWeight.w800,  ),),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red) ),
                                    ),
                                    // const SizedBox(height: 20),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialogWithFields(getDataReportProgress[index]['id']);
                                      },
                                      child: const Text('Other Assigned' , style: const TextStyle( fontSize: 11, fontWeight: FontWeight.w800,  ),),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 192, 173, 0),),  ),
                                    ),
                                    // const SizedBox(height: 20),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            //show dialog to confirm delete data
                                            return 
                                            AlertDialog(
                                              content: const Text('Report Selesai?'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: const Icon(Icons.cancel),
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                                ElevatedButton(
                                                  child: const Icon(Icons.check_circle),
                                                  onPressed: () => goDone(getDataReportProgress[index]['id']),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Done' , style: const TextStyle( fontSize: 11, fontWeight: FontWeight.w800,  ),),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green,) ),
                                    ),
                                    // const SizedBox(height: 10),
                                  ],
                                )
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
