import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  bool _isFieldsFill = false;
  ButtonStyle _inactiveCreateButtonStyle;

  FocusNode _nameFieldFocusNode = FocusNode();
  FocusNode _latFieldFocusNode = FocusNode();
  FocusNode _lonFieldFocusNode = FocusNode();
  FocusNode _descriptionFieldFocusNode = FocusNode();

  TextEditingController _nameFieldTextController = TextEditingController();
  TextEditingController _latFieldTextController = TextEditingController();
  TextEditingController _lonFieldTextController = TextEditingController();
  TextEditingController _descriptionFieldTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _inactiveCreateButtonStyle = globals.isDarkMode
        ? Theme.of(context).elevatedButtonTheme.style.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(dmMainColor),
            foregroundColor: MaterialStateProperty.all(dmInactiveBlackColor))
        : Theme.of(context).elevatedButtonTheme.style.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(245, 245, 245, 1)),
            foregroundColor: MaterialStateProperty.all(lmInactiveBlackColor));
    return Scaffold(
     
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          child: AppBar(
            leadingWidth: 75,
            leading: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8),
              child: TextButton(
                child: Text(
                  "Отмена",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: globals.isDarkMode
                          ? dmSecondary2Color
                          : lmSecondary2Color),
                ),
                onPressed: () {
                  print("Отмена");
                },
              ),
            ),
            title: const Text("Новое место"),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 56)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 48),
            child: SingleChildScrollView(
              
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            "КАТЕГОРИЯ",
                            style: Theme.of(context).primaryTextTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Не выбрано",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        .copyWith(
                                            color: globals.isDarkMode
                                                ? dmSecondary2Color
                                                : lmSecondary2Color),
                                  ),
                                ),
                                Container(
                                    child: ImageIcon(
                                  AssetImage("res/icons/other/View.png"),
                                )),
                              ],
                            ),
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
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
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            "НАЗВАНИЕ",
                            style: Theme.of(context).primaryTextTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: NewPlaceTextField(
                              focusNode: _nameFieldFocusNode,
                              textController: _nameFieldTextController, 
                              inputType: TextInputType.text,
                              maxLength: 100,
                              hintText: "введите название",),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 24, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                "ШИРОТА",
                                style: Theme.of(context).primaryTextTheme.headline6,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              child: NewPlaceTextField(
                                  focusNode: _latFieldFocusNode,
                                  textController: _latFieldTextController, 
                                  inputType: TextInputType.number,
                                  maxLength: 10,
                                  hintText: "...",
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 24, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                "ДОЛГОТА",
                                style: Theme.of(context).primaryTextTheme.headline6,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 - 25,
                              child: NewPlaceTextField(
                                  focusNode: _lonFieldFocusNode,
                                  textController: _lonFieldTextController, 
                                  inputType: TextInputType.number,
                                  maxLength: 10,
                                  hintText: "...",
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                    child: Text("Указать на карте",),
                    onPressed: () { print("Указать на карте"); },),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 37),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            "ОПИСАНИЕ",
                            style: Theme.of(context).primaryTextTheme.headline6,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: NewPlaceTextField(
                              focusNode: _descriptionFieldFocusNode,
                              textController: _descriptionFieldTextController, 
                              inputType: TextInputType.text,
                              maxLength: 1000,
                              hintText: "введите текст",),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: _isFieldsFill
                    ? Theme.of(context).elevatedButtonTheme
                    : _inactiveCreateButtonStyle,
                onPressed: () {},
                child: Text(
                  'СОЗДАТЬ',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewPlaceTextField extends StatefulWidget {
  const NewPlaceTextField({
    Key key,
    @required this.focusNode,
    @required this.textController, 
    @required this.inputType,
    this.maxLength = 60, 
    this.hintText = "", 
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textController;
  final TextInputType inputType;
  final int maxLength;
  final String hintText;

  @override
  _NewPlaceTextFieldState createState() => _NewPlaceTextFieldState();
}

class _NewPlaceTextFieldState extends State<NewPlaceTextField> {
  @override
  Widget build(BuildContext context) {
    
    return TextField(

      maxLength: widget.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      keyboardType: widget.inputType,
      cursorWidth: 1,
      maxLines: null,
      minLines: 5,
      style: Theme.of(context).primaryTextTheme.bodyText2,
      focusNode: widget.focusNode,
      controller: widget.textController,
      //cursorColor: dmWhiteColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        counterText: "",
        hintText: widget.hintText,
        hintStyle: Theme.of(context).primaryTextTheme.bodyText2.copyWith(color: lmInactiveBlackColor),
          suffixIcon: Visibility(
        visible: widget.textController.text.isNotEmpty,
        child: IconButton(
          icon: ImageIcon(
            AssetImage("res/icons/other/Clear.png"),
            color: IconTheme.of(context).color,
          ),
          onPressed: () {
            setState(() {
              widget.textController.clear();
            });
          },
        ),
      )),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
