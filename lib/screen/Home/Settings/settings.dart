import 'package:flutter/material.dart';

class SettingsScreens extends StatefulWidget {
  const SettingsScreens({super.key});

  @override
  State<SettingsScreens> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  // width: 400,
                  child: Center(
                    child: Image.asset("Assets/green background.avif",
                        fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text('Content goes here'),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 180.0,
              child: Container(
                height: 150,
                width: 150.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child:
                    ClipOval(child: Image.asset("Assets/portraitmanimage.png")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
