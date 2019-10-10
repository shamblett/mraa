/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';

@TestOn('VM && Linux')

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  const String libPath = 'test/testlib/centos7/libmraa.so.2.0.0';
  final Mraa mraa = Mraa.fromLib(libPath);

  // Single test for load JSON platform as this upsets Mock board settings
  test('Initialise JSON platform', () {
    mraa.common.initialise();
    final MraaReturnCodes ret =
        mraa.common.initialiseJsonPlatform('test/test_board.json');
    expect(ret, MraaReturnCodes.mraaSuccess);
  });
  return 0;
}
