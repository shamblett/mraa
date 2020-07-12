/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import 'support/mraa_platform_helper.dart';

@TestOn('VM && Linux')

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  final helper = MraaPlatformHelper();
  final libPath = helper.getTestLib();
  final mraa = Mraa.fromLib(libPath);
  mraa.useGrovePi = true;
  mraa.initialise();
  // Separate tests for Grove Pi shield.
  group('AIO', () {
    test('Initialise', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      expect(context, isNotNull);
    });
    test('Close', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      final ret = mraa.aio.close(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Read', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      final val = mraa.aio.read(context);
      expect(val.isNegative, isTrue);
    });
    test('Read double', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      final val = mraa.aio.readDouble(context);
      // For the unsupported test board used this value will be nonsense
      expect(val < Mraa.aioReadDoubleError, isFalse);
    });
    test('Set bit', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      final ret = mraa.aio.setBit(context, 10);
      expect(ret, MraaReturnCode.success);
    });
    test('Get bit', () {
      mraa.common.initialise();
      final context = mraa.aio.initialise(0);
      final ret = mraa.aio.getBit(context);
      expect(ret, 10);
    });
  });

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
      final context = mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.gpio.initialiseRaw(4);
      expect(context, isNotNull);
    });
    test('Edge mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.edgeMode(context, MraaGpioEdge.falling);
      expect(ret, MraaReturnCode.errorInvalidResource);
    });
    test('Mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.mode(context, MraaGpioOutputMode.pullup);
      expect(ret, MraaReturnCode.errorFeatureNotImplemented);
    });
    test('Read direction', () {
      final context = mraa.gpio.initialise(1);
      final dir = MraaGpioDirectionRead();
      final ret = mraa.gpio.readDirection(context, dir);
      expect(ret, MraaReturnCode.errorInvalidResource);
      expect(dir.direction, isNull);
    });
    test('Close', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.close(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Read multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      expect(context, isNotNull);
      final values = MraaGpioMultiRead();
      final ret = mraa.gpio.readMulti(context, values);
      expect(ret, MraaReturnCode.errorUnspecified);
      expect(values.values, isNotNull);
      expect(values.length, 4);
    });
    test('Write', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.write(context, 1);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      final ret = mraa.gpio.writeMulti(context, <int>[7, 8, 9, 10]);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Owner', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.owner(context, true);
      expect(ret, MraaReturnCode.success);
    });
    test('Pin', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.pin(context);
      expect(ret, -1 * (Mraa.grovePiPinOffset + Mraa.generalError));
    });
    test('Pin raw', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.pinRaw(context);
      expect(ret, -1 * (Mraa.grovePiPinOffset + Mraa.generalError));
    });
    test('Input mode', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.inputMode(context, MraaGpioInputMode.activeHigh);
      expect(ret, MraaReturnCode.errorInvalidResource);
    });
  });

  return 0;
}
