/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_lcd.dart';

// The I2C bus id for the OLED display, set as needed. Note the OLED display
// used here is the Grove OLED display, recognised in the UPM library
// simply as an LCD device. The device address is set automatically in the
// UPM support class.
const int i2cBusId = 1;

/// Output to the OLED display.
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

  /// The LCD initialisation
  print('Initialising LCD');
  final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(i2cBusId);
  final MraaUpmLcd lcd = MraaUpmLcd(mraa, context);
  lcd.initialise();

  print('Printing to the LCD');
  lcd.write('Hello from the Dart VM');

  return 0;
}
