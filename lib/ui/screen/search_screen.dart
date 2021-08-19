import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import '../../globals.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/search_screen/search_history_item.dart';
import 'widgets/search_screen/search_result_item.dart';

//TODO: Виджет пустого результата поиска
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
  List<Widget> _historyWigets = [];
  List<SearchHistoryItem> _historyItems = [];
  Map<String, Widget> __allWidgetsMap = {};

  @override
  void initState() {
    super.initState();
    _historyItems = _getHistoryFromRepo();
    _historyWigets = _updateHistoryWidget();
    _searchHistoryWidget = _setSearchHistoryWidget();
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
                setState(() {
                  _sightsList = value;
                });
              },
              onQueryChanged: (String query) {
                if (query.isEmpty) {
                  setState(
                    () {
                      _searchBodyWidget = _searchHistoryWidget;
                    },
                  );
                } else {
                  setState(
                    () {
                      _getHilightSearchResultWidgets(query);
                      _searchBodyWidget = _searchResultsWidget;
                    },
                  );
                }
              },
              onFocusChanged: (hasFocus) {
                setState(
                  () {
                    _searchBodyWidget = _searchHistoryWidget;
                  },
                );
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
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: _searchBodyWidget),
    );
  }

  List<Sight> _getSightsOnInit() {
    List<Sight> sightsList = [];
    mocks.forEach(
      (element) {
        sightsList.add(
          Sight(
              name: element[0],
              lat: double.parse(element[1]),
              lon: double.parse(element[2]),
              urls: element[3],
              details: element[4],
              type: element[5]),
        );
      },
    );
    return sightsList;
  }

  List<SearchHistoryItem> _getHistoryFromRepo() {
    return [
      for (int mock = 0; mock < 5; mock++)
        SearchHistoryItem(
          index: mock,
          sight: Sight(
              name: mocks[mock][0],
              lat: double.parse(mocks[mock][1]),
              lon: double.parse(mocks[mock][2]),
              urls: mocks[mock][3],
              details: mocks[mock][4],
              type: mocks[mock][5]),
          onDelete: (index) {
            _deleteHistoryItem(index);
          },
        ),
    ];
  }

  List<Widget> _updateHistoryWidget() {
    List<Widget> history = [];
    _historyItems.forEach((element) {
      history.add(
        SearchHistoryItem(
          index: _historyItems.indexOf(element),
          sight: element.sight,
          onDelete: (index) {
            _deleteHistoryItem(index);
          },
        ),
      );
      if (_historyItems.indexOf(element) != _historyItems.length - 1) {
        history.add(
          Divider(
            thickness: 0.8,
            color: lmInactiveBlackColor.withOpacity(0.24),
          ),
        );
      }
    });
    return history;
  }

  Widget _setSearchHistoryWidget() {
    var notEmptyHistory = [
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
      ..._historyWigets,
      Container(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            _clearHistory();
          },
          child: Text(
            "Очистить историю",
            textAlign: TextAlign.start,
          ),
        ),
      ),
    ];
    var emptyHistory = [
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
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "История поиска отсутствует",
            style: lmRoboto14W400.copyWith(color: dmInactiveBlackColor),
          ),
        ),
      ),
    ];
    return OverscrollGlowAbsorber(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: Platform.isAndroid
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        children: _historyItems.isNotEmpty ? notEmptyHistory : emptyHistory,
      ),
    );
  }

  void _deleteHistoryItem(int index) {
    setState(
      () {
        _historyItems.removeAt(index);
        _historyWigets = _updateHistoryWidget();
        _searchHistoryWidget = _setSearchHistoryWidget();
        _searchBodyWidget = _searchHistoryWidget;
      },
    );
  }

  void _clearHistory() {
    setState(() {
      _historyWigets.clear();
      _historyItems.clear();
      _searchHistoryWidget = _setSearchHistoryWidget();
      _searchBodyWidget = _searchHistoryWidget;
    });
  }

  void _getHilightSearchResultWidgets(String query) {
    _searchResultsWidget = OverscrollGlowAbsorber(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: Platform.isAndroid
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        children: [
          for (var sight in _sightsList)
            if (sight.name.toLowerCase().contains(query.toLowerCase()))
              SearchResultItem(
                query: query,
                sight: sight,
              )
        ],
      ),
    );
  }
}
