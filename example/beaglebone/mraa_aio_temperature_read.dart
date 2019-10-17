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

// The AIO pin for the temperature sensor, set as needed. Note the temperature sensor
// used here is the Grove temperature sensor, recognised in the UPM library
// simply as a temperature device.
const int temperatureSensorAIOPin = 2;

/// Read the current temperature value using AIO from the Beagleboone Greens temperature sensor
int main() {
  // Initialise form our Beaglebone Mraa lib version 2.0.0 with no JSON loading
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  // Version
  final String mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising MRAA');
  final MraaReturnCode ret = mraa.common.initialise();
  if (ret != MraaReturnCode.success) {
    print(
        'Beaglebone Green - failed to initialise MRAA, return code is ${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// Initialise the temperature sensor
  print('Initialising AIO');
  final ffi.Pointer<MraaAioContext> context =
      mraa.aio.initialise(temperatureSensorAIOPin);

  // Get the ADC value range for Celsius conversion
  final int maxAdc = 1 << mraa.aio.getBit(context);

  print('Reading the temperature sensor values');
  for (int i = 1; i <= 100; i++) {
    final int val = mraa.aio.read(context);
    print('$i -> Raw temperature value is : $val');
    final double r = (maxAdc - val) * 10000.0 / val;
    final double celsius =
        1.0 / (log(r / 10000.0) / 3975.0 + 1.0 / 298.15) - 273.15;
    print('$i -> Celsius temperature value is : ${celsius.toStringAsFixed(2)}');
    sleep(const Duration(milliseconds: 2000));
  }

  return 0;
}
