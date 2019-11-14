/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/11/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_sound.dart';

// The AIO pin for the sound sensor, set as needed. Note the sound sensor
// used here is the Grove sound sensor, recognised in the UPM library
// simply as a sound device.
const int soundSensorAIOPin = 4;

/// Read the sound level from the sound sensor
int main() {
  // Initialise form our Beaglebone Mraa lib version 2.0.0 with no JSON loading.
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

  /// Initialise the sound sensor
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context =
      mraa.aio.initialise(soundSensorAIOPin);

  print('Reading the sound sensor values');
  final MraaUpmSound sound = MraaUpmSound(mraa, context);
  for (int i = 1; i <= 100; i++) {
    print('Current raw sound value is : ${sound.rawValue()}');
    print('Current smoothed sound value is : ${sound.value()}');
    print('Current scaled value is ${sound.scaledValue()}');
    sleep(const Duration(milliseconds: 200));
  }

  return 0;
}
