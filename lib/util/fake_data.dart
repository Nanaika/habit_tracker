import 'dart:math';

import '../pages/home_page.dart';

Map<DateTime, int> fake() {
  Map<DateTime, int> data = {};
  for (var i = 0; i < 10000; i++) {
    final date = faker.date;
    data[date.future(DateTime.fromMicrosecondsSinceEpoch(1640979000000000),
        rangeInYears: 2)] = Random().nextInt(10);
  }
  return data;
}