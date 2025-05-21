/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

@TestOn('vm && linux')
library;

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
    'UART Separate - OS is ${helper.osMap['NAME']}, lib path is ${helper.getTestLib()}',
  );
  final mraa = Mraa.fromLib(helper.getTestLib());
  mraa.initialise();

  // Test groups
  group('UART - Separate', () {
    test('Device path from index valid', () {
      final context = mraa.uart.initialise(0);
      expect(context, isNotNull);
      final ret = mraa.uart.devicePathFromIndex(0);
      expect(ret, isNotNull);
      expect(ret, 'dummy');
      print('Device path is $ret');
    });
  }, skip: helper.isUbuntu());

  return 0;
}
