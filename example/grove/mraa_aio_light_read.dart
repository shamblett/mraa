/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_light.dart';

// The AIO pin for the light sensor, set as needed. Note the light sensor
// used here is the Grove light sensor, recognised in the UPM library
// simply as a light device.
const int lightSensorAIOPin = 0;

/// Read the current light value using AIO from the Grove light sensor
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

  /// The light sensor initialisation
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context =
      mraa.aio.initialise(lightSensorAIOPin);

  print('Reading the light sensor values');
  final MraaUpmLight light = MraaUpmLight(mraa, context);
  for (int i = 1; i <= 100; i++) {
    final MraaUpmLightValues values = light.getValues();
    print(values);
    sleep(const Duration(milliseconds: 2000));
  }

  return 0;
}
