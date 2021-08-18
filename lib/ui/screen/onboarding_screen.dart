import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  final int pages = 3;

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("Пропустить"),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: PageView(
                  onPageChanged: (nextIndex) {
                    setState(() {
                      _currentPage = nextIndex;
                    });
                  },
                  children: [
                    _getFrameWidget(
                      context,
                      image: ImageIcon(
                        AssetImage("res/icons/tutorial/frame1.png"),
                        size: 100,
                      ),
                      headText: "Доброе пожаловать \n в Путеводитель",
                      text: "Ищи новые локации и сохраняй самые любимые.",
                    ),
                    _getFrameWidget(
                      context,
                      image: ImageIcon(
                        AssetImage("res/icons/tutorial/frame2.png"),
                        size: 100,
                      ),
                      headText: "Построй маршрут \n и отправляйся в путь",
                      text: "Достигай цели максимально быстро и комфортно.",
                    ),
                    _getFrameWidget(
                      context,
                      image: ImageIcon(
                        AssetImage("res/icons/tutorial/frame3.png"),
                        size: 100,
                      ),
                      headText: "Добавляй места, \n которые нашёл сам",
                      text:
                          "Делись самыми интересными и помоги нам стать лучше!",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 117),
                child: _indicatorWidget(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _currentPage == widget.pages - 1,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("НАЧАТЬ"),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _indicatorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.pages; i++)
          IndicatorItem(isSelected: _currentPage == i)
      ],
    );
  }

  Widget _getFrameWidget(BuildContext context,
      {required Widget image, required String headText, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 42),
          child: image,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            headText,
            style: Theme.of(context).primaryTextTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 244,
          child: Text(
            text,
            style: Theme.of(context).primaryTextTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: isSelected ? 24 : 8,
        height: 8,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? isDarkMode
                      ? dmGreenColor
                      : lmGreenColor
                  : lmInactiveBlackColor),
        ),
      ),
    );
  }
}
