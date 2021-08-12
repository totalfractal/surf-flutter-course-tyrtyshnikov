import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';

import '../../sight_details.dart';

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem({
    Key? key,
    required this.sight,
    required this.onDelete,
    required this.index,
  }) : super(key: key);

  final int index;
  final Sight sight;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                sight.name,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText2!
                    .copyWith(color: lmSecondary2Color),
                maxLines: 3,
              ),
            ),
          ),
          Ink(
            child: IconButton(
                onPressed: () {
                  onDelete(index);
                },
                icon: ImageIcon(
                  AssetImage("res/icons/other/Delete.png"),
                  color: lmSecondary2Color,
                )),
          )
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SightDetails(
                      sight: sight,
                    )));
      },
    );
  }
}
