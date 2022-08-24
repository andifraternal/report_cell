import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'home.dart';


class LoginApp extends StatefulWidget{
  const LoginApp({Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _loginAppState();
}

class _loginAppState extends State<LoginApp>{
  
  var username = TextEditingController();
  var password = TextEditingController();

  void sweatAlert(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Login Gagal",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
    return;
  }


  Future _onLogin() async {
    try {
      final response = await http.get(Uri.parse(
        "http://10.10.40.40/report-cell-api/index.php/login/index_get?username="+username.text+"&password="+password.text+""
      )
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        if(data['status'] == ''){
          sweatAlert(context);
        }else{
          // simpan session
          final  pref = await SharedPreferences.getInstance();
          await pref.setString("sessionUsername", data['data']['UNAME']);
          await pref.setString("sessionNama", data['data']['NAMA']);
          await pref.setString("sessionViewAll", data['data']['VIEW_ALL']);
          await pref.setString("sessionNik", data['data']['NIK']);
          await pref.setBool("sessionLogin", true);

          // final String? sessionUsername = pref.getString('sessionUsername');
          // final String? sessionNama = pref.getString('sessionNama');
          // final String? sessionViewAll = pref.getString('sessionViewAll');
          // final String? sessionNik = pref.getString('sessionNik');
          // final bool? sessionLogin = pref.getBool('sessionLogin');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Home(),
            ),
            (route) => false,
          );
          // print(hoha);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var getUser = pref.getString("sessionUsername");
    var getNama = pref.getString("sessionNama");
    var getViewAll = pref.getString("sessionViewAll");
    var getNik = pref.getString("sessionNik");
    var islogin = pref.getBool("sessionLogin");
    // tampilSession();
    if (islogin != null && islogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
        (route) => false,
      );
    }
    print(getNik);
  }



  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purpleAccent,
                    Colors.amber,
                    Colors.blue,
                  ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50,),
              SizedBox(
                height:200,
                width: 300,
                child: LottieBuilder.asset("assets/lottie/login2.json"),
              ),
              const SizedBox(height: 10,),
              Container(
                width: 325,
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    const Text("Hello",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight:FontWeight.bold
                      ),),
                    const SizedBox(height: 10,),
                    const Text("Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),),
                    const SizedBox(height: 30,),
                    Container(
                      // controller: namaProvinsi,
                      width: 260,
                      height: 60,
                      child: TextField(
                        controller: username,
                        decoration: const InputDecoration(
                            suffix: Icon(FontAwesomeIcons.envelope,color: Colors.red,),
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                            suffix:  Icon(FontAwesomeIcons.eyeSlash,color: Colors.red,),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _onLogin();
                      },
                    ),

                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     "hapus login",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   onPressed: () {
                    //     Hapuslogin();
                    //   },
                    // )
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}



