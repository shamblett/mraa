/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:io';

/// Platform support helper class for testing
class MraaPlatformHelper {
  /// Construction
  MraaPlatformHelper() {
    _loadOsDetails();
  }

  final Map<String, String> _osMap = <String, String>{};
  Map<String, String> get osMap => _osMap;

  String _distName = 'None';

  /// Is this a Centos distro
  bool isCentos() => _distName.toLowerCase().contains('centos');

  /// Is this a Fedora distro
  bool isFedora() => _distName.toLowerCase().contains('fedora');

  /// Is this an Ubuntu  distro
  bool isUbuntu() => _distName.toLowerCase().contains('ubuntu');

  /// Get the correct test library
  String getTestLib() {
    if (isCentos()) {
      return 'test/testlib/centos7/libmraa.so.2.0.0';
    }
    if (isFedora()) {
      return 'test/testlib/fedora/libmraa.so.2.2.0';
    }
    // Default to Ubuntu for Travis
    return 'test/testlib/ubuntu/libmraa.so.2.0.0';
  }

  void _loadOsDetails() {
    const osFilePath = '/etc/os-release';
    final osFile = File(osFilePath);
    final lines = osFile.readAsLinesSync();
    for (final line in lines) {
      if (line.isEmpty) {
        continue;
      }
      final vals = line.split('=');
      vals[1] = vals[1].replaceAll('"', '');
      _osMap[vals[0]] = vals[1];
    }
    // Set the dist name
    _distName = _osMap['NAME']!;
  }

  @override
  String toString() => _osMap.toString();
}
