

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadiusSlider extends StatefulWidget {

  @override
  _RadiusSliderState createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Colors.redAccent,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: _value,
        min: 0,
        max: 100,
        divisions: 10,
        label: '$_value',
        onChanged: (value) {
          setState(
                () {
              _value = value;
            },
          );
        },
      ),
    );
  }


}