/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_pir.dart';

// The GPIO pin for the Grove PIR motion sensor, set as needed.
const int pirSensorGPIOPin = 73;

/// Check if the Grove PIR motion sensor has been triggered
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading.
  // Please change this for your platform.
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0')
    ..noJsonLoading = true
    ..initialise();

  // Version
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising MRAA');
  final MraaReturnCode ret = mraa.common.initialise();
  if (ret != MraaReturnCode.success) {
    print('Failed to initialise MRAA, return code is '
        '${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The PIR sensor initialisation
  print('Initialising GPIO');
  final ffi.Pointer<MraaGpioContext> context =
      mraa.gpio.initialise(pirSensorGPIOPin);

  print('Checking for a PIR motion trigger');
  final MraaUpmPirMotion pir = MraaUpmPirMotion(mraa, context);
  for (int i = 1; i <= 10000; i++) {
    print('Current value is ${pir.value()}');
    if (pir.hasTriggered()) {
      print('PIR has triggered');
    }
    sleep(const Duration(milliseconds: 300));
  }

  return 0;
}
