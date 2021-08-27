import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> isInitialized = Future<bool>(() {
    return false;
  });

  @override
  void initState() {
    super.initState();
    isInitialized = _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(252, 221, 61, 1),
            Color.fromRGBO(76, 175, 80, 1),
          ],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          stops: [0.0, 1.0],
        ),
      ),
      child: Image.asset(
        'res/icons/logo.png',
        width: 160,
        height: 160,
      ),
    );
  }

  Future<bool> _navigateToNext() async {
    return Future.delayed(const Duration(seconds: 2), () {
      //ignore:avoid_print
      print('Переход на следующий экран');
      return true;
    });
  }
}
