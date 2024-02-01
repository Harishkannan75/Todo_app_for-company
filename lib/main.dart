import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/Provider/todo_provider.dart';
import 'package:todo/screen/Navigaations/Navigation_bar_items.dart';
import 'common/Provider/usernameprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        // ChangeNotifierProvider(create: (_) => Navigationcalendar()),
        ChangeNotifierProvider(create: (context) => UsernameProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const Navigationbaritems(),
      ),
    );
  }
}
