/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';

int main() {
  group('Common', () {
    final Mraa mraa = Mraa();
    test('Version', () {
      final String mraaVersion = mraa.version();
      print('Version is : $mraaVersion');
      expect(mraaVersion, 'v2.0.0-37-g0a12c5a');
    });
    test('Initialise', () {
      final int ret = mraa.initialise();
      print('Return code is : $ret');
    });
  });

  return 0;
}
