import 'package:flutter/material.dart';

class VisitingDragTarget extends StatefulWidget {
  final int index;
  final Function(int dragIndex, int targetIndex) onAccept;
  const VisitingDragTarget({
    required this.onAccept,
    required this.index,
    Key? key,
  }) : super(key: key);

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
              return const SizedBox(
                width: double.infinity,
                height: 198,
              );
            }
          : (context, candidateData, rejectedData) {
              return const SizedBox(
                width: double.infinity,
                height: 32,
              );
            },
      onWillAccept: (data) {
        setState(() {
          isCovered = true;
        });
        return true;
      },
      onAccept: (data) {
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
