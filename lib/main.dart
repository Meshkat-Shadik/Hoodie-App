import 'package:flutter/material.dart';
import 'package:xl_sheet_crud_test/Screens/StudentInfo.dart';
import 'package:xl_sheet_crud_test/Screens/TeachersInfo.dart';
import 'package:xl_sheet_crud_test/Screens/TeachersPage.dart';

import 'Screens/MyHomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
   //   home: MyHomePage(title: 'Flutter Google Sheet Demo')
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(text:'Students',),
                    Tab(text: "Teachers",),
                    Tab(text: "View Students",),
                    Tab(text: "View Teachers",),
                  ],
                ),
                title: Text('BNSCK HOODIE'),
              ),
              body: TabBarView(
                children: [
                  MyHomePage(),
                  TeachersPage(),
                  StudentInfo(),
                  TeachersInfo(),
                ],
              ),
            ),
          ),
          // When navigating to the "/second" route, build the SecondScreen widget.
        }
    );
  }
}




//1Xa8i__vAe_1NouOiuh-ukZCJIpZDZkdpSMdTpl6Dp_0
//1Xa8i__vAe_1NouOiuh-ukZCJIpZDZkdpSMdTpl6Dp_0