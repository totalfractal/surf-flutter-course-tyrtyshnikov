import 'dart:io';

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
import 'widgets/search_screen/search_history_item.dart';
import 'widgets/search_screen/search_result_item.dart';

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

  @override
  void initState() {
    super.initState();
    _history = _getHistory();
    _setSearchHistoryWidget();
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

  List<Widget> _getHistory() {
    List<Widget> history = [];
    for (int mock = 0; mock < 5; mock++) {
      history.add(
        SearchHistoryItem(
          index: mock,
          sight: Sight(
              name: mocks[mock][0],
              lat: double.parse(mocks[mock][1]),
              lon: double.parse(mocks[mock][2]),
              url: mocks[mock][3],
              details: mocks[mock][4],
              type: mocks[mock][5]),
          onDelete: (index) {
            _deleteHistoryItem(index);
          },
        ),
      );
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

  void _deleteHistoryItem(int index) {
    setState(
      () {
        if (index != _history.length - 1) {
          _history.removeRange(index, index + 2);
        } else {
          _history.clear();
        }
        _setSearchHistoryWidget();
        _searchBodyWidget = _searchHistoryWidget;
      },
    );
  }

  void _setSearchHistoryWidget() {
    //TODO: Сделать виджет для отсуствия истории
    _searchHistoryWidget = ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: Platform.isAndroid
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
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
            onPressed: () {
              _clearHistory();
            },
            child: Text(
              "Очистить историю",
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
      _setSearchHistoryWidget();
      _searchBodyWidget = _searchHistoryWidget;
    });
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
              url: element[3],
              details: element[4],
              type: element[5]),
        );
      },
    );
    return sightsList;
  }

  void _getHilightSearchResultWidgets(String query) {
    _searchResultsWidget = ListView(
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
    );
  }
}
