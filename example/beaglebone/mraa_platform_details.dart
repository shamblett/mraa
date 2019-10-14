/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

/// Get some platform details for the Beaglebone Green
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  print('Initialising MRAA');
  final MraaReturnCode ret = mraa.common.initialise();
  if (ret != MraaReturnCode.mraaSuccess) {
    print(
        'Beaglebone green - failed to initialise MRAA, return code is ${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  print('Getting platform type');
  final MraaPlatformType retType = mraa.common.platformType();
  if (ret != null) {
    print('Platform type is : ${platformTypes.asString(retType)}');
  } else {
    print('Platform type has returned null');
  }

  return 0;
}
