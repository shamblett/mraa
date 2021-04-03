/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:typed_data';
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
    }, skip: helper.isUbuntu() || helper.isFedora());
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
    }, skip: helper.isUbuntu() || helper.isFedora());
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

  return 0;
}
