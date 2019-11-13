/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_temperature.dart';

// The AIO pin for the temperature sensor, set as needed.
// Note the temperature sensor used here is the Grove temperature
// sensor, recognised in the UPM library simply as a temperature device.
const int temperatureSensorAIOPin = 2;

/// Read the current temperature value using AIO from the Grove
/// temperature sensor
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

  /// Initialise the temperature sensor
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context =
      mraa.aio.initialise(temperatureSensorAIOPin);

  print('Reading the temperature sensor values');
  final MraaUpmTemperature temperature = MraaUpmTemperature(mraa, context);
  for (int i = 1; i <= 100; i++) {
    final MraaUpmTemperatureValues values = temperature.getValues();
    print(values);
    sleep(const Duration(milliseconds: 2000));
  }

  return 0;
}
