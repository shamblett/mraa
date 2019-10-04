/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';
import 'package:test/test.dart';

// Check for Travis
bool onTravis() {
  const bool isDeclared = String.fromEnvironment('PUB_ENVIRONMENT') != null;
  if (isDeclared) {
    const String env = String.fromEnvironment('PUB_ENVIRONMENT');
    if (env == 'travis') {
      print('Environment is Travis, using test mraa library');
      return true;
    }
  }
  print('Environment is not Travis, using system mraa library');
  return false;
}

int main() {
  // Setup
  const String libPath = 'testlib/libmraa.so.2.0.0';
  Mraa mraa;
  if (onTravis()) {
    mraa = Mraa.fromLib(libPath);
  } else {
    mraa = Mraa();
  }

  // Test groups
  group('Common', () {
    test('Version', () {
      final String mraaVersion = mraa.version();
      print('Version is : $mraaVersion');
      expect(mraaVersion.contains('v2.0.0'), isTrue);
    });
    test('Initialise', () {
      final MraaReturnCodes ret = mraa.initialise();
      print('Return code is : ${returnCodes.asString(ret)}');
    });
  });

  return 0;
}
