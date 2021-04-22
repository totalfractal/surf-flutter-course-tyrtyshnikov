import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({
    key,
    this.sight,
  }) : super(key: key);

  final Sight sight;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 2),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                alignment: Alignment.topLeft,
                child: Text(sight.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: hexToColor("#3B3E5B"),
                        decoration: TextDecoration.none)),
              ),
              Container(
                // padding:
                //     EdgeInsets.only(top: 2.0, left: 16, right: 16, bottom: 24),
                margin: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(sight.type.toLowerCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: hexToColor("#3B3E5B"),
                              decoration: TextDecoration.none)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text("закрыто до 9:00",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: hexToColor("#7C7E92"),
                              decoration: TextDecoration.none)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Text(sight.details,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        wordSpacing: 15,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: hexToColor("#3B3E5B"),
                        decoration: TextDecoration.none)),
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: hexToColor("#4CAF50"),
                          shadowColor: Colors.transparent, // background
                          onPrimary: Colors.white,
                          textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              decoration: TextDecoration.none) // foreground
                          ),
                      onPressed: () {},
                      child: Text('Построить маршрут'.toUpperCase()),
                    ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent, // background
                          onPrimary: hexToColor("#3B3E5B"),
                          textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: hexToColor("#3B3E5B"),
                              decoration: TextDecoration.none,
                              ), // foreground
                          ),
                      onPressed: () {},
                      child: Text('Запланировать'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent, // background
                          onPrimary: hexToColor("#3B3E5B"),
                          textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: hexToColor("#3B3E5B"),
                              decoration: TextDecoration.none) // foreground
                          ),
                      onPressed: () {},
                      child: Text('В избранное'),
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}