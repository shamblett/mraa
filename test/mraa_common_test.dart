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
  print('Common - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}');
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups
  group('Common', () {
    test('Initialise', () {
      final ret = mraa.common.initialise();
      expect(ret, MraaReturnCode.success);
    });
    test('Version', () {
      mraa.common.initialise();
      final mraaVersion = mraa.common.version();
      print('MRAA Version is : $mraaVersion');
      if (helper.isFedora()) {
        expect(mraaVersion.contains('2.2'), isTrue);
      } else {
        expect(mraaVersion.contains('2.0'), isTrue);
      }
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
    });

    test('Platform types', () {
      mraa.common.initialise();
      final ret = mraa.common.platformType();
      print('Platform type is : $ret');
      expect(ret, MraaPlatformType.mockPlatform);
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
      mraa.common.resultPrint(MraaReturnCode.success.code);
      mraa.common.resultPrint(MraaReturnCode.errorInvalidHandle.code);
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

  return 0;
}
