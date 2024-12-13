// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //-----อ่านข้อมูล userprofile--------
  //ตัวแปรเก็บโปรไฟล์
  String? _username, _fullname, _imagProfile;

  readUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // รับข้อมูล และทำการเลนเดอร์ใหม่ เหมือน onChange
    setState(() {
      _username = prefs.getString('username');
      _fullname = prefs.getString('fullname');
      _imagProfile = prefs.getString('imgProfile');
    });

    print(baseURLImage + _imagProfile!);
  }

  //get title Botton Navication
  String _title = 'Dashboard';
  //-------ส่วนการสลับข้อมูล Bottom Navigation
  int _currentIndex = 0;
  //Create Lists of bottom navication
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  //new func for next page 
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch(index){
        case 0: _title = 'Dashboard'; break;
        case 1: _title = 'Report'; break;
        case 2: _title = 'Notification'; break;
        case 3: _title = 'Setting'; break;
        case 4: _title = 'Profile'; break;
        default: _title = 'Dashboard'; break;
      }
    });
  }

  // Logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('step', 1);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: _imagProfile != null
                      ? CircleAvatar(
                          // backgroundImage: NetworkImage(baseURLImageProfile),
                          backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/id/1492896561/photo/portrait-of-happy-and-successful-female-programmer-inside-office-at-workplace-worker-smiling.jpg?s=612x612&w=0&k=20&c=KpkuifmGMoQpIJJStngrX7C0J5-R4kzALKw-I0W5vew='),
                          //CircularProgressIndicator แสดง loading รอภาพแสดง
                        )
                      : CircularProgressIndicator(),
                  decoration: BoxDecoration(color: primary),
                  accountName: Text(_fullname ?? '...'),
                  accountEmail: Text(_username ?? '...'),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(baseURLImage +
                              _imagProfile! ??
                          'https://media.istockphoto.com/id/1492896561/photo/portrait-of-happy-and-successful-female-programmer-inside-office-at-workplace-worker-smiling.jpg?s=612x612&w=0&k=20&c=KpkuifmGMoQpIJJStngrX7C0J5-R4kzALKw-I0W5vew='),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(baseURLImage +
                              _imagProfile! ??
                          'https://media.istockphoto.com/id/1492896561/photo/portrait-of-happy-and-successful-female-programmer-inside-office-at-workplace-worker-smiling.jpg?s=612x612&w=0&k=20&c=KpkuifmGMoQpIJJStngrX7C0J5-R4kzALKw-I0W5vew='),
                    )
                    // Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSua7o13hCS1lopLSoAf5zJA1f69XVh4p7w0A&s')
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('info'),
              onTap: () {
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('about'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('contact'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: logout)
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, //get index select page
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
