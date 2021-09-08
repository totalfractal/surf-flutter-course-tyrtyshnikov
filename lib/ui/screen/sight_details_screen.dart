import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/sight_details_page_view.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight;
  const SightDetailsScreen({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OverscrollGlowAbsorber(
          child: CustomScrollView(
            physics: Platform.isAndroid
                ? const ClampingScrollPhysics()
                : const BouncingScrollPhysics(),
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
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.topRight,
                              stops: [0.0, 1.0],
                            ),
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
                            child: const ImageIcon(
                              AssetImage('res/icons/other/Arrow.png'),
                              size: 32,
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      ),
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
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          sight.name,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              sight.type.toLowerCase(),
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle1,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: Text(
                                'закрыто до 9:00',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          sight.details,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset('res/icons/other/GO.png'),
                              ),
                              Text(
                                'Построить маршрут'.toUpperCase(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        child: Theme(
                          data: ThemeData(
                            elevatedButtonTheme: ElevatedButtonThemeData(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  hexToColor(
                                    '#3B3E5B',
                                  ),
                                ),
                                shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          child: ButtonBar(
                            alignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'res/icons/other/Calendar.png',
                                      color: isDarkMode
                                          ? Colors.white
                                          : hexToColor(
                                              '#3B3E5B',
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                      'Запланировать',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : hexToColor(
                                                '#3B3E5B',
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Image.asset(
                                        'res/icons/menu/Heart.png',
                                        color: isDarkMode
                                            ? Colors.white
                                            : hexToColor(
                                                '#3B3E5B',
                                              ),
                                      ),
                                    ),
                                    Text(
                                      'В избранное',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : hexToColor(
                                                '#3B3E5B',
                                              ),
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
