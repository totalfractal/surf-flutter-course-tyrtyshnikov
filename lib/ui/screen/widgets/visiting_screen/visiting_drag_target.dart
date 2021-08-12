import 'package:flutter/material.dart';

class VisitingDragTarget extends StatefulWidget {
  const VisitingDragTarget(
      {Key? key, required this.onAccept, required this.index})
      : super(key: key);

  final int index;
  final Function(int dragIndex, int targetIndex) onAccept;

  @override
  _VisitingDragTargetState createState() => _VisitingDragTargetState();
}

class _VisitingDragTargetState extends State<VisitingDragTarget> {
  bool isCovered = false;
  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      builder: isCovered
          ? (context, candidateData, rejectedData) {
              return Container(
                width: double.infinity,
                height: 198,
              );
            }
          : (context, candidateData, rejectedData) {
              return Container(
                width: double.infinity,
                height: 32,
              );
            },
      onWillAccept: (data) {
        print(data);
        setState(() {
          isCovered = true;
        });
        return true;
      },
      onAccept: (int data) {
        print((data));
        widget.onAccept(data, widget.index);
        setState(() {
          isCovered = false;
        });
      },
      onLeave: (details) {
        setState(() {
          isCovered = false;
        });
      },
    );
  }
}
