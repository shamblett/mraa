/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'package:mraa/mraa.dart';
import 'package:test/test.dart';

// ignore_for_file: unused_local_variable

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  const String libPath = 'test/testlib/libmraa.so.2.0.0';
  final Mraa mraa = Mraa.fromLib(libPath);

  // Test groups
  group('Common', () {
    test('Version', () {
      final String mraaVersion = mraa.common.version();
      print('Version is : $mraaVersion');
      expect(mraaVersion.contains('v2.0.0'), isTrue);
    });
    test('Initialise', () {
      final MraaReturnCodes ret = mraa.common.initialise();
      expect(ret, MraaReturnCodes.mraaSuccess);
    });
    test('Log level', () {
      mraa.common.initialise();
      final MraaReturnCodes ret = mraa.common.setLogLevel(7);
      expect(ret, MraaReturnCodes.mraaSuccess);
    });
    test('Platform Name', () {
      mraa.common.initialise();
      final String platformName = mraa.common.platformName();
      print('The current platform name is : $platformName');
      expect(platformName, 'MRAA mock platform');
    });

    test('Platform Version', () {
      mraa.common.initialise();
      final String platformVersion = mraa.common.platformVersion(0);
      print('The current platform version is : $platformVersion');
    }, skip: true); //TODO causes crash

    test('Platform types', () {
      mraa.common.initialise();
      final MraaPlatformType ret = mraa.common.platformType();
      if (ret != null) {
        print('Platform type is : ${platformTypes.asString(ret)}');
      }
    });
    test('Initialise JSON platform', () {
      mraa.common.initialise();
      final MraaReturnCodes ret =
          mraa.common.initialiseJsonPlatform('test/test_board.json');
      expect(ret, MraaReturnCodes.mraaSuccess);
    });
    test('Pin mode test', () {
      mraa.common.initialise();
      final bool ret = mraa.common.pinmodeTest(2, MraaPinmodes.mraaPinAio);
      expect(ret, isFalse);
    });
    test('ADC raw bits', () {
      mraa.common.initialise();
      final int ret = mraa.common.adcRawBits();
      expect(ret, 12);
    });
    test('Platform ADC raw bits', () {
      mraa.common.initialise();
      final int ret = mraa.common.platformAdcRawBits(0);
      expect(ret, 12);
    });
    test('ADC supported bits', () {
      mraa.common.initialise();
      final int ret = mraa.common.adcSupportedBits();
      expect(ret, 10);
    });
    test('Platform ADC supported bits', () {
      mraa.common.initialise();
      final int ret = mraa.common.platformAdcSupportedBits(0);
      expect(ret, 10);
    });
    test('Set priority', () {
      mraa.common.initialise();
      final int ret = mraa.common.setPriority(50);
      expect(ret == Mraa.mraaGeneralError, isTrue);
    });
    test('Result print', () {
      mraa.common.initialise();
      mraa.common.resultPrint(returnCodes.asInt(MraaReturnCodes.mraaSuccess));
      mraa.common.resultPrint(
          returnCodes.asInt(MraaReturnCodes.mraaErrorInvalidHandle));
      mraa.common.resultPrint(100);
    });
  });

  group('GPIO', () {
    test('Initialise', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(0);
    });
  });

  group('AIO', () {
    test('Initialise', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
    });
    test('Close', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final MraaReturnCodes ret = mraa.aio.close(context);
      expect(ret, MraaReturnCodes.mraaSuccess);
    });
    test('Read', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final int val = mraa.aio.read(context);
      expect(val.isNegative, isFalse);
    });
    test('Read double', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final double val = mraa.aio.readDouble(context);
      // For the unsupported test board used this value will be nonsense
      expect(val < Mraa.mraaAioReadDoubleError, isFalse);
    });
    test('Set bit', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final MraaReturnCodes ret = mraa.aio.setBit(context, 10);
      expect(ret, MraaReturnCodes.mraaSuccess);
    });
    test('Get bit', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final int ret = mraa.aio.getBit(context);
      expect(ret, 10);
    });
  });

  return 0;
}
