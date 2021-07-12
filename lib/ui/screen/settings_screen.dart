import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width * 0.7, 75),
        child: AppBar(
          title: Text(
            "Настройки",
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  "Тёмная тема",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: lmMainColor),
                )),
                Container(
                    child: FlutterSwitch(
                        value: isDarkMode,
                        height: 32,
                        width: 56,
                        activeColor: lmGreenColor,
                        inactiveColor: lmInactiveBlackColor,
                        toggleSize: 28,
                        padding: 2,
                        onToggle: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        })),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                thickness: 0.8,
                color: lmInactiveBlackColor.withOpacity(0.24),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  "Смотреть туториал",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: lmMainColor),
                )),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: InkWell(
                      child: Image.asset(
                        "res/icons/other/Info.png",
                        color: isDarkMode ? dmGreenColor : lmGreenColor,
                      ),
                      onTap: () {
                        print("info");
                      }),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                thickness: 0.8,
                color: lmInactiveBlackColor.withOpacity(0.24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
