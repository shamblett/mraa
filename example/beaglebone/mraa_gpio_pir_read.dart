/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';

// The GPIO pin for the PIR motion sensor, set as needed.
const int pirSensorGPIOPin = 73;

/// Check if the PIR motion sensor has been triggered
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  // Version
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising MRAA');
  MraaReturnCodes ret = mraa.common.initialise();
  if (ret != MraaReturnCodes.mraaSuccess) {
    print(
        'Beaglebone Green - failed to initialise MRAA, return code is ${returnCodes.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The PIR sensor initialisation
  print('Initialising AIO');
  final ffi.Pointer<MraaGpioContext> context =
      mraa.gpio.initialise(pirSensorGPIOPin);

  print('Checking for a PIR motion trigger');
  for (int i = 1; i <= 10000; i++) {
    int val = mraa.gpio.read(context);
    if (val == 1) {
      print('PIR motion sensor has triggered');
    }
    val = 0;
    sleep(const Duration(milliseconds: 300));
  }

  return 0;
}