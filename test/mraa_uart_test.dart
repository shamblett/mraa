/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

@TestOn('vm && linux')
library;

import 'dart:typed_data';
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
    'UART - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}',
  );
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups

  group('UART', () {
    test('Initialise', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
    }, skip: helper.isUbuntu());
    test('Mode', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.mode(context, 8, MraaUartParity.even, 1);
      expect(ret, MraaReturnCode.success);
    }, skip: helper.isUbuntu());
    test('Flush', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.flush(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Send break', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.sendBreak(context, 0);
      expect(ret, MraaReturnCode.success);
    });
    test('Baud rate', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.baudRate(context, 9600);
      expect(ret, MraaReturnCode.success);
    });
    test('Flow control', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.flowControl(context, true, false);
      expect(ret, MraaReturnCode.success);
    });
    test('Timeout', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.timeout(context, 10, 10, 5);
      expect(ret, MraaReturnCode.success);
    });
    test('Non blocking', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.nonBlocking(context, false);
      expect(ret, MraaReturnCode.success);
    });
    test('Device path from index valid', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.devicePathFromIndex(0);
      expect(ret, isNotNull);
      expect(ret, 'dummy');
    });
    test('Device path initialise raw', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final ret = mraa.uart.devicePath(context);
      expect(ret, isNotNull);
      expect(ret, 'dev/ttyS0');
    });
    test('Settings - invalid parameters', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final settings = MraaUartSettings();
      final ret = mraa.uart.settings(-1, settings);
      expect(ret, MraaReturnCode.errorInvalidResource);
    }, skip: helper.isUbuntu());
    test('Settings - index', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final settings = MraaUartSettings();
      final ret = mraa.uart.settings(1, settings);
      expect(ret, MraaReturnCode.errorInvalidResource);
    }, skip: helper.isUbuntu());
    test('Settings - device path', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final settings = MraaUartSettings();
      settings.devicePath = 'dev/ttyS0';
      final ret = mraa.uart.settings(-1, settings);
      expect(ret, MraaReturnCode.errorInvalidParameter);
    }, skip: helper.isUbuntu());
    test('Stop', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final ret = mraa.uart.stop(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Write Bytes', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      mraa.uart.flush(context);
      final buffer = MraaUartBuffer();
      buffer.byteData = Uint8List.fromList([0xDE, 0xAD, 0xBE, 0xEF]);
      final ret = mraa.uart.writeBytes(context, buffer, buffer.byteLength);
      expect(ret, buffer.byteLength);
    });
    test('Read Bytes', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      mraa.uart.flush(context);
      final buffer = MraaUartBuffer();
      buffer.byteData = Uint8List(10);
      final ret = mraa.uart.readBytes(context, buffer, buffer.byteLength);
      if (ret != Mraa.generalError) {
        expect(ret, 10);
        expect(buffer.byteLength, 10);
      } else {
        expect(ret, Mraa.generalError);
      }
    });
    test('Data Available', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      var ret = mraa.uart.dataAvailable(context, 1);
      expect(ret, isNotNull);
    });
  }, skip: helper.isUbuntu());

  return 0;
}
