/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

@TestOn('VM && Linux')
import 'package:mraa/mraa.dart';
import 'package:test/test.dart';
import '../support/mraa_platform_helper.dart';

// We always use our package supplied library in test as it is an Mraa
// library compiled to use a mock board
int main() {
  // Setup
  final helper = MraaPlatformHelper();
  final libPath = helper.getTestLib();
  final mraa = Mraa.fromLib(libPath);

  // Separate tests for load JSON platform as this upsets Mock board settings
  test('Initialise JSON platform', () {
    mraa.initialise();
    mraa.common.initialise();
    final ret = mraa.common.initialiseJsonPlatform('test/test_board.json');
    expect(ret, MraaReturnCode.success);
  });
  test('No JSON loading', () {
    mraa.noJsonLoading = true;
    mraa.initialise();
    mraa.common.initialise();
    final ret = mraa.common.initialiseJsonPlatform('test/test_board.json');
    expect(ret, MraaReturnCode.errorFeatureNotSupported);
  });
  return 0;
}
