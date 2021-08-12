import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({Key? key, required this.sight, required this.query})
      : super(key: key);

  final String query;
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 56,
              width: 56,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  sight.url,
                  height: 56,
                  width: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        text: TextSpan(
                            children: highlightOccurrences(
                                sight.name,
                                query,
                                Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.w500)),
                            style:
                                Theme.of(context).primaryTextTheme.bodyText2),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        sight.type,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline3!
                            .copyWith(
                                color: isDarkMode
                                    ? dmSecondary2Color
                                    : lmSecondary2Color),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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

  List<TextSpan> highlightOccurrences(
      String source, String query, TextStyle hilightTextTheme) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: hilightTextTheme,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
