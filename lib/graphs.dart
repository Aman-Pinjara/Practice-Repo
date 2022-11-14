// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graph extends StatefulWidget {
  final String modeName;
  final Color modeColor;
  final List<double> graphData;
  const Graph(
      {Key? key,
      required this.modeColor,
      required this.graphData,
      required this.modeName})
      : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final Color black = Colors.black54;
  final Color grey = Colors.grey;
  int selectedD = 10;
  @override
  Widget build(BuildContext context) {
    List<double> times = [];
    avg(times);
    double maxy = times.fold<double>(
        0,
        (previousValue, element) =>
            element > previousValue ? element : previousValue);
    if (maxy % 5 != 0) {
      maxy = maxy.toInt() + 1;
    }
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graph"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.modeName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: widget.modeColor,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[2],
                        borderRadius: BorderRadius.circular(8),
                        color: widget.modeColor,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          isDense: true,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(12),
                          value: selectedD,
                          onChanged: (value) {
                            setState(() {
                              selectedD = value!;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              enabled: widget.graphData.length >= 1000,
                              value: 1000,
                              child: Text(
                                "Last 1000",
                                style: TextStyle(
                                  color: widget.graphData.length >= 1000
                                      ? black
                                      : grey,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              enabled: widget.graphData.length >= 500,
                              value: 500,
                              child: Text(
                                "Last 500",
                                style: TextStyle(
                                  color: widget.graphData.length >= 500
                                      ? black
                                      : grey,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              enabled: widget.graphData.length >= 100,
                              value: 100,
                              child: Text(
                                "Last 100",
                                style: TextStyle(
                                  color: widget.graphData.length >= 100
                                      ? black
                                      : grey,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              enabled: widget.graphData.length > 50,
                              value: 50,
                              child: Text(
                                "Last 50",
                                style: TextStyle(
                                  color: widget.graphData.length >= 50
                                      ? black
                                      : grey,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              enabled: widget.graphData.length > 20,
                              value: 20,
                              child: Text(
                                "Last 20",
                                style: TextStyle(
                                  color: widget.graphData.length >= 20
                                      ? black
                                      : grey,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              enabled: widget.graphData.length > 10,
                              value: 10,
                              child: Text(
                                "Last 10",
                                style: TextStyle(
                                  color: black,
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
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 1),
                          spreadRadius: -12,
                          blurRadius: 29,
                          color: Color.fromRGBO(161, 161, 161, 0.48),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(
                          border: Border(
                            bottom: BorderSide(color: grey, width: 0.3),
                          ),
                        ),
                        maxY: maxy,
                        barGroups: times
                            .map(
                              (e) => BarChartGroupData(
                                x: i++,
                                barRods: [
                                  BarChartRodData(
                                    toY: e,
                                    color: widget.modeColor.withOpacity(0.3),
                                    width: 20,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text(
                              "Each bar is Avg of ${selectedD ~/ 10} solves",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: grey,
                              ),
                            ),
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                if (value == 0) {
                                  return Text("");
                                }
                                if (value == value.toInt()) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: grey,
                                    ),
                                  );
                                }
                                return Text(
                                  value.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: widget.modeColor.withOpacity(0.5),
                            tooltipRoundedRadius: 15.0,
                            fitInsideHorizontally: true,
                            tooltipMargin: 10,
                            getTooltipItem:
                                ((group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                rod.toY.toStringAsFixed(2),
                                const TextStyle(color: Colors.white),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void avg(List<double> times) {
    var rev = widget.graphData.reversed
        .toList()
        .getRange(0, min(selectedD, widget.graphData.length))
        .toList();
    int num = selectedD ~/ 10;
    for (var i = 0; i < min(selectedD, widget.graphData.length); i += num) {
      double temp = 0;
      for (var j = i; j < i + num; j++) {
        temp += rev[j];
      }
      times.add(temp / num);
    }
    for (var i = 0; i < times.length / 2; i++) {
      var temp = times[i];
      times[i] = times[times.length - 1 - i];
      times[times.length - 1 - i] = temp;
    }
  }
}
