import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

import '../../globals.dart';
import 'widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Sight> _sightsList = [];
  late Widget _searchBodyWidget;
  late Widget _searchHistoryWidget;
  late Widget _searchResultsWidget;
  List<Widget> _history = [];

  List<Widget> _getHistory() {
    List<Widget> history = [];
    for (int mock = 0; mock < 5; mock++) {
      history.add(SearchHistoryUnit(
        sight: Sight(
            name: mocks[mock][0],
            lat: double.parse(mocks[mock][1]),
            lon: double.parse(mocks[mock][2]),
            url: mocks[mock][3],
            details: mocks[mock][4],
            type: mocks[mock][5]),
      ));
      if (mock != mocks.length - 1) {
        history.add(
          Divider(
            thickness: 0.8,
            color: lmInactiveBlackColor.withOpacity(0.24),
          ),
        );
      }
    }
    return history;
  }

  @override
  void initState() {
    super.initState();
    _history = _getHistory();
    _searchHistoryWidget = Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("ВЫ ИСКАЛИ",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: dmInactiveBlackColor)),
        ),
        ..._history,
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
              onPressed: () {},
              child: Text(
                "Очистить историю",
                textAlign: TextAlign.start,
              )),
        ),
      ],
    );

    _sightsList = _getSightsOnInit();

    _searchBodyWidget = _searchHistoryWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width - 32, 40),
            child: SearchBar(
              autofocus: true,
              onFiltersChanged: (List<Sight> value) {
                _sightsList = value;
                setState(() {});
              },
              onQueryChanged: (String query) {
                if (query.isEmpty) {
                  setState(() {
                    _searchBodyWidget = _searchHistoryWidget;
                  });
                } else {
                  setState(() {
                    _searchBodyWidget = _getHilightSearchResultWidgets(query);
                  });
                }
              },
              onFocusChanged: (hasFocus) {
                setState(() {
                  _searchBodyWidget = _searchHistoryWidget;
                });
              },
            ),
          ),
          title: Container(
            child: Text(
              "Список интересных мест",
              textAlign: TextAlign.start,
              maxLines: 2,
              softWrap: true,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: _searchBodyWidget),
      ),
    );
  }

  List<Sight> _getSightsOnInit() {
    List<Sight> sightsList = [];
    mocks.forEach((element) {
      sightsList.add(
        Sight(
            name: element[0],
            lat: double.parse(element[1]),
            lon: double.parse(element[2]),
            url: element[3],
            details: element[4],
            type: element[5]),
      );
    });
    return sightsList;
  }

  Column _getSearchResultWidgets() {
    List<SearchResult> _resultSightWidgets = [];
    _sightsList.forEach((element) {
      _resultSightWidgets.add(SearchResult(
        query: "",
        sight: element,
      ));
    });
    return Column(children: _resultSightWidgets);
  }

  Column _getHilightSearchResultWidgets(String query) {
    List<SearchResult> _resultSightWidgets = [];
    _sightsList.forEach((element) {
      if (element.name.toLowerCase().contains(query.toLowerCase())) {
        _resultSightWidgets.add(SearchResult(
          query: query,
          sight: element,
        ));
      }
    });
    return Column(children: _resultSightWidgets);
  }
}

class SearchHistoryUnit extends StatelessWidget {
  const SearchHistoryUnit({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                sight.name,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText2!
                    .copyWith(color: lmSecondary2Color),
                maxLines: 3,
              ),
            ),
          ),
          Ink(
            child: IconButton(
                onPressed: () {
                  print("delete");
                },
                icon: ImageIcon(
                  AssetImage("res/icons/other/Delete.png"),
                  color: lmSecondary2Color,
                )),
          )
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SightDetails(
                      sight: sight,
                    )));
      },
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.sight, required this.query})
      : super(key: key);

  final String query;
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 56,
              width: 56,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  sight.url,
                  height: 56,
                  width: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        text: TextSpan(
                            children: highlightOccurrences(
                                sight.name,
                                query,
                                Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.w500)),
                            style:
                                Theme.of(context).primaryTextTheme.bodyText2),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        sight.type,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline3!
                            .copyWith(
                                color: isDarkMode
                                    ? dmSecondary2Color
                                    : lmSecondary2Color),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SightDetails(
                      sight: sight,
                    )));
      },
    );
  }

  List<TextSpan> highlightOccurrences(
      String source, String query, TextStyle hilightTextTheme) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: hilightTextTheme,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
