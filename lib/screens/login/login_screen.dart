import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //สร้าง Key สำหรับ form
  final formKey = GlobalKey<FormState>(); // GlobalKey ใช้ได้จากทุกหน้า
  //username & password
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     "เข้าสู่ระบบ",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        body: SingleChildScrollView(
      // physics: f(),
      child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Image.asset(
                    'assets/images/leadership-pana.png',
                    height: 280,
                    // height: 320,
                    // width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อผู่ใช้งาน';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _username = newValue!.toString().trim();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _password = newValue!.toString().trim();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () async {
                        //validate Form Value
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          var response = await CallAPI().loginAPI(
                            {'username': _username, 'password': _password},
                          );
                          var body = jsonDecode(response.body);
                          if (body['status'] == 'success') {
                             SharedPreferences prefs = await SharedPreferences.getInstance();
                             prefs.setString('userId', body['data']['id']);
                             prefs.setString('username', body['data']['username']);
                             prefs.setString('fullname', body['data']['fullname']);
                             prefs.setString('imgProfile', body['data']['img_profile']);
                             prefs.setInt('step', 2);
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    body['message'],
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  )
                  // TextFormField(

                  // ),
                ],
              ),
            ],
          )),
    ));
  }
}
