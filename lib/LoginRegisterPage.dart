import 'dart:convert';
import 'package:akuntansi_app/API.dart';
// import 'package:akuntansi_app/MenuAdmin.dart';
import 'package:akuntansi_app/MenuUsers.dart';
import 'package:akuntansi_app/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  String email, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;  

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autovalidate = false;
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  login() async {
    final response = await http
        .post(BaseUrl.login, body: {"email": email, "password": password});
    final data = jsonDecode(response.body);
    print("data: $data");
    bool success = data['success'];
    // String messagge = data['message'];

    print(success);
    if (success == true) {
      setState(() {
        int id = data['data']['id'];
        String name = data['data']['name'];
        String emailAPI = data['data']['email'];
        String nama_perusahaan = data['data']['nama_perusahaan'];
        // String alamatPerusahaan = data['alamat_perusahaan'];
        // String teleponPerusahaan = data['telepon_perusahaan'];
        // String emailPerusahaan = data['email_perusahaan'];
        String token = data['meta']['token'];

        _loginStatus = LoginStatus.signIn;
        savePref(id, name, emailAPI, success, token, nama_perusahaan);
      });
      loginToast("LOGIN BERHASIL");
    }
    if (success == false) {
      print("gatot");
      loginToast("Username/password tidak cocok");
    }
  }

  savePref(int id, String name, String email, bool success, String token,
      String nama_perusahaan) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("id", id);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setBool("success", success);
      preferences.setString("token", token);
      preferences.setString("nama_perusahaan", nama_perusahaan);
      // preferences.setString("alamat_perusahaan", alamatPerusahaan);
      // preferences.setString("telepon_perusahaan", teleponPerusahaan);
      // preferences.setString("email_perusahaan", emailPerusahaan);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getBool("success");
      // print("value :$value");
      _loginStatus = value == true ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("success", false);
      // preferences.setString("level", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
        ScreenUtil.instance =
            ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0, right: 10.0),
                    child: Image.asset(
                      'images/logoasli.png',
                      width: 500,
                      height: 200,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 100.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(180),
                      ),
                      Container(
                        width: double.infinity,
                        height: ScreenUtil.getInstance().setHeight(650),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Login",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(50),
                                      fontFamily: "Product-Bold",
                                      letterSpacing: .6)),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(40),
                              ),
                              Form(
                                key: _key,
                                autovalidate: _autovalidate,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //card for Email TextFormField
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Email Tidak Dapat Kosong";
                                        }
                                      },
                                      onSaved: (e) => email = e,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                          //    icon: Icon(Icons.email),
                                          // prefixIcon: Padding(
                                          //   padding: EdgeInsets.only(
                                          //       left: 20, right: 15),
                                          //   child: Icon(Icons.email),
                                          // ),
                                          //contentPadding: EdgeInsets.all(18),
                                          labelText: "Email"),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    // Card for password TextFormField
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Kata Sandi Tidak Dapat Kosong";
                                        } else {
                                          if (e.length < 8) {
                                            return "Kata Sandi Minimun 8 Karakter";
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      obscureText: _secureText,
                                      onSaved: (e) => password = e,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Kata Sandi",
                                        //icon: Icon(Icons.phonelink_lock),
                                        // prefixIcon: Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 20, right: 15),
                                        //   child: Icon(
                                        //     Icons.phonelink_lock,
                                        //   ),
                                        // ),
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        //  contentPadding: EdgeInsets.all(18),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Text(
                                            "Lupa kata sandi?",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: "Product-Bold",
                                                fontSize:
                                                    ScreenUtil.getInstance()
                                                        .setSp(23)),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPass()),
                                            );
                                          },
                                        )
                                      ],
                                    ),

                                    SizedBox(
                                      height: 50,
                                    ),

                                    Container(
                                      height: 50,
                                      width: 150,
                                      child: ButtonTheme(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: new Container(
                                          child: new RaisedButton(
                                            onPressed: () {
                                              check();
                                            },
                                            child: Text(
                                              "Masuk",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 30.0),
                      ),
                      Container(
                        height: 90,
                        child: new FlatButton(
                          child: RichText(
                            text: TextSpan(
                                text: "Belum memiliki akun? ",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Daftar sekarang!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue))
                                ]),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          "v1.0.0",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        // return MenuUsers();
        return Profil(signOut);
        break;
    }
  }
}

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  String email;

  var key = GlobalKey<FormState>();

  cek() {
    final form = key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  String url = "http://34.87.189.146:8000/api/password/email";

  var loading = false;
  submit() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(url, body: {"email": email});
    final data = jsonDecode(response.body);
    print(data);
    print(response.statusCode);
    bool value = data['success'];
    String message = data['Message'];
    if (value == true) {
      print(message);

      setState(() {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(message),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Kembali ke halaman login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        }),
                  ],
                ),
            barrierDismissible: false);
        // Navigator.pop(context);
        print(data);
        // registerToast(pesan);
      });
    } else {
      setState(() {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Maaf email anda tidak terdaftar"),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Kembali ke halaman login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        }),
                  ],
                ),
            barrierDismissible: false);
        // Navigator.pop(context);
        print(data);
        // registerToast(pesan);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lupa Kata Sandi"),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Silahkan masukkan email akun anda"),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (e) => email = e,
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Silahkan input email anda";
                    }
                  }),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.orange, Colors.orange[900]])),
                child: FlatButton(
                  onPressed: () {
                    cek();
                  },
                  child: Text(
                    "submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, namap, alamatp, teleponp, emailp, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var validate = false;
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    } else {
      setState(() {
        validate = true;
      });
    }
  }

  save() async {
    final response =
        await http.post("http://34.87.189.146:8000/api/register", headers: {
      'Accept': 'aplication/json'
    }, body: {
      "name": name,
      "email": email,
      "password": password,
    });

    final data = jsonDecode(response.body);
    print(data);
    // Navigator.pop(context);
    // registerToast("REGISTER BERHASIL");
    // String meta = data['meta']['token'];
    bool value = data['success'];
    String pesan = data['message'];
    print(value);
    if (value == false) {
      setState(() {
        print(data);
        Navigator.pop(context);
        registerToast(pesan);
      });
    } else {
      setState(() {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(pesan),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Kembali ke halaman login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        }),
                  ],
                ),
            barrierDismissible: false);
        // Navigator.pop(context);
        print(data);
        // registerToast(pesan);
      });
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.only(top: 30.0, right: 40.0),
          //       //child: Image.asset('images/logo.png'),
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil.getInstance().setHeight(1200),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Daftar Akun Baru',
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(40),
                                  fontFamily: "Product-Bold",
                                  letterSpacing: .6)),
                          SingleChildScrollView(
                            child: Form(
                              key: _key,
                              autovalidate: validate,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    cursorColor: Color(0xff53C5CF),
                                    validator: (e) {
                                      if (e.isEmpty) {
                                        return "Silakan Masukkan Nama Pengguna";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (e) => name = e,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                        // prefixIcon: Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 20, right: 15),
                                        //   child: Icon(
                                        //     Icons.account_circle,
                                        //   ),
                                        // ),
                                        // contentPadding: EdgeInsets.all(18),
                                        labelText: "Nama Pengguna"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                  ),
                                  TextFormField(
                                    cursorColor: Color(0xff53C5CF),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (e) {
                                      if (e.isEmpty) {
                                        return "Silakan Masukkan Email";
                                      } else {
                                        if (!e.contains("@")) {
                                          return "Format Email Salah";
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    onSaved: (e) => email = e,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                        // prefixIcon: Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 20, right: 15),
                                        //   child: Icon(Icons.email),
                                        // ),
                                        // contentPadding: EdgeInsets.all(18),
                                        labelText: "Email"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                  ),
                                  TextFormField(
                                    cursorColor: Color(0xff53C5CF),
                                    validator: (e) {
                                      if (e.isEmpty) {
                                        return "Silakan Masukkan Kata Sandi";
                                      } else {
                                        if (e.length < 8) {
                                          return "Kata Sandi Minimum 8 Karakter";
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    obscureText: _secureText,
                                    onSaved: (e) => password = e,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        // prefixIcon: Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 20, right: 15),
                                        //   child: Icon(Icons.phonelink_lock),
                                        // ),
                                        // contentPadding: EdgeInsets.all(18),
                                        labelText: "Kata Sandi"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20.0),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 150,
                                    child: ButtonTheme(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: new Container(
                                        child: RaisedButton(
                                            child: Text(
                                              "Daftar",
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            onPressed: () {
                                              check();
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: new FlatButton(
                                child: Text("Sudah punya akun? MASUK",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(22),
                                        fontFamily: "Product-Bold",
                                        color: Colors.blue,
                                        letterSpacing: .6)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ))
                      ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
