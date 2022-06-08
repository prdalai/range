import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heartmates/modules/discover/bloc/discover_bloc.dart';
import 'package:heartmates/modules/profile/bloc/profile_bloc.dart';

class HeightRangeSlider extends StatefulWidget {
  final String? heightPreferenceMin;
  final String? heightPreferenceMax;
  final String? heightPreferenceUnit;
  const HeightRangeSlider({Key? key,this.heightPreferenceMin,this.heightPreferenceMax,this.heightPreferenceUnit}) : super(key: key);

  @override
  _HeightRangeSliderState createState() => _HeightRangeSliderState();
}

class _HeightRangeSliderState extends State<HeightRangeSlider> {
  RangeValues _currentRangeValues = RangeValues(4.0,7.1);
  RangeValues _currenHeightRangeValues = RangeValues(100,200);
  String minCm = "100";
  String maxCm = "200";
  String minFt = "4.0";
  String maxFt = "7.1";
  int status = 1;
  String unit ="ft";
  @override
  Widget build(BuildContext context) {

    if(widget.heightPreferenceUnit == "ft")
    {
      int minFeet = int.parse(widget.heightPreferenceMin!);
      var minFt = minFeet*0.0328084;
      int maxFeet = int.parse(widget.heightPreferenceMax!);
      var maxFt = maxFeet*0.0328084;
      _currentRangeValues = RangeValues(minFt,maxFt);
    }
    if(widget.heightPreferenceUnit == "cm" )
    {
      minCm = widget.heightPreferenceMin!;
      maxCm = widget.heightPreferenceMax!;
      _currenHeightRangeValues = RangeValues(double.parse(minCm),double.parse(maxCm));
    }
    return Column(
      children: [
        Row(
          children: [
            Text("Height",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            status == 1?
            Text("$minFt-$maxFt",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff646464),
                fontSize: 18,
              ),
            ):Text("$minCm-$maxCm",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff646464),
                fontSize: 18,
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        status = 1;
                        unit ="ft";
                      });
                    },
                    child: Text("ft",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: status == 1 ?  Colors.white: Color(0xff3E5C59),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top:1.0,bottom: 1.0),
                      backgroundColor: status == 1 ? Color(0xff365D58) : Color(0xffffffff),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        status = 2;
                        unit ="cm";
                      });
                    },
                    child: Text("cm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: status == 2 ?  Colors.white: Color(0xff80B4AD),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top:1.0,bottom: 1.0),
                      backgroundColor: status == 2 ? Color(0xff365D58) : Color(0xffffffff),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        status == 1?
        RangeSlider(
          activeColor: Color(0xFF3E5C59),
          inactiveColor: Color(0xFF80B4AD),
          values: _currentRangeValues,
          min: 4.0,
          max: 7.1,
          labels: RangeLabels(
            _currentRangeValues.start.toString(),
            _currentRangeValues.end.toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              minFt = values.start.toStringAsFixed(1);
              maxFt = values.end.toStringAsFixed(1);
              unit = "ft";
            });
            BlocProvider.of<ProfileBloc>(context).heightPreferenceChanged(values.start.toStringAsFixed(1),values.end.toStringAsFixed(1),unit);
          },
        ):
        RangeSlider(
          activeColor: Color(0xFF3E5C59),
          inactiveColor: Color(0xFF80B4AD),
          values: _currenHeightRangeValues,
          min: 100,
          max: 200,
          labels: RangeLabels(
            _currenHeightRangeValues.start.toString(),
            _currenHeightRangeValues.end.toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currenHeightRangeValues = values;
              minCm = values.start.round().toString();
              maxCm = values.end.round().toString();
              unit= "cm";
            });
            BlocProvider.of<ProfileBloc>(context).heightPreferenceChanged(values.start.round().toString(),values.end.round().toString(),unit);
          },
        ),
      ],
    );
  }
}
