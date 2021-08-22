import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen_category.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/add_photos_of_sight.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final TextEditingController _nameFieldTextController =
      TextEditingController();
  final TextEditingController _latFieldTextController = TextEditingController();
  final TextEditingController _lonFieldTextController = TextEditingController();
  final TextEditingController _descriptionFieldTextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFieldsFill = false;
  String _category = 'Не выбрано';

  @override
  void dispose() {
    _nameFieldTextController.dispose();
    _latFieldTextController.dispose();
    _lonFieldTextController.dispose();
    _descriptionFieldTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _inactiveCreateButtonStyle = getInactiveButtonStyle(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        child: AppBar(
          leadingWidth: 75,
          leading: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              child: Text(
                'Отмена',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: globals.isDarkMode
                          ? dmSecondary2Color
                          : lmSecondary2Color,
                    ),
              ),
              onPressed: () {},
            ),
          ),
          title: const Text('Новое место'),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          56,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 48),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                onChanged: () {
                  if (_nameFieldTextController.text.isNotEmpty &&
                      _latFieldTextController.text.isNotEmpty &&
                      _lonFieldTextController.text.isNotEmpty &&
                      _descriptionFieldTextController.text.isNotEmpty &&
                      _category != 'Не выбрано') {
                    setState(() {
                      _isFieldsFill = true;
                    });
                  } else {
                    setState(() {
                      _isFieldsFill = false;
                    });
                  }
                },
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: const AddPhotosOfSight(),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'КАТЕГОРИЯ',
                            style: Theme.of(context).primaryTextTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _category,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: globals.isDarkMode
                                            ? dmSecondary2Color
                                            : lmSecondary2Color,
                                      ),
                                ),
                                const ImageIcon(
                                  AssetImage('res/icons/other/View.png'),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push<AddSightScreenCategory>(
                                context,
                                MaterialPageRoute<AddSightScreenCategory>(
                                  builder: (context) => AddSightScreenCategory(
                                    setCategory: (category) {
                                      setState(
                                        () {
                                          _category = category;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Divider(
                        thickness: 0.8,
                        color: lmInactiveBlackColor.withOpacity(0.24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'НАЗВАНИЕ',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: NewPlaceTextFormField(
                              textController: _nameFieldTextController,
                              inputType: TextInputType.text,
                              maxLength: 100,
                              hintText: 'введите название',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'ШИРОТА',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
                                child: NewPlaceTextFormField(
                                  textController: _latFieldTextController,
                                  inputType: TextInputType.number,
                                  maxLength: 10,
                                  hintText: '...',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'ДОЛГОТА',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
                                child: NewPlaceTextFormField(
                                  textController: _lonFieldTextController,
                                  inputType: TextInputType.number,
                                  maxLength: 10,
                                  hintText: '...',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: const Text(
                          'Указать на карте',
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 37),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'ОПИСАНИЕ',
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: NewPlaceTextFormField(
                              textController: _descriptionFieldTextController,
                              inputType: TextInputType.text,
                              maxLength: 1000,
                              hintText: 'введите текст',
                              isLastNode: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 48,
              child: AbsorbPointer(
                absorbing: !_isFieldsFill,
                child: ElevatedButton(
                  style: _isFieldsFill
                      ? Theme.of(context).elevatedButtonTheme.style
                      : _inactiveCreateButtonStyle,
                  onPressed: () {
                    mocks.add([
                      _nameFieldTextController.text,
                      _latFieldTextController.text,
                      _lonFieldTextController.text,
                      '',
                      _descriptionFieldTextController.text,
                      _category,
                    ]);
                    setState(() {
                      _nameFieldTextController.clear();
                      _latFieldTextController.clear();
                      _lonFieldTextController.clear();
                      _descriptionFieldTextController.clear();
                      _category = 'Не выбрано';
                    });
                  },
                  child: const Text(
                    'СОЗДАТЬ',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ButtonStyle getInactiveButtonStyle(BuildContext context) {
  final _inactiveCreateButtonStyle = globals.isDarkMode
      ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(dmMainColor),
            foregroundColor: MaterialStateProperty.all(dmInactiveBlackColor),
          )
      : Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(245, 245, 245, 1),
            ),
            foregroundColor: MaterialStateProperty.all(lmInactiveBlackColor),
          );
  return _inactiveCreateButtonStyle;
}

class NewPlaceTextFormField extends StatefulWidget {
  const NewPlaceTextFormField({
    required this.textController,
    required this.inputType,
    Key? key,
    // @required this.focusNode,

    this.maxLength = 60,
    this.hintText = '',
    this.isLastNode = false,
  }) : super(key: key);

  final TextEditingController textController;
  final TextInputType inputType;

  final int maxLength;
  final String hintText;
  final bool isLastNode;

  @override
  _NewPlaceTextFormFieldState createState() => _NewPlaceTextFormFieldState();
}

class _NewPlaceTextFormFieldState extends State<NewPlaceTextFormField> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
        });
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) return '';
          return null;
        },
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        keyboardType: widget.inputType,
        cursorWidth: 1,
        maxLines: null,
        minLines: 5,
        style: Theme.of(context).primaryTextTheme.bodyText2,
        controller: widget.textController,
        onTap: () {},
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          suffixIcon: Visibility(
            visible: _hasFocus && widget.textController.text.isNotEmpty,
            child: IconButton(
              icon: ImageIcon(
                const AssetImage('res/icons/other/Clear.png'),
                color: IconTheme.of(context).color,
              ),
              onPressed: () {
                setState(
                  () {
                    widget.textController.clear();
                  },
                );
              },
            ),
          ),
        ),
        textInputAction:
            widget.isLastNode ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: widget.isLastNode
            ? () => FocusScope.of(context).unfocus()
            : () => context.nextEditableTextFocus(),
      ),
    );
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}
