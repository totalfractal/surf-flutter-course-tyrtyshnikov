import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

class AddPhotosOfSight extends StatefulWidget {
  const AddPhotosOfSight({
    Key? key,
  }) : super(key: key);

  @override
  _AddPhotosOfSightState createState() => _AddPhotosOfSightState();
}

class _AddPhotosOfSightState extends State<AddPhotosOfSight> {
  List<Widget> _photosWidgets = [];
  //Row _photosRow = Row();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AddButton(
            onTap: () {
              _addPhoto(PhotoOfSight(
                key: ValueKey("Photo #${_photosWidgets.length}"),
                image: Image.network(_getPhoto()),
                onDeleteTap: () => _deletePhoto(_photosWidgets.length - 1),
              ));
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _photosWidgets,
            ),
          ),
        ),
      ],
    );
  }

  void _getPhotosWidgets() {
    List<PhotoOfSight> newPhotoList = [];
    for (int index = 0; index < _photosWidgets.length; index++) {
      newPhotoList.add(PhotoOfSight(
        image: Image.network(_getPhoto()),
        onDeleteTap: () => _deletePhoto(index),
      ));
    }
    _photosWidgets = newPhotoList;
  }

  void _addPhoto(PhotoOfSight photo) {
    setState(() {
      _photosWidgets.add(photo);
    });
  }

  void _deletePhoto(int index) {
    setState(() {
      _photosWidgets.removeAt(index);
      _getPhotosWidgets();
      // _photosRow = _getPhotosRow();
    });
  }

  String _getPhoto() {
    return faker.image
        .image(width: 100, height: 100, keywords: const ["place"], random: true);
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isDarkMode
                      ? dmGreenColor.withOpacity(0.4)
                      : lmGreenColor.withOpacity(0.4),
                  width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Icon(
            Icons.add,
            size: 40,
            color: isDarkMode ? dmGreenColor : lmGreenColor,
          ),
        ),
        onTap: () => onTap(),);
  }
}

class PhotoOfSight extends StatelessWidget {
  const PhotoOfSight({
    Key? key,
    required this.image,
    required this.onDeleteTap,
  }) : super(key: key);

  final Image image;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 72,
      width: 72,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Stack(
        children: [
          ClipRRect(
            child: image,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(4),
              alignment: Alignment.topRight,
              child: ImageIcon(
                AssetImage(
                  "res/icons/other/Clear.png",
                ),
                color: lmPrimaryColor,
              ),
            ),
            onTap: () => onDeleteTap(),
          )
        ],
      ),
    );
  }
}
