/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';

/// Read the current light value usin AIO from the Beagleboone Greens light sensor
int main() {
  final Mraa mraa = Mraa();
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising');
  final MraaReturnCodes ret = mraa.common.initialise();
  if (ret != MraaReturnCodes.mraaSuccess) {
    print(
        'Beaglebone green - failed to initialise Mraa, return code is ${returnCodes.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The light sensor is on AIO 1
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context = mraa.aio.initialise(1);

  print('Reading the raw light sensor value');
  for (int i = 1; i <= 5; i++) {
    final int val = mraa.aio.read(context);
    print('$i -> light value is : $val');
    sleep(const Duration(milliseconds:2000));
  }

  return 0;
}