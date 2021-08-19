import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/sight_details_page_view.dart';
import '../../globals.dart';

extension LoopList<T> on List {
  T loop(int index) => this[index % this.length];
}

class SightDetails extends StatelessWidget {
  const SightDetails({
    key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OverscrollGlowAbsorber(
          child: CustomScrollView(
              physics: Platform.isAndroid
                  ? ClampingScrollPhysics()
                  : BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: DecoratedBox(
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
                            child: SightDetailsPageView(sight: sight),
                          ),
                        ),
                        Positioned(
                            top: 36,
                            left: 16,
                            child: Material(
                                // borderRadius: BorderRadius.circular(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: ImageIcon(
                                    AssetImage("res/icons/other/Arrow.png"),
                                    size: 32,
                                  ),
                                  onTap: () => Navigator.pop(context),
                                )))
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.topLeft,
                            child: Text(
                              sight.name,
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).primaryTextTheme.headline1,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(sight.type.toLowerCase(),
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle1),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text("закрыто до 9:00",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text(sight.details,
                              textAlign: TextAlign.justify,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1),
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("res/icons/other/GO.png"),
                                SizedBox(width: 8),
                                Text(
                                  'Построить маршрут'.toUpperCase(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Theme(
                            data: ThemeData(
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                  style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        hexToColor("#3B3E5B")),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              )),
                            ),
                            child: ButtonBar(
                              alignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    print("Запланировано");
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          "res/icons/other/Calendar.png",
                                          color: isDarkMode
                                              ? Colors.white
                                              : hexToColor("#3B3E5B")),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        'Запланировать',
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : hexToColor("#3B3E5B")),
                                      )
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print("Добавлено в избранное");
                                  },
                                  style: ButtonStyle(),
                                  child: Row(
                                    children: [
                                      Image.asset("res/icons/menu/Heart.png",
                                          color: isDarkMode
                                              ? Colors.white
                                              : hexToColor("#3B3E5B")),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        'В избранное',
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : hexToColor("#3B3E5B")),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
