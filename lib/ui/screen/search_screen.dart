import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/search_screen/search_history_item.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/search_screen/search_result_item.dart';

// ignore: flutter_style_todos
//TODO: Виджет пустого результата поиска
class SearchScreen extends StatefulWidget {
  const SearchScreen({
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

  @override
  void initState() {
    super.initState();
    _getHistoryFromRepo();
    _updateHistoryWidget();
    _setSearchHistoryWidget();
    _getSightsOnInit();
    _searchBodyWidget = _searchHistoryWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width - 32, 40),
            child: SearchBar(
              autofocus: true,
              onFiltersChanged: (value) {
                setState(() {
                  _sightsList = value;
                });
              },
              onQueryChanged: (query) {
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
          title: const Text(
            'Список интересных мест',
            textAlign: TextAlign.start,
            maxLines: 2,
            softWrap: true,
          ),
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: _searchBodyWidget,
      ),
    );
  }

  void _getSightsOnInit() {
    _sightsList = <Sight>[
      for (final sight in mocks)
        Sight(
          name: sight[0] as String,
          lat: double.parse(sight[1] as String),
          lon: double.parse(sight[2] as String),
          urls: sight[3] as List<String>,
          details: sight[4] as String,
          type: sight[5] as String,
        ),
    ];
  }

  void _getHistoryFromRepo() {
    _historyItems = [
      for (int mock = 0; mock < 5; mock++)
        SearchHistoryItem(
          index: mock,
          sight: Sight(
            name: mocks[mock][0] as String,
            lat: double.parse(mocks[mock][1] as String),
            lon: double.parse(mocks[mock][2] as String),
            urls: mocks[mock][3] as List<String>,
            details: mocks[mock][4] as String,
            type: mocks[mock][5] as String,
          ),
          onDelete: (index) {
            _deleteHistoryItem(index);
          },
        ),
    ];
  }

  void _updateHistoryWidget() {
    _historyWigets = [];
    for (final element in _historyItems) {
      _historyWigets.add(
        SearchHistoryItem(
          index: _historyItems.indexOf(element),
          sight: element.sight,
          onDelete: (index) {
            _deleteHistoryItem(index);
          },
        ),
      );
      if (_historyItems.indexOf(element) != _historyItems.length - 1) {
        _historyWigets.add(
          Divider(
            thickness: 0.8,
            color: lmInactiveBlackColor.withOpacity(0.24),
          ),
        );
      }
    }
  }

  void _setSearchHistoryWidget() {
    final notEmptyHistory = <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const Text(
          'ВЫ ИСКАЛИ',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: dmInactiveBlackColor,
          ),
        ),
      ),
      ..._historyWigets,
      Container(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: _clearHistory,
          child: const Text(
            'Очистить историю',
            textAlign: TextAlign.start,
          ),
        ),
      ),
    ];
    final emptyHistory = [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const Text(
          'ВЫ ИСКАЛИ',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: dmInactiveBlackColor,
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'История поиска отсутствует',
            style: lmRoboto14W400.copyWith(color: dmInactiveBlackColor),
          ),
        ),
      ),
    ];
    _searchHistoryWidget = OverscrollGlowAbsorber(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: Platform.isAndroid
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        children: _historyItems.isNotEmpty ? notEmptyHistory : emptyHistory,
      ),
    );
  }

  void _deleteHistoryItem(int index) {
    setState(
      () {
        _historyItems.removeAt(index);
        _updateHistoryWidget();
        _setSearchHistoryWidget();
        _searchBodyWidget = _searchHistoryWidget;
      },
    );
  }

  void _clearHistory() {
    setState(() {
      _historyWigets.clear();
      _historyItems.clear();
      _setSearchHistoryWidget();
      _searchBodyWidget = _searchHistoryWidget;
    });
  }

  void _getHilightSearchResultWidgets(String query) {
    _searchResultsWidget = OverscrollGlowAbsorber(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: Platform.isAndroid
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        children: [
          for (var sight in _sightsList)
            if (sight.name.toLowerCase().contains(query.toLowerCase()))
              SearchResultItem(
                query: query,
                sight: sight,
              ),
        ],
      ),
    );
  }
}
