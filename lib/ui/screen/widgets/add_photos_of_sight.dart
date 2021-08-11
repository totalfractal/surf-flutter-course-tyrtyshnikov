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
  List<PhotoOfSight> _photosWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AddButton(
            onTap: () {
              _addPhoto();
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
    List<PhotoOfSight> newPhotoList = [
      for (int i = 0; i < _photosWidgets.length; i++)
        PhotoOfSight(
          index: i,
          image: _photosWidgets[i].image,
          onDelete: (index) => _deletePhoto(index),
        )
    ];
    _photosWidgets = newPhotoList;
  }

  void _addPhoto() {
    var photo = PhotoOfSight(
      key: ValueKey("Photo #${_photosWidgets.length}"),
      index: _photosWidgets.length,
      image: Image.network(_getPhoto()),
      onDelete: (index) => _deletePhoto(index),
    );
    setState(() {
      _photosWidgets.add(photo);
    });
  }

  void _deletePhoto(int index) {
    setState(() {
      _photosWidgets.removeAt(index);
      _getPhotosWidgets();
    });
  }

  String _getPhoto() {
    return faker.image.image(
        width: 100, height: 100, keywords: const ["place"], random: true);
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
    return InkWell(
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
        onTap: () => onTap(),
        borderRadius: BorderRadius.all(Radius.circular(12)));
  }
}

class PhotoOfSight extends StatefulWidget {
  const PhotoOfSight({
    Key? key,
    required this.index,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  final int index;
  final Image image;
  final Function(int) onDelete;

  @override
  _PhotoOfSightState createState() => _PhotoOfSightState();
}

class _PhotoOfSightState extends State<PhotoOfSight> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 72,
        width: 72,
        child: Stack(
          children: [
            ClipRRect(
              child: widget.image,
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
              onTap: () => widget.onDelete(widget.index),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          widget.onDelete(widget.index);
        });
      },
    );
  }
}
