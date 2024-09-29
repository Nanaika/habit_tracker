import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class CustomHeatMap extends StatelessWidget {
  const CustomHeatMap(
      {super.key, required this.startDate, required this.dataset});

  final DateTime startDate;
  final Map<DateTime, int> dataset;

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
        colorMode: ColorMode.color,
        defaultColor: Theme.of(context).colorScheme.secondary,
        textColor: Colors.white,
        showColorTip: false,
        // showText: true,
        // scrollable: true,
        size: 35,
        datasets: dataset,
        initDate: DateTime.now(),
        // startDate: startDate,
        colorsets: {
          0: Colors.green.shade100,
          1: Colors.green.shade200,
          2: Colors.green.shade300,
          3: Colors.green.shade400,
          4: Colors.green.shade500,
          5: Colors.green.shade600,
          6: Colors.green.shade700,
          7: Colors.green.shade800,
          8: Colors.green.shade900,
        });
  }
}
