/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:math';
import 'package:mraa/mraa.dart';

// The AIO pin for the light sensor, set as needed. Note the light sensor
// used here is the Grove light sensor, recognised in the UPM library
// simply as a light device.
const int lightSensorAIOPin = 0;

/// Read the current light value using AIO from the Beagleboone Greens light sensor
int main() {
  // Initialise form our Beaglebone Mraa lib version 2.0.0 with no JSON loading
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  // Version
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising MRAA');
  final MraaReturnCodes ret = mraa.common.initialise();
  if (ret != MraaReturnCodes.mraaSuccess) {
    print(
        'Beaglebone Green - failed to initialise MRAA, return code is ${returnCodes.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The light sensor initialisation
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context =
      mraa.aio.initialise(lightSensorAIOPin);

  // Get the ADC value range for Lux conversion
  final int maxAdc = (1 << mraa.aio.getBit(context)) - 1;

  print('Reading the light sensor values');
  for (int i = 1; i <= 100; i++) {
    final int val = mraa.aio.read(context);
    print('$i -> Raw light value is : $val');
    final double lux =
        10000.0 / pow(((maxAdc - val) * 10.0 / val) * 15.0, 4.0 / 3.0);
    print('$i -> Lux light value is : ${lux.toStringAsFixed(2)}');
    sleep(const Duration(milliseconds: 2000));
  }

  return 0;
}
