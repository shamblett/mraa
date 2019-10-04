/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';

int main() {
  const String libPath = 'testlib/libmraa.so.2.0.0';
  group('Common', () {
    final Mraa mraa = Mraa.fromLib(libPath);
    test('Version', () {
      final String mraaVersion = mraa.version();
      print('Version is : $mraaVersion');
      expect(mraaVersion, 'v2.0.0-37-g0a12c5a');
    });
    test('Initialise', () {
      final MraaReturnCodes ret = mraa.initialise();
      print('Return code is : ${MraaReturnCode.asString(ret)}');
    });
  });

  return 0;
}
