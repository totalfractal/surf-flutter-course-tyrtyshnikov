import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/filter_screen.dart';
import 'package:places/ui/screen/res/colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.onFiltersChanged,
    required this.onQueryChanged,
    required this.onFocusChanged,
    this.autofocus,
  }) : super(key: key);

  final ValueSetter<List<Sight>> onFiltersChanged;
  final ValueSetter<String> onQueryChanged;
  final ValueSetter<bool> onFocusChanged;

  final bool? autofocus;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _hasFocus = false;
  /* List<Sight> _sightsList = [];

  List<Sight> getSightsList() => _sightsList; */

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: 52,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _hasFocus = hasFocus;
          });
          if (_textController.text.isEmpty && _hasFocus) {
            widget.onFocusChanged(hasFocus);
          }
        },
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              autofocus: widget.autofocus ?? false,
              onChanged: (value) {
                setState(() {});
                widget.onQueryChanged(value);
              },
              style: Theme.of(context).primaryTextTheme.bodyText2,
              cursorHeight: 24,
              cursorWidth: 1,
              controller: _textController,
              decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: globals.isDarkMode ? dmDarkColor : lmGreyColor,
                  prefixIcon: ImageIcon(
                    AssetImage("res/icons/other/Search.png"),
                    color: lmInactiveBlackColor,
                  ),
                  suffixIcon: Visibility(
                    visible: _hasFocus && _textController.text.isNotEmpty,
                    child: IconButton(
                      alignment: Alignment.center,
                      icon: ImageIcon(
                        AssetImage("res/icons/other/Clear.png"),
                        color: IconTheme.of(context).color,
                      ),
                      onPressed: () {
                        setState(() {
                          _textController.clear();
                        });
                        widget.onQueryChanged("");
                      },
                    ),
                  )),
            ),
            Positioned(
              right: 4,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                child: Visibility(
                  visible: !_hasFocus,
                  child: InkWell(
                      radius: 50,
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterScreen(
                                      onFiltersChanged: (List<Sight> value) =>
                                          widget.onFiltersChanged(value),
                                    )));
                      },
                      child: ImageIcon(
                        AssetImage("res/icons/other/Filter.png"),
                        size: 40,
                        color: globals.isDarkMode ? dmGreenColor : lmGreenColor,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
