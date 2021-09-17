import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
          automaticallyImplyLeading: false,
          title: const Text(
            'Настройки',
          ),
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Тёмная тема',
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
                FlutterSwitch(
                  value: isDarkMode,
                  height: 32,
                  width: 56,
                  activeColor: lmGreenColor,
                  inactiveColor: lmInactiveBlackColor,
                  toggleSize: 28,
                  padding: 2,
                  onToggle: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .swapTheme();
                    setState(
                      () {
                        isDarkMode = !isDarkMode;
                      },
                    );
                    // globals.ChangeThemeNotifier().changeTheme();
                  },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Смотреть туториал',
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'res/icons/other/Info.png',
                      color: globals.isDarkMode ? dmGreenColor : lmGreenColor,
                    ),
                    onTap: () {},
                  ),
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
