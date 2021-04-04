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
      final data = calloc.allocate<Uint8>(length);
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
      final data = calloc.allocate<Uint8>(length);
      final ret = mraa.i2c.readBytesData(context, 0, data, length);
      expect(ret, Mraa.generalError);
    });
    test('Write', () {
      final context = mraa.i2c.initialise(0);
      final values = Uint8List.fromList(<int>[1, 2, 3, 4, 5]);
      final data = calloc.allocate<Uint8>(values.length);
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

  return 0;
}
