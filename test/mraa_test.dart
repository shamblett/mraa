/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import 'support/mraa_platform_helper.dart';

@TestOn('VM && Linux')

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
  group('Common', () {
    test('Version', () {
      final mraaVersion = mraa.common.version();
      print('MRAA Version is : $mraaVersion');
      expect(mraaVersion.contains('v2.0.0'), isTrue);
    });
    test('Initialise', () {
      final ret = mraa.common.initialise();
      expect(ret, MraaReturnCode.success);
    });
    test('Log level', () {
      mraa.common.initialise();
      final ret = mraa.common.setLogLevel(7);
      expect(ret, MraaReturnCode.success);
    });
    test('Platform Name', () {
      mraa.common.initialise();
      final platformName = mraa.common.platformName();
      print('The current platform name is : $platformName');
      expect(platformName, 'MRAA mock platform');
    });

    test('Platform Version', () {
      mraa.common.initialise();
      final platformVersion = mraa.common.platformVersion(0);
      print('The current platform version is : $platformVersion');
      expect(platformVersion.contains('mock'), isTrue);
    });

    test('Platform types', () {
      mraa.common.initialise();
      final ret = mraa.common.platformType();
      if (ret != null) {
        print('Platform type is : ${platformTypes.asString(ret)}');
        expect(ret, MraaPlatformType.mockPlatform);
      }
    });
    test('Pin mode test', () {
      final ok = mraa.common.initialise();
      expect(ok, MraaReturnCode.success);
      var ret = mraa.common.pinmodeTest(2, MraaPinmode.aio);
      expect(ret, isFalse);
      ret = mraa.common.pinmodeTest(0, MraaPinmode.valid);
      expect(ret, isTrue);
      ret = mraa.common.pinmodeTest(0, MraaPinmode.gpio);
      expect(ret, isTrue);
    });
    test('ADC raw bits', () {
      mraa.common.initialise();
      final ret = mraa.common.adcRawBits();
      expect(ret, 12);
    });
    test('Platform ADC raw bits', () {
      mraa.common.initialise();
      final ret = mraa.common.platformAdcRawBits(0);
      expect(ret, 12);
    });
    test('ADC supported bits', () {
      mraa.common.initialise();
      final ret = mraa.common.adcSupportedBits();
      expect(ret, 10);
    });
    test('Platform ADC supported bits', () {
      mraa.common.initialise();
      final ret = mraa.common.platformAdcSupportedBits(0);
      expect(ret, 10);
    });
    test('Set priority', () {
      mraa.common.initialise();
      final ret = mraa.common.setPriority(50);
      expect(ret == Mraa.generalError, isTrue);
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
      final ret = mraa.common.platformCombinedType();
      final decoded = decodeCombinedType(ret);
      expect(decoded.mainPlatform, MraaPlatformType.mockPlatform);
      expect(decoded.subPlatform, MraaPlatformType.intelGalileoGen1);
    });
    test('Pin count', () {
      mraa.common.initialise();
      final ret = mraa.common.pinCount();
      expect(ret, 10);
    });
    test('Uart count', () {
      mraa.common.initialise();
      final ret = mraa.common.uartCount();
      expect(ret, 1);
    });
    test('Spi Bus count', () {
      mraa.common.initialise();
      final ret = mraa.common.spiBusCount();
      expect(ret, 1);
    });
    test('PWM count', () {
      mraa.common.initialise();
      final ret = mraa.common.pwmCount();
      expect(ret, 0);
    });
    test('GPIO count', () {
      mraa.common.initialise();
      final ret = mraa.common.gpioCount();
      expect(ret, 1);
    });
    test('AIO count', () {
      mraa.common.initialise();
      final ret = mraa.common.aioCount();
      expect(ret, 1);
    });
    test('I2c Bus count', () {
      mraa.common.initialise();
      final ret = mraa.common.i2cBusCount();
      expect(ret, 1);
    });
    test('I2c Bus id', () {
      mraa.common.initialise();
      final ret = mraa.common.i2cBusId(0);
      expect(ret, 0);
    });
    test('Platform pin count', () {
      mraa.common.initialise();
      final ret = mraa.common.platformPinCount(0);
      expect(ret, 10);
    });
    test('Pin Name', () {
      mraa.common.initialise();
      var ret = mraa.common.pinName(1);
      expect(ret, 'ADC0');
      ret = mraa.common.pinName(2);
      expect(ret, 'I2C0SDA');
      ret = mraa.common.pinName(0);
      expect(ret, 'GPIO0');
    });
    test('GPIO lookup', () {
      mraa.common.initialise();
      var ret = mraa.common.gpioLookup('ADC0');
      expect(ret, Mraa.generalError);
      ret = mraa.common.gpioLookup('I2C0SDA');
      expect(ret, Mraa.generalError);
      ret = mraa.common.gpioLookup('GPIO0');
      expect(ret, 0);
    });
    test('I2C lookup', () {
      mraa.common.initialise();
      final ret = mraa.common.i2cLookup('I2C6');
      expect(ret, Mraa.generalError);
    });
    test('SPI lookup', () {
      mraa.common.initialise();
      final ret = mraa.common.spiLookup('SPI2');
      expect(ret, Mraa.generalError);
    });
    test('PWM lookup', () {
      mraa.common.initialise();
      final ret = mraa.common.pwmLookup('PWM0');
      expect(ret, Mraa.generalError);
    });
    test('UART lookup', () {
      mraa.common.initialise();
      final ret = mraa.common.uartLookup('UART1');
      expect(ret, Mraa.generalError);
    });
    test('Default I2C bus', () {
      mraa.common.initialise();
      final ret = mraa.common.defaultI2cBus(0);
      expect(ret, 0);
    });
    test('Has sub platform', () {
      mraa.common.initialise();
      final ret = mraa.common.hasSubPlatform();
      expect(ret, isFalse);
    });
    test('Is sub platform id', () {
      mraa.common.initialise();
      final ret = mraa.common.isSubPlatformId(1);
      expect(ret, isFalse);
    });
    test('Sub platform id', () {
      mraa.common.initialise();
      final ret = mraa.common.subPlatformId(1);
      expect(ret, 513);
    });
    test('Sub platform index', () {
      mraa.common.initialise();
      final ret = mraa.common.subPlatformIndex(513);
      expect(ret, 1);
    });
    test('Add subplatform', () {
      mraa.common.initialise();
      final ret =
          mraa.common.addSubplatform(MraaPlatformType.a96boards, '"I2C');
      expect(ret != MraaReturnCode.success, isTrue);
    });
    test('Remove subplatform', () {
      mraa.common.initialise();
      final ret = mraa.common.removeSubplatform(MraaPlatformType.a96boards);
      expect(ret != MraaReturnCode.success, isTrue);
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
      expect(dir.direction, isNull);
    });
    test('Close', () {
      final context = mraa.gpio.initialise(1);
      final ret = mraa.gpio.close(context);
      expect(ret, MraaReturnCode.errorInvalidHandle);
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
      expect(ret, MraaReturnCode.errorInvalidHandle);
    });
    test('Write multi', () {
      final context = mraa.gpio.initialiseMulti(<int>[1, 2, 3, 4], 4);
      final ret = mraa.gpio.writeMulti(context, <int>[7, 8, 9, 10]);
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
      expect(val.isNegative, isFalse);
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

  group('I2C', () {
    test('Initialise', () {
      final context = mraa.i2c.initialise(0);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.i2c.initialiseRaw(0);
      expect(context, isNotNull);
    });
    test('Frequency', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.frequency(context, MraaI2cMode.high);
      expect(ret, MraaReturnCode.success);
    });
    test('Read', () {
      final context = mraa.i2c.initialise(0);
      const length = 10;
      final data = allocate<Uint8>(count: length);
      final ret = mraa.i2c.read(context, data, length);
      expect(ret, Mraa.generalError);
    });
    test('Read byte', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.readByte(context);
      expect(ret, Mraa.generalError);
    });
    test('Read byte data', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.readByteData(context, 0);
      expect(ret, Mraa.generalError);
    });
    test('Read word data', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.readWordData(context, 0);
      expect(ret, Mraa.generalError);
    });
    test('Read bytes data', () {
      final context = mraa.i2c.initialise(0);
      const length = 10;
      final data = allocate<Uint8>(count: length);
      final ret = mraa.i2c.readBytesData(context, 0, data, length);
      expect(ret, Mraa.generalError);
    });
    test('Write', () {
      final context = mraa.i2c.initialise(0);
      final values = Uint8List.fromList(<int>[1, 2, 3, 4, 5]);
      final data = allocate<Uint8>(count: values.length);
      final dataItems = data.asTypedList(values.length);
      dataItems.setAll(0, values);
      final ret = mraa.i2c.write(context, data, values.length);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write byte', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.writeByte(context, 8);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write byte data', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.writeByteData(context, 8, 0);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Write word data', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.writeWordData(context, 8, 0);
      expect(ret, MraaReturnCode.errorUnspecified);
    });
    test('Address', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.address(context, 8);
      expect(ret, MraaReturnCode.success);
    });
    test('Stop', () {
      final context = mraa.i2c.initialise(0);
      final ret = mraa.i2c.stop(context);
      expect(ret, MraaReturnCode.success);
    });
  });

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

  group('SPI', () {
    test('Initialise', () {
      final context = mraa.spi.initialise(1);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.spi.initialiseRaw(1, 1);
      expect(context, isNotNull);
    });
    test('Mode', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.mode(context, MraaSpiMode.mode0);
      expect(ret, MraaReturnCode.success);
    });
    test('Frequency', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.frequency(context, 115000);
      expect(ret, MraaReturnCode.success);
    });
    test('Write', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.write(context, 127);
      expect(ret == Mraa.generalError, isFalse);
    });
    test('Write word', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.writeWord(context, 45000);
      expect(ret, 1138);
    });
    test('Write buffer', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final values = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
      final data = Uint8List(values.length);
      data.setAll(0, values);
      final ret = mraa.spi.writeBuffer(context, data, data.length);
      expect(ret, isNotNull);
      expect(ret.length, data.length);
    });
    test('Write buffer word', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final values = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
      final data = Uint16List(values.length);
      data.setAll(0, values);
      final ret = mraa.spi.writeBufferWord(context, data, data.length);
      expect(ret, isNotNull);
      expect(ret.length, data.length);
    });
    test('Transfer buffer', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final values = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
      final data = Uint8List(values.length);
      data.setAll(0, values);
      final buffer = MraaSpiTransferBuffer<Uint8List>();
      buffer.dataSent = data;
      final ret = mraa.spi.transferBuffer(context, buffer, data.length);
      expect(ret, MraaReturnCode.success);
      expect(buffer.dataReceived.length, data.length);
    });
    test('Transfer buffer word', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final values = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];
      final data = Uint16List(values.length);
      data.setAll(0, values);
      final buffer = MraaSpiTransferBuffer<Uint16List>();
      buffer.dataSent = data;
      final ret = mraa.spi.transferBufferWord(context, buffer, data.length);
      expect(ret, MraaReturnCode.success);
      expect(buffer.dataReceived.length, data.length);
    });
    test('Lsb mode', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.lsbMode(context, true);
      expect(ret, MraaReturnCode.success);
    });
    test('Bits per word', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.bitsPerWord(context, 8);
      expect(ret, MraaReturnCode.success);
    });
    test('Stop', () {
      final context = mraa.spi.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.spi.stop(context);
      expect(ret, MraaReturnCode.success);
    });
  });

  group('UART', () {
    test('Initialise', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
    });
    test('Initialise raw', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
    });
    test('Flush', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.flush(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Send break', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.sendBreak(context, 0);
      expect(ret, MraaReturnCode.success);
    });
    test('Baud rate', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.baudRate(context, 9600);
      expect(ret, MraaReturnCode.success);
    });
    test('Mode', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.mode(context, 8, MraaUartParity.even, 1);
      expect(ret, MraaReturnCode.success);
    });
    test('Flow control', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.flowControl(context, true, false);
      expect(ret, MraaReturnCode.success);
    });
    test('Timeout', () {
      final context = mraa.uart.initialise(1);
      expect(context, isNotNull);
      final ret = mraa.uart.timeout(context, 10, 10, 5);
      expect(ret, MraaReturnCode.success);
    });
    test('Non blocking', () {
      final context = mraa.uart.initialise(1);
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
    test('Device path initialise by index', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.devicePath(context);
      expect(ret, isNotNull);
      expect(ret, 'dummy');
    }, skip: true);
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
      expect(ret, MraaReturnCode.errorInvalidParameter);
    });
    test('Settings - index', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final settings = MraaUartSettings();
      final ret = mraa.uart.settings(1, settings);
      expect(ret, MraaReturnCode.errorInvalidResource);
    });
    test('Settings - device path', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final settings = MraaUartSettings();
      settings.devicePath = 'dev/ttyS0';
      final ret = mraa.uart.settings(-1, settings);
      expect(ret, MraaReturnCode.errorInvalidResource);
    });
    test('Stop', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      final ret = mraa.uart.stop(context);
      expect(ret, MraaReturnCode.success);
    });
    test('Write', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      mraa.uart.flush(context);
      final buffer = MraaUartBuffer();
      buffer.data = 'Hello UART';
      final ret = mraa.uart.write(context, buffer, buffer.length);
      expect(ret, buffer.length);
    });
    test('Read', () {
      final context = mraa.uart.initialiseRaw('dev/ttyS0');
      expect(context, isNotNull);
      mraa.uart.flush(context);
      final buffer = MraaUartBuffer();
      buffer.data = '';
      final ret = mraa.uart.read(context, buffer, buffer.length);
      if (ret != Mraa.generalError) {
        expect(ret, 10);
        expect(buffer.length, 10);
      } else {
        expect(ret, Mraa.generalError);
      }
    });
  });

  return 0;
}
