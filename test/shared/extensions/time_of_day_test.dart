// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vaani/shared/extensions/time_of_day.dart';

const TIME_08_30_AM = TimeOfDay(hour: 8, minute: 30);
const TIME_09_00_AM = TimeOfDay(hour: 9, minute: 0);
const TIME_10_30_AM = TimeOfDay(hour: 10, minute: 30);
const TIME_11_00_AM = TimeOfDay(hour: 11, minute: 0);
const TIME_12_00_PM = TimeOfDay(hour: 12, minute: 0);
const TIME_10_00_PM = TimeOfDay(hour: 22, minute: 0);
void main() {
  group('ToTimeOfDay extension', () {
    test('Duration to TimeOfDay conversion', () {
      final duration = Duration(hours: 10, minutes: 30);
      expect(duration.toTimeOfDay(), TIME_10_30_AM);
    });

    test('Duration to TimeOfDay conversion with more than 24 hours', () {
      final duration = Duration(hours: 32, minutes: 30);
      expect(duration.toTimeOfDay(), TIME_08_30_AM);
    });
  });

  group('ToDuration extension', () {
    test('TimeOfDay to Duration conversion', () {
      final duration = TIME_10_30_AM.toDuration();
      expect(duration.inHours, 10);
      expect(duration.inMinutes % 60, 30);
    });
  });

  group('Compare TimeOfDay', () {
    test('compareTo method', () {
      expect(TIME_10_30_AM.compareTo(TIME_12_00_PM), -1);
      expect(TIME_12_00_PM.compareTo(TIME_10_30_AM), 1);
      expect(TIME_10_30_AM.compareTo(TIME_10_30_AM), 0);
    });

    test('operator <', () {
      expect(TIME_10_30_AM < TIME_12_00_PM, true);
      expect(TIME_12_00_PM < TIME_10_30_AM, false);
    });

    test('operator >', () {
      expect(TIME_10_30_AM > TIME_10_00_PM, false);
      expect(TIME_10_00_PM > TIME_10_30_AM, true);
    });

    test('operator <=', () {
      expect(TIME_10_30_AM <= TIME_12_00_PM, true);
      expect(TIME_12_00_PM <= TIME_10_30_AM, false);
      expect(TIME_10_30_AM <= TIME_10_30_AM, true);
    });

    test('operator >=', () {
      expect(TIME_10_30_AM >= TIME_10_00_PM, false);
      expect(TIME_10_00_PM >= TIME_10_30_AM, true);
      expect(TIME_10_30_AM >= TIME_10_30_AM, true);
    });
  });

  group('isBetween method', () {
    void testIsBetween(
      TimeOfDay time,
      TimeOfDay start,
      TimeOfDay end,
      bool expectedResult,
    ) {
      test('TimeOfDay $time is between $start and $end', () {
        expect(time.isBetween(start, end), expectedResult);
      });
    }

    final testCases = [
      (
        time: TIME_10_30_AM,
        start: TIME_09_00_AM,
        end: TIME_11_00_AM,
        expectedResult: true
      ),
      (
        time: TIME_08_30_AM,
        start: TIME_09_00_AM,
        end: TIME_11_00_AM,
        expectedResult: false
      ),
      (
        time: TIME_10_30_AM,
        start: TIME_11_00_AM,
        end: TIME_09_00_AM,
        expectedResult: false
      ),
      (
        time: TIME_08_30_AM,
        start: TIME_10_00_PM,
        end: TIME_09_00_AM,
        expectedResult: true
      ),
      (
        time: TIME_12_00_PM,
        start: TIME_11_00_AM,
        end: TIME_09_00_AM,
        expectedResult: true
      ),
      (
        time: TIME_10_00_PM,
        start: TIME_11_00_AM,
        end: TIME_09_00_AM,
        expectedResult: true
      ),
      (
        time: TIME_09_00_AM,
        start: TIME_09_00_AM,
        end: TIME_09_00_AM,
        expectedResult: true
      ),
      (
        time: TIME_10_00_PM,
        start: TIME_09_00_AM,
        end: TIME_09_00_AM,
        expectedResult: false
      ),
    ];

    for (var testCase in testCases) {
      testIsBetween(
        testCase.time,
        testCase.start,
        testCase.end,
        testCase.expectedResult,
      );
    }
  });
}
