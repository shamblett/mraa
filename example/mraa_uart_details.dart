/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

/// Get some UART details.
int main() {
  // Initialise from our Beaglebone Mraa lib version 2.0.0 with no JSON loading.
  // Please change this for your platform.
  final Mraa mraa = Mraa.fromLib('grove/lib/libmraa.so.2.0.0');
  mraa.noJsonLoading = true;
  mraa.initialise();

  print('Initialising MRAA');
  final MraaReturnCode ret = mraa.common.initialise();
  if (ret != MraaReturnCode.success) {
    print(
        'Failed to initialise MRAA, return code is ${returnCode.asString(ret)}');
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

  print('There are $uartCount UART devices found on this platform');
  print('');
  print('UART device paths');
  print('');
  final List<String> devices = List<String>();
  for (int i = 0; i < uartCount; i++) {
    final String devicePath = mraa.uart.devicePathFromIndex(i);
    print('Path for UART device index $i is $devicePath');
    devices.add(devicePath);
  }

  print('');
  print('UART device settings');
  print('');
  for (String device in devices) {
    final MraaUartSettings settings = MraaUartSettings();
    settings.devicePath = device;
    final MraaReturnCode ret = mraa.uart.settings(-1, settings);
    if (ret != MraaReturnCode.success) {
      print('Unable to get settings for UART device $device');
    } else {
      print('Settings for UART device $device .....');
      print(settings);
    }
  }

  print('Complete');
  return 0;
}
