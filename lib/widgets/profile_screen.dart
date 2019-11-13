import 'package:flutter/material.dart';
import 'package:todog/todog_colors.dart';

import 'charts/bar_chart.dart';
import 'charts/bubble_chart.dart';
import 'charts/circle_chart.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ToDogColors.merino,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleChart(title: 'Activity'),
                          Container(
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('100%'),
                                    Spacer(
                                      flex: 5,
                                    ),
                                    Text('50%'),
                                    Spacer(
                                      flex: 4,
                                    ),
                                    Text('10%'),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                      child: Text(''),
                                    ),
                                  ],
                                ),
                                _buildVerticalBar(
                                    color: ToDogColors.valencia,
                                    title: '1',
                                    value: .6),
                                _buildVerticalBar(
                                    color: ToDogColors.valencia,
                                    title: '2',
                                    value: .7),
                                _buildVerticalBar(
                                    color: ToDogColors.valencia,
                                    title: '3',
                                    value: .8),
                                _buildVerticalBar(
                                    color: ToDogColors.valencia,
                                    title: '4',
                                    value: 1),
                                _buildVerticalBar(
                                    color: ToDogColors.valencia,
                                    title: '5',
                                    value: .9),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ToDogColors.merino,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleChart(title: 'Training'),
                          _buildBar(
                              title: 'Beside',
                              color: ToDogColors.valencia,
                              value: 1),
                          _buildBar(
                              title: 'Sit down',
                              color: ToDogColors.downy,
                              value: 1),
                          _buildBar(
                              title: 'Voice',
                              color: ToDogColors.yellow,
                              value: .5),
                          SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ToDogColors.merino,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleChart(title: 'Nutrition'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Protein'),
                                ),
                                Expanded(
                                  child: CustomPaint(
                                      painter: BubbleChart(
                                          values: <double>[.2, .2, .8, .8, .6],
                                          color: ToDogColors.orange),
                                      child: Container(
                                        width: double.infinity,
                                        height: 12,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Carbohydrate'),
                                ),
                                Expanded(
                                  child: CustomPaint(
                                      painter: BubbleChart(
                                          values: <double>[.2, .4, .6, .2, .2],
                                          color: ToDogColors.downy),
                                      child: Container(
                                        width: double.infinity,
                                        height: 12,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Fats'),
                                ),
                                Expanded(
                                  child: CustomPaint(
                                      painter: BubbleChart(
                                          values: <double>[.2, .3, .3, .8, .5],
                                          color: ToDogColors.valencia),
                                      child: Container(
                                        width: double.infinity,
                                        height: 12,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text('Calories'),
                                ),
                                Expanded(
                                  child: CustomPaint(
                                      painter: BubbleChart(
                                          values: <double>[.2, .95, .9, .7, .7],
                                          color: ToDogColors.yellow),
                                      child: Container(
                                        width: double.infinity,
                                        height: 12,
                                      )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ToDogColors.merino,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleChart(title: "Happiness"),
                          CustomPaint(
                            painter: CircleChart(value: .80),
                            child: Container(
                              width: 160,
                              height: 160,
                              child: Center(
                                child: Text(
                                  '80%',
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTitleChart({String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 0, 18),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  Column _buildVerticalBar({double value, String title, Color color}) {
    return Column(
      children: <Widget>[
        value == 1
            ? Container()
            : Spacer(
                flex: ((1 - value) * 100).toInt(),
              ),
        Expanded(
          flex: (value * 100).toInt(),
          child: Container(
            width: 8,
            height: double.infinity,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
          child: Text(title),
        ),
      ],
    );
  }

  Widget _buildBar({Color color, String title, double value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomPaint(
                painter: BarChart(value: value, color: color),
                child: Container(
                  height: 12,
                ),
              ),
            ),
          ),
          Text('${(value * 100).toInt().toString().padLeft(3)}%')
        ],
      ),
    );
  }
}
