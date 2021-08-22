import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

class SearchHistoryItem extends StatelessWidget {
  final int index;
  final Sight sight;
  final Function(int) onDelete;
  const SearchHistoryItem({
    required this.sight,
    required this.onDelete,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Text(
              sight.name,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText2!
                  .copyWith(color: lmSecondary2Color),
              maxLines: 3,
            ),
          ),
          Ink(
            child: IconButton(
              onPressed: () {
                onDelete(index);
              },
              icon: const ImageIcon(
                AssetImage('res/icons/other/Delete.png'),
                color: lmSecondary2Color,
              ),
            ),
          ),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push<SightDetails>(
          context,
          MaterialPageRoute(
            builder: (context) => SightDetails(
              sight: sight,
            ),
          ),
        );
      },
    );
  }
}
