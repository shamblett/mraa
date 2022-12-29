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
  print(
      'GPIO - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}');
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups
  group('GPIO', () {
    test('Initialise', () {
      final context = mraa.gpio.initialise(0);
      expect(context, isNotNull);
    });
    test('Direction', () {
      final context = mraa.gpio.initialise(71);
      final ret = mraa.gpio.direction(context, MraaGpioDirection.inn);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read', () {
      final context = mraa.gpio.initialise(71);
      final ret = mraa.gpio.read(context);
      expect(ret == Mraa.generalError, isTrue);
    });
    test('Initialise multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1], 1);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.gpio.initialiseRaw(4);
      expect(context, isNotNull);
    });
    test('Edge mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.edgeMode(context, MraaGpioEdge.falling);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Events', () {
      final context = mraa.gpio.initialise(1);
      final events = mraa.gpio.events(context);
      expect(events, isEmpty);
    });
    test('Mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.mode(context, MraaGpioOutputMode.pullup);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read direction', () {
      final context = mraa.gpio.initialise(1);
      final dir = MraaGpioDirectionRead();
      final ret = mraa.gpio.readDirection(context, dir);
      expect(ret, MraaReturnCode.errorInvalidHandle);
      expect(dir.direction, MraaGpioDirection.out);
    });
    test('Close', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.close(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1], 1);
      expect(context, isNotNull);
      final values = MraaGpioMultiRead();
      final ret = mraa.gpio.readMulti(context, values);
      expect(ret, MraaReturnCode.errorUnspecified);
      expect(values.values, isNotNull);
      expect(values.length, 1);
    });
    test('Write', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.write(context, 1);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Write multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1], 1);
      final ret = mraa.gpio.writeMulti(context, <int>[10]);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Owner', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.owner(context, true);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Pin', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.pin(context);
      expect(ret, Mraa.generalError);
    });
    test('Pin raw', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.pinRaw(context);
      expect(ret, Mraa.generalError);
    });
    test('Input mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.inputMode(context, MraaGpioInputMode.activeHigh);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Output driver mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio
          .outputDriverMode(context, MraaGpioOutputDriverMode.pushPull);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
  });

  return 0;
}
