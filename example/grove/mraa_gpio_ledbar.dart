/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/11/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:math';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_ledbar.dart';

// The GPIO pins for the Grove Led bar, set as needed.
const int clockGPIOPin = 59;
const int dataGPIOPin = 57;

/// An exercise for the Grove Led Bar
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading.
  // Please change this for your platform.
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
        'Failed to initialise MRAA, return code is ${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The Led Bar sensor initialisation
  print('Initialising the Led bar');
  final ffi.Pointer<MraaGpioContext> dataContext =
      mraa.gpio.initialise(dataGPIOPin);
  final ffi.Pointer<MraaGpioContext> clockContext =
      mraa.gpio.initialise(clockGPIOPin);
  final MraaUpmLedBar ledbar = MraaUpmLedBar(mraa, clockContext, dataContext);
  ledbar.initialise();

  print('All on/off');
  ledbar.clearAll();
  sleep(const Duration(milliseconds: 2000));
  ledbar.setAll();
  sleep(const Duration(milliseconds: 2000));
  ledbar.clearAll();
  sleep(const Duration(milliseconds: 2000));

  print('Exercising the Led Bar');
  ledbar.setLed(9, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.setLed(8, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.setLed(7, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.setLed(1, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.setLed(2, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.setLed(3, on: true);
  sleep(const Duration(milliseconds: 500));

  ledbar.clearAll();
  sleep(const Duration(milliseconds: 2000));

  print('Random single bars');
  for (int i = 0; i < 19; i++) {
    final int state = Random().nextInt(9);
    ledbar.setLed(state, on: true);
    sleep(const Duration(milliseconds: 2000));
    ledbar.setLed(state, on: false);
  }

  print('Random levels');
  for (int i = 0; i < 19; i++) {
    final int state = Random().nextInt(10);
    ledbar.setLevel(state);
    sleep(const Duration(milliseconds: 2000));
  }

  return 0;
}
