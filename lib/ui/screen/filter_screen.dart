

import 'package:flutter/material.dart';
import 'package:places/domain/nearbySights.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _currentRangeValues = RangeValues(500, 2000);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Расстояние",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText1
                          .copyWith(fontSize: 16)),
                  Text(
                      'от ${_currentRangeValues.start.round()} до ${_currentRangeValues.end.round()} м',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .subtitle2
                          .copyWith(fontSize: 16)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: RangeSlider(
                values: _currentRangeValues,
                min: 100,
                max: 10100,
                divisions: 100,
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.all(16),
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('ПОКАЗАТЬ ()', ),
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}
