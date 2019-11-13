/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';
import 'upm/mraa_upm_lcd.dart';

// The Seeed logo bitmap
const List<int> seeedLogo96x96 = <int>[
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x20,
  0x08,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x60,
  0x04,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xC0,
  0x06,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x01,
  0xC0,
  0x07,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x01,
  0xC0,
  0x07,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x03,
  0x80,
  0x03,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x03,
  0x80,
  0x03,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x07,
  0x80,
  0x03,
  0xC0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x07,
  0x80,
  0x01,
  0xC0,
  0x08,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x20,
  0x07,
  0x80,
  0x01,
  0xE0,
  0x08,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x20,
  0x0F,
  0x80,
  0x01,
  0xE0,
  0x08,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x30,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x08,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x30,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x18,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x30,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x18,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x30,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x18,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x38,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x18,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x38,
  0x0F,
  0x00,
  0x01,
  0xE0,
  0x38,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x38,
  0x0F,
  0x80,
  0x01,
  0xE0,
  0x38,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x3C,
  0x0F,
  0x80,
  0x01,
  0xE0,
  0x78,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x3E,
  0x0F,
  0x80,
  0x03,
  0xE0,
  0x78,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x1E,
  0x07,
  0x80,
  0x03,
  0xE0,
  0xF8,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x1E,
  0x07,
  0x80,
  0x03,
  0xE0,
  0xF0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x07,
  0x80,
  0x03,
  0xC1,
  0xF0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x0F,
  0x87,
  0xC0,
  0x07,
  0xC1,
  0xF0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x0F,
  0x83,
  0xC0,
  0x07,
  0x83,
  0xE0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x0F,
  0xC3,
  0xC0,
  0x07,
  0x87,
  0xE0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x07,
  0xE1,
  0xE0,
  0x07,
  0x0F,
  0xC0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x03,
  0xF0,
  0xE0,
  0x0F,
  0x0F,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x01,
  0xF8,
  0xF0,
  0x0E,
  0x1F,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x01,
  0xF8,
  0x70,
  0x1C,
  0x3F,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xFC,
  0x30,
  0x18,
  0x7E,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7F,
  0x18,
  0x30,
  0xFC,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x88,
  0x21,
  0xF0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x0F,
  0xC4,
  0x47,
  0xE0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x03,
  0xE0,
  0x0F,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0xF8,
  0x3E,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x0E,
  0xE0,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x02,
  0x00,
  0x00,
  0x00,
  0x00,
  0x6C,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x02,
  0x00,
  0x06,
  0x00,
  0x00,
  0x6C,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x02,
  0x00,
  0x06,
  0x00,
  0x00,
  0x60,
  0x00,
  0x7E,
  0x3F,
  0x0F,
  0xC3,
  0xF0,
  0xFA,
  0x0F,
  0xDF,
  0xE1,
  0x9F,
  0xEC,
  0x7E,
  0xE6,
  0x73,
  0x9C,
  0xE7,
  0x39,
  0xCE,
  0x1C,
  0xDF,
  0xE1,
  0xB9,
  0xEC,
  0xE7,
  0xE0,
  0x61,
  0xD8,
  0x66,
  0x1B,
  0x86,
  0x1C,
  0x06,
  0x61,
  0xB0,
  0x6D,
  0xC3,
  0x7C,
  0x7F,
  0xFF,
  0xFF,
  0xFF,
  0x06,
  0x0F,
  0x86,
  0x61,
  0xB0,
  0x6D,
  0x83,
  0x3E,
  0x7F,
  0xFF,
  0xFF,
  0xFF,
  0x06,
  0x07,
  0xC6,
  0x61,
  0xB0,
  0x6D,
  0x83,
  0xC3,
  0x61,
  0x18,
  0x46,
  0x03,
  0x86,
  0x18,
  0x66,
  0x61,
  0xB0,
  0x6D,
  0xC3,
  0xFE,
  0x7F,
  0x9F,
  0xE7,
  0xF9,
  0xFE,
  0x1F,
  0xE6,
  0x3F,
  0x9F,
  0xEC,
  0xFE,
  0x7E,
  0x3F,
  0x0F,
  0xC3,
  0xF0,
  0xFA,
  0x0F,
  0xC6,
  0x3F,
  0x9F,
  0xEC,
  0x7E,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7C,
  0x00,
  0x00,
  0x20,
  0x82,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x44,
  0x00,
  0x00,
  0x20,
  0x82,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x6C,
  0xF3,
  0xCF,
  0x70,
  0x9E,
  0x79,
  0xE7,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7D,
  0x9E,
  0x68,
  0x20,
  0xB2,
  0xC8,
  0x64,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x47,
  0x9E,
  0x6F,
  0x20,
  0xB2,
  0xF9,
  0xE7,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x46,
  0x9A,
  0x61,
  0x20,
  0xB2,
  0xCB,
  0x60,
  0x80,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7C,
  0xF3,
  0xCF,
  0x30,
  0x9E,
  0x79,
  0xE7,
  0x90,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x10,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x7C,
  0x02,
  0x00,
  0x00,
  0x82,
  0x60,
  0x00,
  0x00,
  0xF8,
  0x00,
  0x00,
  0x40,
  0x40,
  0x02,
  0x00,
  0x00,
  0x83,
  0x60,
  0x00,
  0x00,
  0x8C,
  0x00,
  0x00,
  0x40,
  0x60,
  0xB7,
  0x79,
  0xE7,
  0x81,
  0xC7,
  0x92,
  0x70,
  0x89,
  0xE7,
  0x9E,
  0x78,
  0x7C,
  0xE2,
  0xC9,
  0x2C,
  0x81,
  0xCC,
  0xD2,
  0x40,
  0xFB,
  0x21,
  0xB2,
  0x48,
  0x40,
  0x62,
  0xF9,
  0x2C,
  0x80,
  0x8C,
  0xD2,
  0x40,
  0x8B,
  0xE7,
  0xB0,
  0x48,
  0x40,
  0xE2,
  0xC9,
  0x2C,
  0x80,
  0x84,
  0xD2,
  0x40,
  0x8B,
  0x2D,
  0x92,
  0x48,
  0x7D,
  0xB3,
  0x79,
  0x27,
  0x80,
  0x87,
  0x9E,
  0x40,
  0x8D,
  0xE7,
  0x9E,
  0x48,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00,
  0x00
];

