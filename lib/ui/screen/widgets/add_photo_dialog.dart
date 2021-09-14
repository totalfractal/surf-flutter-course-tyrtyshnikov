import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

class AddPhotoDialog extends StatelessWidget {
  const AddPhotoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              color: isDarkMode ? dmMainColor : lmWhiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: const [
                  AddPhotoDialogItem(
                      icon: 'res/icons/other/Camera.png', name: 'Камера'),
                  Divider(
                    color: lmInactiveBlackColor,
                  ),
                  AddPhotoDialogItem(
                      icon: 'res/icons/other/Photo.png', name: 'Фотография'),
                  Divider(
                    color: lmInactiveBlackColor,
                  ),
                  AddPhotoDialogItem(
                      icon: 'res/icons/other/Fail.png', name: 'Файл'),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text(
                'ОТМЕНА',
              ),
              style: ButtonStyle(
                backgroundColor: isDarkMode
                    ? MaterialStateProperty.all(dmMainColor)
                    : MaterialStateProperty.all(lmWhiteColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
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

class AddPhotoDialogItem extends StatelessWidget {
  final String icon;
  final String name;
  const AddPhotoDialogItem({
    required this.icon,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(true);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ImageIcon(
                AssetImage(icon),
                color: isDarkMode ? dmWhiteColor : lmSecondary2Color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                name,
                style: Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                    color: isDarkMode ? dmWhiteColor : lmSecondary2Color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
