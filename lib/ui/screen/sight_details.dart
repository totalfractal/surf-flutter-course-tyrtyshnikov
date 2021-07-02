import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/styles.dart';
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
          child: Image.network(
            sight.url,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 2),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.topLeft,
                  child: Text(
                    sight.name,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  )),
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
                          style: Theme.of(context).primaryTextTheme.subtitle1),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text("закрыто до 9:00",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).primaryTextTheme.subtitle2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Text(sight.details,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).primaryTextTheme.bodyText1),
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  /* style: ElevatedButton.styleFrom(
                      primary: hexToColor("#4CAF50"),
                      shadowColor: Colors.transparent, // background
                      textStyle: Theme.of(context).primaryTextTheme.button), */
                  onPressed: () {},
                  child: Text('Построить маршрут'.toUpperCase()),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Theme(
                  data: ThemeData(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          hexToColor("#3B3E5B")),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                    )),
                  ),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Запланировать'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('В избранное'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
