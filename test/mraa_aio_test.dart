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
    'AIO - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}',
  );
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups

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

  return 0;
}
