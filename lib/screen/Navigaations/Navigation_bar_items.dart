// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Add task/add_task.dart';
import '../Calender/calender_screen.dart';
import '../Home/home_page.dart';

class Navigationbaritems extends StatefulWidget {
  const Navigationbaritems({super.key});

  @override
  State<Navigationbaritems> createState() => _NavigationbaritemsState();
}

class _NavigationbaritemsState extends State<Navigationbaritems> {
  late CupertinoTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_sharp),
          label: "Home",
          // backgroundColor: Colors.deepPurple
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          label: "Calender",
          // backgroundColor: Colors.deepPurple
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: "Add",
          // backgroundColor: Colors.deepPurple
        ),
      ]),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: HomeScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                    child: Calenderscreen(
                  tabindex: _tabController,
                ));
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(child: AddTaskpage());
              },
            );
        }
        return Container();
      },
    );
  }
}
