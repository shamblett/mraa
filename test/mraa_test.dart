/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import 'support/mraa_platform_helper.dart';

// ignore_for_file: unused_local_variable
@TestOn('VM && Linux')

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  final MraaPlatformHelper helper = MraaPlatformHelper();
  print(
      'Platform is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}');
  final Mraa mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups
  group('Common', () {
    test('Not initialised', () {
      final Mraa mraa = Mraa();
      expect(() => mraa.common.version(), throwsNoSuchMethodError);
    });
    test('Version', () {
      final String mraaVersion = mraa.common.version();
      print('MRAA Version is : $mraaVersion');
      expect(mraaVersion.contains('v2.0.0'), isTrue);
    });
    test('Initialise', () {
      final MraaReturnCode ret = mraa.common.initialise();
      expect(ret, MraaReturnCode.success);
    });
    test('Log level', () {
      mraa.common.initialise();
      final MraaReturnCode ret = mraa.common.setLogLevel(7);
      expect(ret, MraaReturnCode.success);
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
    test('Pin mode test', () {
      mraa.common.initialise();
      final bool ret = mraa.common.pinmodeTest(2, MraaPinmode.aio);
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
      mraa.common.resultPrint(returnCode.asInt(MraaReturnCode.success));
      mraa.common
          .resultPrint(returnCode.asInt(MraaReturnCode.errorInvalidHandle));
      mraa.common.resultPrint(100);
    });
    test('Platform combined type', () {
      mraa.common.initialise();
      final int ret = mraa.common.platformCombinedType();
      final MraaCombinedTypeDecode decoded = decodeCombinedType(ret);
      expect(decoded.mainPlatform, MraaPlatformType.mockPlatform);
      expect(decoded.subPlatform, MraaPlatformType.intelGalileoGen1);
    });
    test('Pin count', () {
      mraa.common.initialise();
      final int ret = mraa.common.pinCount();
      expect(ret, 10);
    });
    test('Uart count', () {
      mraa.common.initialise();
      final int ret = mraa.common.uartCount();
      expect(ret, 1);
    });
    test('Spi Bus count', () {
      mraa.common.initialise();
      final int ret = mraa.common.spiBusCount();
      expect(ret, 1);
    });
    test('PWM count', () {
      mraa.common.initialise();
      final int ret = mraa.common.pwmCount();
      expect(ret, 0);
    });
    test('GPIO count', () {
      mraa.common.initialise();
      final int ret = mraa.common.gpioCount();
      expect(ret, 1);
    });
    test('AIO count', () {
      mraa.common.initialise();
      final int ret = mraa.common.aioCount();
      expect(ret, 1);
    });
    test('I2c Bus count', () {
      mraa.common.initialise();
      final int ret = mraa.common.i2cBusCount();
      expect(ret, 1);
    });
    test('I2c Bus id', () {
      mraa.common.initialise();
      final int ret = mraa.common.i2cBusId(0);
      expect(ret, 0);
    });
    test('Platform pin count', () {
      mraa.common.initialise();
      final int ret = mraa.common.platformPinCount(0);
      expect(ret, 10);
    });
    test('Pin Name', () {
      mraa.common.initialise();
      String ret = mraa.common.pinName(1);
      expect(ret, 'ADC0');
      ret = mraa.common.pinName(2);
      expect(ret, 'I2C0SDA');
    });
    test('GPIO lookup', () {
      mraa.common.initialise();
      int ret = mraa.common.gpioLookup('ADC0');
      expect(ret, Mraa.mraaGeneralError);
      ret = mraa.common.gpioLookup('I2C0SDA');
      expect(ret, Mraa.mraaGeneralError);
    });
    test('I2C lookup', () {
      mraa.common.initialise();
      final int ret = mraa.common.i2cLookup('I2C6');
      expect(ret, Mraa.mraaGeneralError);
    });
    test('SPI lookup', () {
      mraa.common.initialise();
      final int ret = mraa.common.spiLookup('SPI2');
      expect(ret, Mraa.mraaGeneralError);
    });
    test('PWM lookup', () {
      mraa.common.initialise();
      final int ret = mraa.common.pwmLookup('PWM0');
      expect(ret, Mraa.mraaGeneralError);
    });
    test('UART lookup', () {
      mraa.common.initialise();
      final int ret = mraa.common.uartLookup('UART1');
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Default I2C bus', () {
      mraa.common.initialise();
      final int ret = mraa.common.defaultI2cBus(0);
      expect(ret, 0);
    });
    test('Has sub platform', () {
      mraa.common.initialise();
      final bool ret = mraa.common.hasSubPlatform();
      expect(ret, isFalse);
    });
    test('Is sub platform id', () {
      mraa.common.initialise();
      final bool ret = mraa.common.isSubPlatformId(1);
      expect(ret, isFalse);
    });
    test('Sub platform id', () {
      mraa.common.initialise();
      final int ret = mraa.common.subPlatformId(1);
      expect(ret, 513);
    });
    test('Sub platform index', () {
      mraa.common.initialise();
      final int ret = mraa.common.subPlatformIndex(513);
      expect(ret, 1);
    });
    test('Add subplatform', () {
      mraa.common.initialise();
      final MraaReturnCode ret =
          mraa.common.addSubplatform(MraaPlatformType.a96boards, '"I2C');
      expect(ret != MraaReturnCode.success, isTrue);
    });
    test('Remove subplatform', () {
      mraa.common.initialise();
      final MraaReturnCode ret =
          mraa.common.removeSubplatform(MraaPlatformType.a96boards);
      expect(ret != MraaReturnCode.success, isTrue);
    });
  });

  group('GPIO', () {
    test('Initialise', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(0);
      expect(context, isNotNull);
    });
    test('Direction', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(71);
      final MraaReturnCode ret =
          mraa.gpio.direction(context, MraaGpioDirection.inn);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(71);
      final int ret = mraa.gpio.read(context);
      expect(ret == Mraa.mraaGeneralError, isTrue);
    });
    test('Initialise multi', () {
      final ffi.Pointer<MraaGpioContext> context =
          mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialiseRaw(4);
      expect(context, isNotNull);
    });
    test('Edge mode', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(1);
      final MraaReturnCode ret =
          mraa.gpio.edgeMode(context, MraaGpioEdge.falling);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Events', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(1);
      final List<MraaGpioEvent> events = mraa.gpio.events(context);
      expect(events, isEmpty);
    });
    test('Mode', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(1);
      final MraaReturnCode ret =
          mraa.gpio.mode(context, MraaGpioOutputMode.pullup);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read direction', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(1);
      final MraaGpioDirectionRead dir = MraaGpioDirectionRead();
      final MraaReturnCode ret = mraa.gpio.readDirection(context, dir);
      expect(ret, MraaReturnCode.errorInvalidHandle);
      expect(dir.direction, isNull);
    });
    test('Close', () {
      final ffi.Pointer<MraaGpioContext> context = mraa.gpio.initialise(1);
      final MraaReturnCode ret = mraa.gpio.close(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Read multi', () {
      final ffi.Pointer<MraaGpioContext> context =
          mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      expect(context, isNotNull);
      final MraaGpioMultiRead values = MraaGpioMultiRead();
      final MraaReturnCode ret = mraa.gpio.readMulti(context, values);
      expect(ret, MraaReturnCode.errorUnspecified);
      expect(values.values, isNotNull);
      expect(values.length, 4);
    });
  });

  group('AIO', () {
    test('Initialise', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      expect(context, isNotNull);
    });
    test('Close', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final MraaReturnCode ret = mraa.aio.close(context);
      expect(ret, MraaReturnCode.success);
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
      final MraaReturnCode ret = mraa.aio.setBit(context, 10);
      expect(ret, MraaReturnCode.success);
    });
    test('Get bit', () {
      mraa.common.initialise();
      final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(0);
      final int ret = mraa.aio.getBit(context);
      expect(ret, 10);
    });
  });

  group('I2C', () {
    test('Initialise', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialiseRaw(0);
      expect(context, isNotNull);
    });
    test('Frequency', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.frequency(context, MraaI2cMode.high);
      expect(ret, MraaReturnCode.errorInvalidParameter);
    });
    test('Read', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      const int length = 10;
      final ffi.Pointer<ffi.Uint8> data =
          ffi.Pointer<ffi.Uint8>.allocate(count: length);
      final int ret = mraa.i2c.read(context, data, length);
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Read byte', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final int ret = mraa.i2c.readByte(context);
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Read byte data', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final int ret = mraa.i2c.readByteData(context, 0);
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Read word data', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final int ret = mraa.i2c.readWordData(context, 0);
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Read bytes data', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      const int length = 10;
      final ffi.Pointer<ffi.Uint8> data =
          ffi.Pointer<ffi.Uint8>.allocate(count: length);
      final int ret = mraa.i2c.readBytesData(context, 0, data, length);
      expect(ret, Mraa.mraaGeneralError);
    });
    test('Write', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final Uint8List values = Uint8List.fromList(<int>[1, 2, 3, 4, 5]);
      final ffi.Pointer<ffi.Uint8> data =
          ffi.Pointer<ffi.Uint8>.allocate(count: values.length);
      final Uint8List dataItems =
          data.asExternalTypedData(count: values.length);
      final int length = values.length;
      for (int i = 0; i < length; i++) {
        dataItems[i] = values[i];
      }
      final MraaReturnCode ret = mraa.i2c.write(context, data, length);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write byte', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.writeByte(context, 8);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write byte data', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.writeByteData(context, 8, 0);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write word data', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.writeWordData(context, 8, 0);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Address', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.address(context, 8);
      expect(ret, MraaReturnCode.success);
    });
    test('Stop', () {
      final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(0);
      final MraaReturnCode ret = mraa.i2c.stop(context);
      expect(ret, MraaReturnCode.success);
    });
  });

  return 0;
}
