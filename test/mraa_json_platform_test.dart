/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import 'support/mraa_platform_helper.dart';

@TestOn('VM && Linux')

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  final MraaPlatformHelper helper = MraaPlatformHelper();
  final String libPath = helper.getTestLib();
  final Mraa mraa = Mraa.fromLib(libPath);

  // Separate tests for load JSON platform as this upsets Mock board settings
  test('Initialise JSON platform', () {
    mraa.initialise();
    mraa.common.initialise();
    final MraaReturnCodes ret =
        mraa.common.initialiseJsonPlatform('test/test_board.json');
    expect(ret, MraaReturnCodes.mraaSuccess);
  });
  test('No JSON loading', () {
    mraa.noJsonLoading = true;
    mraa.initialise();
    mraa.common.initialise();
    final MraaReturnCodes ret =
        mraa.common.initialiseJsonPlatform('test/test_board.json');
    expect(ret, MraaReturnCodes.mraaErrorFeatureNotSupported);
  });
  return 0;
}