// The I2C bus id for the OLED display, set as needed. Note the OLED display
// used here is the Grove OLED display, recognised in the UPM library
// simply as an LCD device. The device address is set automatically in the
// UPM support class.
const int i2cBusId = 1;

/// Output to the Grove OLED display.
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

  /// The LCD initialisation
  print('Initialising LCD');
  final ffi.Pointer<MraaI2cContext> context = mraa.i2c.initialise(i2cBusId);
  final MraaUpmLcd lcd = MraaUpmLcd(mraa, context)..initialise();

  print('Printing to the LCD');
  lcd.setCursor(1, 0);
  lcd.write('Hello from');
  lcd.setCursor(2, 0);
  lcd.write('the Dart VM');
  lcd.setCursor(4, 0);
  lcd.write('Brought to');
  lcd.setCursor(5, 0);
  lcd.write('you by FFI');
  lcd.setCursor(6, 0);
  lcd.write('and Intel\'s');
  lcd.setCursor(7, 0);
  lcd.write('MRAA library');

  print('Press a key to clear the display and continue.....');
  stdin.readByteSync();
  lcd.home();
  lcd.clear();
  print('Now lets draw a logo.....');
  lcd.drawBitMap(seeedLogo96x96, seeedLogo96x96.length);
  print('Press a key to clear the display and exit .....');
  stdin.readByteSync();
  lcd.home();
  lcd.clear();

  return 0;
}
