import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

List<List<String>> onboardingData = [
  [
    'res/icons/tutorial/frame1.png',
    'Доброе пожаловать \n в Путеводитель',
    'Ищи новые локации и сохраняй самые любимые.',
  ],
  [
    'res/icons/tutorial/frame2.png',
    'Построй маршрут \n и отправляйся в путь',
    'Достигай цели максимально быстро и комфортно.',
    'res/icons/tutorial/frame3.png',
  ],
  [
    'res/icons/tutorial/frame3.png',
    'Добавляй места, \n которые нашёл сам',
    'Делись самыми интересными и помоги нам стать лучше!',
  ],
];

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _pages = 3;
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text('Пропустить'),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                  children: onboardingData
                      .map(
                        (frameInfo) => OnboardingFrame(
                          image: frameInfo[0],
                          headText: frameInfo[1],
                          text: frameInfo[2],
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 117),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _pages; i++)
                      IndicatorItem(isSelected: _currentPage == i),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _currentPage == _pages - 1,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('НАЧАТЬ'),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class OnboardingFrame extends StatelessWidget {
  final String image;
  final String headText;
  final String text;

  const OnboardingFrame({
    required this.image,
    required this.headText,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 42),
          child: ImageIcon(
            AssetImage(
              image,
            ),
            size: 100,
          ),
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
    required this.isSelected,
    Key? key,
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
                : lmInactiveBlackColor,
          ),
        ),
      ),
    );
  }
}
