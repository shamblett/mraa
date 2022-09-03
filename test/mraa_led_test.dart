/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

@TestOn('vm && linux')

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
  print('OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}');
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups

  group('LED', () {
    test('Initialise', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.led.initialiseRaw('user4');
      expect(context, isNotNull);
    });
    test('Set brightness', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.setBrightness(context, 10);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read brightness', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.readBrightness(context);
      expect(ret, 5);
    });
    test('Read maximum brightness', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.readMaxBrightness(context);
      expect(ret, 5);
    });
    test('Set trigger', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.setTrigger(context, 'heartbeat');
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Clear trigger', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.clearTrigger(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Close', () {
      final context = mraa.led.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.led.close(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
  });

  return 0;
}
