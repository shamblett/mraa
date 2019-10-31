/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

/// Get some UART details for the Beaglebone Green
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading
  final Mraa mraa = Mraa.fromLib('lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  print('Initialising MRAA');
  final MraaReturnCode ret = mraa.common.initialise();
  if (ret != MraaReturnCode.success) {
    print(
        'Beaglebone green - failed to initialise MRAA, return code is ${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final String platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  print('Getting UART device count');
  final int uartCount = mraa.common.uartCount();
  if (uartCount == Mraa.generalError) {
    print('Unable to get UART device count, exiting');
    return -1;
  }
  if (uartCount == 0) {
    print('There are no UART devices found on this platform, exiting');
    return 0;
  }

  print('UART device settings');
  print('');
  for (int i = 0; i < uartCount; i++) {
    print('Settings for UART device index $i');
    final MraaUartSettings settings = MraaUartSettings();
    final MraaReturnCode ret = mraa.uart.settings(i, settings);
    if (ret != MraaReturnCode.success) {
      print('Unable to get settings for UART index $i');
    } else {
      print('Settings for UART device $i.....');
      print(settings);
    }
  }

  print('Complete');
  return 0;
}