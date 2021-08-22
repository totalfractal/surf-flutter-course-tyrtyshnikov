import 'package:flutter/material.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';

class AddSightScreenCategory extends StatefulWidget {
  final ValueSetter<String> setCategory;
  const AddSightScreenCategory({
    required this.setCategory,
    Key? key,
  }) : super(key: key);

  @override
  _AddSightScreenCategoryState createState() => _AddSightScreenCategoryState();
}

class _AddSightScreenCategoryState extends State<AddSightScreenCategory> {
  final List<CategoryModel> _categoriesModels = <CategoryModel>[
    for (var element in _categories)
      CategoryModel(isSelected: false, text: element),
  ];
  String _selectedCategory = '';
  bool _isCategorySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ImageIcon(
            const AssetImage('res/icons/other/Arrow.png'),
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Категория'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Stack(
          children: [
            OverscrollGlowAbsorber(
              child: ListView.builder(
                itemCount: _categoriesModels.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        for (final model in _categoriesModels) {
                          model.isSelected = false;
                        }
                        _categoriesModels[index].isSelected = true;
                        _selectedCategory = _categoriesModels[index].text;
                        _isCategorySelected = true;
                      });
                    },
                    child: CategoryItem(item: _categoriesModels[index]),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
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
                    child: const Text(
                      'СОХРАНИТЬ',
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
  final CategoryModel item;
  const CategoryItem({
    required this.item,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 24,
            child: Text(
              item.text,
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
          ),
          SizedBox(
            child: Visibility(
              visible: item.isSelected,
              child: Image.asset(
                'res/icons/other/Tick.png',
                color: globals.isDarkMode ? dmGreenColor : lmGreenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryModel {
  bool isSelected;
  final String text;

  CategoryModel({this.isSelected = true, this.text = ''});
}

final List<String> _categories = [
  'Кинотеатр',
  'Ресторан',
  'Особое место',
  'Театр',
  'Музей',
  'Кафе',
];
