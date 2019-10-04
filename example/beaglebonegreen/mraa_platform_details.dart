/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

/// Get some platform details for the Beagleboone Green
int main() {
  final Mraa mraa = Mraa();
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising');
  MraaReturnCodes ret = mraa.common.initialise();
  if (ret != MraaReturnCodes.mraaSuccess) {
    print(
        'Beaglebone green - failed to initialise Mraa, return code is ${returnCodes.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  return 0;
}
