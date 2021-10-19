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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Stack(
        children: [
          OverscrollGlowAbsorber(
            child: CustomScrollView(
              physics: Platform.isAndroid
                  ? const ClampingScrollPhysics()
                  : const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: MediaQuery.of(context).size.width / 1.38,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: SizedBox(
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
                  ),
                ),
                SliverFillRemaining(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24,
                    ),
                    color: Theme.of(context).primaryColor,
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
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1,
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
          Container(
            alignment: Alignment.topCenter,
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('res/icons/other/Card close.png'),
              /* const ImageIcon(
                              AssetImage('res/icons/other/Card close.png'),
                              size: 40,
                            ), */
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
