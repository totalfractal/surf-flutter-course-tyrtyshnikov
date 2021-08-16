import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightDetailsPageView extends StatelessWidget {
  const SightDetailsPageView({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      //itemCount: sight.urls.length,
      itemBuilder: (context, index) {
        print("Current index: $index");
        return Image.network(
          sight.urls[index % sight.urls.length],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          },
          fit: BoxFit.cover,
        );
      },
    );
  }
}
