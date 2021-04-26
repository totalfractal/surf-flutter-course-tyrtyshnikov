import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

class SightCard extends StatelessWidget {
  const SightCard({
    key,
    this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      //height: MediaQuery.of(context).size.width * 0.5,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.red,
                ),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                            sight.type.isEmpty
                                ? "категория"
                                : sight.type.toLowerCase(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        color: Colors.green,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child:
                              Text(sight.name.isEmpty ? "Название" : sight.name,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: hexToColor("#3B3E5B"),
                                  )),
                        ),
                        Container(
                          child: Text("закрыто до 9:00",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: hexToColor("#7C7E92"),
                                  decoration: TextDecoration.none)),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
