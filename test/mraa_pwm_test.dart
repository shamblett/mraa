/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

@TestOn('vm && linux')
library;

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import 'support/mraa_platform_helper.dart';

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board, this means that some values used
// in the tests below are as supplied by the mock board implementation,
// some devices however, e.g. PWM are not supported by the mock board
// implementation and therefore cannot be tested. In all cases the API
// call itself is exercised for correctness.
int main() {
  // Setup
  final helper = MraaPlatformHelper();
  print(
    'PWM - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}',
  );
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups

  group('PWM', () {
    test('Initialise', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.pwm.initialiseRaw(0, 1);
      expect(context, isNotNull);
    });
    test('Write', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.write(context, 0.5);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.read(context);
      expect(ret, isPositive);
    });
    test('Period', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.period(context, 0.5);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Period milliseconds', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.periodMs(context, 500);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Period microseconds', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.periodUs(context, 50000);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Pulse width', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.pulseWidth(context, 0.5);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Pulse width milliseconds', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.pulseWidthMs(context, 500);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Pulse width microseconds', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.pulseWidthUs(context, 50000);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Enable', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.enable(context, 1);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Owner', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.owner(context, true);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Close', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.close(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Max period', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.maxPeriod(context);
      expect(ret, 5);
    });
    test('Min period', () {
      final context = mraa.pwm.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.pwm.minPeriod(context);
      expect(ret, 5);
    });
  });

  return 0;
}
