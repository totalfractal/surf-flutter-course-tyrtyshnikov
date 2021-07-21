import 'package:flutter/material.dart';

import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';

import 'add_sight_screen.dart';

class AddSightScreenCategory extends StatefulWidget {
  const AddSightScreenCategory({Key key, @required this.setCategory})
      : super(key: key);

      final ValueSetter<String> setCategory;

  final List<String> categories = const [
    "Кинотеатр",
    "Ресторан",
    "Особое место",
    "Театр",
    "Музей",
    "Кафе"
  ];

  @override
  _AddSightScreenCategoryState createState() => _AddSightScreenCategoryState();
  }

  


class _AddSightScreenCategoryState extends State<AddSightScreenCategory> {
  List<CategoryModel> sampleData = [];
  String _selectedCategory = "";
  bool _isCategorySelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.categories.forEach((element) {
      sampleData.add(CategoryModel(false, element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Категория"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: sampleData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      sampleData.forEach((element) => element.isSelected = false);
                      sampleData[index].isSelected = true;
                      _selectedCategory = sampleData[index].text;
                      _isCategorySelected = true;
                    });
                  },
                  child: CategoryItem(sampleData[index]),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                height: 48,
                child: AbsorbPointer(
                  absorbing: !_isCategorySelected,
                  child: ElevatedButton(
                    style: _isCategorySelected
                        ? Theme.of(context).elevatedButtonTheme.style
                        : getInactiveButtonStyle(context),
                    onPressed: () {
                      widget.setCategory(_selectedCategory);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "СОХРАНИТЬ",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel _item;
  CategoryItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 24,
            child: Text(
              _item.text,
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
          ),
          Container(
              child: Visibility(
                  visible: _item.isSelected,
                  child: Image.asset(
                    'res/icons/other/Tick.png',
                    color: globals.isDarkMode ? dmGreenColor : lmGreenColor,
                  ))),
        ],
      ),
    );
  }
}

class CategoryModel {
  bool isSelected;
  final String text;

  CategoryModel(this.isSelected, this.text);
}
