/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:test/test.dart';
import 'mraa_platform_helper.dart';

@TestOn('VM && Linux')
int main() {
  test('Initialise', () {
    final helper = MraaPlatformHelper();
    print(helper);
  });
  test('Distro check', () {
    final helper = MraaPlatformHelper();
    if (helper.isCentos()) {
      expect(helper.getTestLib(), 'test/testlib/centos7/libmraa.so.2.0.0');
    }
    if (helper.isFedora()) {
      expect(helper.getTestLib(), 'test/testlib/fedora/libmraa.so.2.0.0');
    }
    if (helper.isUbuntu()) {
      expect(helper.getTestLib(), 'test/testlib/ubuntu/libmraa.so.2.0.0');
    }
  });
  return 0;
}
