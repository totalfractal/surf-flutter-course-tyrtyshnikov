import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';

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
            onTap: _addPhoto,
          ),
        ),
        Expanded(
          child: OverscrollGlowAbsorber(
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: Platform.isAndroid
                  ? const ClampingScrollPhysics()
                  : const BouncingScrollPhysics(),
              children: _photosWidgets,
            ),
          ),
        ),
      ],
    );
  }

  void _getPhotosWidgets() {
    _photosWidgets = [
      for (int i = 0; i < _photosWidgets.length; i++)
        PhotoOfSight(
          key: UniqueKey(),
          index: i,
          image: _photosWidgets[i].image,
          onDelete: _deletePhoto,
        ),
    ];
  }

  void _addPhoto() {
    final photo = PhotoOfSight(
      key: ValueKey('Photo #${_photosWidgets.length}'),
      index: _photosWidgets.length,
      image: Image.network(_getPhoto()),
      onDelete: _deletePhoto,
    );
    setState(() {
      _photosWidgets.add(photo);
      _getPhotosWidgets();
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
      width: 100,
      height: 100,
      keywords: const ['place'],
      random: true,
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

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
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Icon(
          Icons.add,
          size: 40,
          color: isDarkMode ? dmGreenColor : lmGreenColor,
        ),
      ),
      onTap: onTap,
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }
}

class PhotoOfSight extends StatefulWidget {
  final int index;
  final Image image;
  final Function(int) onDelete;
  const PhotoOfSight({
    required this.index,
    required this.image,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

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
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 72,
        width: 72,
        child: Stack(
          children: [
            ClipRRect(
              child: widget.image,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.topRight,
                child: const ImageIcon(
                  AssetImage(
                    'res/icons/other/Clear.png',
                  ),
                  color: lmPrimaryColor,
                ),
              ),
              onTap: () => widget.onDelete(widget.index),
            ),
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
