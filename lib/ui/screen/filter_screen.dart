import 'package:flutter/material.dart';
import 'package:places/domain/nearby_sights.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';

class FilterScreen extends StatefulWidget {
  final ValueSetter<List<Sight>> onFiltersChanged;
  const FilterScreen({
    required this.onFiltersChanged,
    Key? key,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final NearbySightsFinder _nearbySightsFinder = NearbySightsFinder();
  RangeValues _currentRangeValues = const RangeValues(100, 2000);
  int _nearbyCount = 0;
  List<Sight> _nearbySights = [];
  final GlobalKey<_CategoryFilterIconState> _cafeIconKey = GlobalKey();
  final GlobalKey<_CategoryFilterIconState> _hotelIconKey = GlobalKey();
  final GlobalKey<_CategoryFilterIconState> _museumIconKey = GlobalKey();
  final GlobalKey<_CategoryFilterIconState> _parkIconKey = GlobalKey();
  final GlobalKey<_CategoryFilterIconState> _partPlaceIconKey = GlobalKey();
  final GlobalKey<_CategoryFilterIconState> _restourantIconKey = GlobalKey();

  // ignore: unused_field
  bool? _isCafePressed;
  // ignore: unused_field
  bool? _isHotelPressed;
  // ignore: unused_field
  bool? _isMuseumPressed;
  // ignore: unused_field
  bool? _isParkPressed;
  // ignore: unused_field
  bool? _isPartPlacePressed;
  // ignore: unused_field
  bool? _isRestourantPressed;

  // ignore: use_late_for_private_fields_and_variables
  CategoryFilter? _cafeFilter;
  CategoryFilter? _hotelFilter;
  // ignore: use_late_for_private_fields_and_variables
  CategoryFilter? _museumFilter;
  // ignore: use_late_for_private_fields_and_variables
  CategoryFilter? _parkFilter;
  CategoryFilter? _partPlaceFilter;
  CategoryFilter? _restourantFilter;

  @override
  void initState() {
    _isCafePressed = false;
    _isHotelPressed = false;
    _isMuseumPressed = false;
    _isParkPressed = false;
    _isPartPlacePressed = false;
    _isRestourantPressed = false;
    _nearbySights =
        _nearbySightsFinder.calcNearbySightsByRange(_currentRangeValues);
    _nearbyCount = _nearbySights.length;

    _cafeFilter = CategoryFilter(
      iconKey: _cafeIconKey,
      name: 'Кафе',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Cafe.png'
          : 'res/icons/catalog/white/Cafe.png',
      onPressed: (value) {
        _isCafePressed = value;
      },
    );
    _hotelFilter = CategoryFilter(
      iconKey: _hotelIconKey,
      name: 'Отель',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Hotel.png'
          : 'res/icons/catalog/white/Hotel.png',
      onPressed: (value) {
        _isHotelPressed = value;
      },
    );
    _museumFilter = CategoryFilter(
      iconKey: _museumIconKey,
      name: 'Музей',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Museum.png'
          : 'res/icons/catalog/white/Museum.png',
      onPressed: (value) {
        _isMuseumPressed = value;
      },
    );
    _parkFilter = CategoryFilter(
      iconKey: _parkIconKey,
      name: 'Парк',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Park.png'
          : 'res/icons/catalog/white/Park.png',
      onPressed: (value) {
        _isParkPressed = value;
      },
    );
    _partPlaceFilter = CategoryFilter(
      iconKey: _partPlaceIconKey,
      name: 'Особое место',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Particular place.png'
          : 'res/icons/catalog/white/Particular place.png',
      onPressed: (value) {
        _isPartPlacePressed = value;
      },
    );
    _restourantFilter = CategoryFilter(
      iconKey: _restourantIconKey,
      name: 'Ресторан',
      iconImage: globals.isDarkMode
          ? 'res/icons/catalog/black/Restourant.png'
          : 'res/icons/catalog/white/Restourant.png',
      onPressed: (value) {
        _isRestourantPressed = value;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          leading: GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                icon: ImageIcon(
                  const AssetImage('res/icons/other/Arrow.png'),
                  color: IconTheme.of(context).color,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _cafeIconKey.currentState!.unselect();
                    _hotelIconKey.currentState!.unselect();
                    _museumIconKey.currentState!.unselect();
                    _parkIconKey.currentState!.unselect();
                    _partPlaceIconKey.currentState!.unselect();
                    _restourantIconKey.currentState!.unselect();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Очистить',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: globals.isDarkMode ? dmGreenColor : lmGreenColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
          ],
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 56),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'КАТЕГОРИИ',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline3!
                            .copyWith(
                              fontSize: 12,
                              color: const Color.fromRGBO(124, 126, 146, 0.56),
                            ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: _hotelFilter,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: _restourantFilter,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: _partPlaceFilter,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              _parkFilter!,
                              _museumFilter!,
                              _cafeFilter!,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Расстояние',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText1!
                          .copyWith(
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      'от ${_currentRangeValues.start.round()} до ${_currentRangeValues.end.round()} м',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle2!
                          .copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: RangeSlider(
                  values: _currentRangeValues,
                  min: 100,
                  max: 10100,
                  divisions: 100,
                  onChanged: (values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                  onChangeEnd: (values) {
                    _nearbySights = _nearbySightsFinder
                        .calcNearbySightsByRange(_currentRangeValues);
                    _nearbyCount = _nearbySights.length;

                    setState(() {
                      _nearbyCount = _nearbySights.length;
                    });
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.onFiltersChanged(_nearbySights);
                  Navigator.pop(context);
                },
                child: Text(
                  'ПОКАЗАТЬ ($_nearbyCount)',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    required this.name,
    required this.iconImage,
    required this.iconKey,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final GlobalKey iconKey;
  final String name;
  final String iconImage;
  final ValueChanged<bool?> onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryFilterIcon(
          key: iconKey,
          iconImage: iconImage,
          onPressed: onPressed,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            name,
            style: Theme.of(context).primaryTextTheme.headline3!.copyWith(
                  fontSize: 12,
                ),
          ),
        ),
      ],
    );
  }
}

class CategoryFilterIcon extends StatefulWidget {
  const CategoryFilterIcon({
    required this.iconImage,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String iconImage;
  final ValueChanged<bool?> onPressed;

  @override
  _CategoryFilterIconState createState() => _CategoryFilterIconState();
}

class _CategoryFilterIconState extends State<CategoryFilterIcon> {
  bool? _isSelected;

  void unselect() {
    setState(() {
      _isSelected = false;
      widget.onPressed(_isSelected);
    });
  }

  @override
  void initState() {
    _isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        IconButton(
          iconSize: 64,
          splashRadius: 32,
          icon: Image.asset(
            widget.iconImage,
            height: 64,
            color: _isSelected!
                ? lmFilterIconsColor.withOpacity(0.5)
                : lmFilterIconsColor,
          ),
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected!;
            });
            widget.onPressed(_isSelected);
          },
        ),
        Opacity(
          opacity: _isSelected! ? 1.0 : 0.0,
          child: Image.asset(
            'res/icons/other/Tick choice.png',
          ),
        ),
      ],
    );
  }
}
