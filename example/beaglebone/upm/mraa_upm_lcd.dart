/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';
import 'package:mraa/mraa.dart';

// ignore_for_file: constant_identifier_names

/// Command/Data definitions for the Grove OLED SSD1327 LCD device
class MraaUpmLcdDefinitions {
  static const int LCD_CLEARDISPLAY = 0x01;
  static const int LCD_RETURNHOME = 0x02;
  static const int LCD_ENTRYMODESET = 0x04;
  static const int LCD_DISPLAYCONTROL = 0x08;
  static const int LCD_CURSORSHIFT = 0x10;
  static const int LCD_FUNCTIONSET = 0x20;

  static const int LCD_BACKLIGHT = 0x08;
  static const int LCD_NOBACKLIGHT = 0x00;

  // flags for display entry mode
  static const int LCD_ENTRYRIGHT = 0x00;
  static const int LCD_ENTRYLEFT = 0x02;
  static const int LCD_ENTRYSHIFTINCREMENT = 0x01;
  static const int LCD_ENTRYSHIFTDECREMENT = 0x00;

  // flags for display on/off control
  static const int LCD_DISPLAYON = 0x04;
  static const int LCD_DISPLAYOFF = 0x00;
  static const int LCD_CURSORON = 0x02;
  static const int LCD_CURSOROFF = 0x00;
  static const int LCD_BLINKON = 0x01;
  static const int LCD_BLINKOFF = 0x00;

  // flags for display/cursor shift
  static const int LCD_DISPLAYMOVE = 0x08;
  static const int LCD_MOVERIGHT = 0x04;
  static const int LCD_MOVELEFT = 0x00;

  // flags for function set
  static const int LCD_8BITMODE = 0x10;
  static const int LCD_4BITMODE = 0x00;
  static const int LCD_2LINE = 0x08;
  static const int LCD_1LINE = 0x00;
  static const int LCD_5x10DOTS = 0x04;
  static const int LCD_5x8DOTS = 0x00;

  // flags for CGRAM
  static const int LCD_SETCGRAMADDR = 0x40;

  // may be implementation specific
  static const int LCD_EN = 0x04; // Enable bit
  static const int LCD_RW = 0x02; // Read/Write bit
  static const int LCD_RS = 0x01; // Register select bit
  static const int LCD_DATA = 0x40;
  static const int LCD_CMD = 0x80;
}

/// A local support implementation of the UPM LCD sensor.
/// The SSD1327 is a 96x96 dot-matrix OLED/PLED segment driver with a controller.
/// This implementation supports the Grove LED 96*96 display module,
/// which is an OLED monochrome display.
class MraaUpmLcd {
  MraaUpmLcd(this._mraa, this._context);

  /// The initialised MRAA library
  Mraa _mraa;

  /// The initialised I2C context
  ffi.Pointer<MraaI2cContext> _context;

  static const int lcdDeviceAddress = 0x3C;
  static const Duration INIT_SLEEP = Duration(milliseconds: 50);
  static const Duration CMD_SLEEP = Duration(milliseconds: 10);

  MraaReturnCode error = MraaReturnCode.success;

  /// Initialise the display for use
  void initialise() {
    sleep(INIT_SLEEP);
    _writeReg(MraaUpmLcdDefinitions.LCD_CMD,
        <int>[0xFD]); // Unlock OLED driver IC MCU
    // interface from entering command.
    // i.e: Accept commands
    sleep(INIT_SLEEP);
    _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x12]);
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xAE]); // Set display off
    sleep(INIT_SLEEP);
    _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA8]); // set multiplex ratio
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x5F]); // 96
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA1]); // set display start line
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x00]); //
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA2]); // set display offset
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x60]);
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA0]); // set remap
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x46]);
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xAB]); // set vdd internal
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x01]); //
    sleep(INIT_SLEEP);
    error =
        _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x81]); // set contrasr
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x53]); // 100 nit
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xB1]); // Set Phase Length
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0X51]); //
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD,
        <int>[0xB3]); // Set Display Clock Divide Ratio/Oscillator
    // Frequency
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x01]); //
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xB9]); //
    sleep(INIT_SLEEP);
    error =
        _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xBC]); // set pre_charge
    // voltage/VCOMH
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x08]); // (0x08);
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xBE]); // set VCOMH
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0X07]); // (0x07);
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xB6]); // Set second pre-charge
    // period
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x01]); //
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD,
        <int>[0xD5]); // enable second precharge and enternal vsl
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0X62]); // (0x62);
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA4]); // Set Normal Display Mode
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x2E]); // Deactivate Scroll
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0xAF]); // Switch on display
    sleep(INIT_SLEEP);

    // Row Address
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x75]); // Set Row Address
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x00]); // Start 0
    sleep(INIT_SLEEP);
    error = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x5f]); // End 95
    sleep(INIT_SLEEP);

    // Column Address
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x15]); // Set Column Address
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x08]); // Start from 8th Column of
    // driver IC. This is 0th
    // Column for OLED
    sleep(INIT_SLEEP);
    error = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x37]); // End at  (8 + 47)th
    // column. Each Column has 2
    // pixels(segments)
    sleep(INIT_SLEEP);

    clear();
    _setNormalDisplay();
    _setVerticalMode();
  }

  /// Draws an image.
  /// Pixels are arranged in one byte for 8 vertical pixels and not addressed individually.
  MraaReturnCode draw(Uint8List data, int bytes) =>
      MraaReturnCode.errorFeatureNotImplemented;

  /// Sets the gray level for the LCD panel
  void setGrayLevel(int level) {}

  /// Writes a string to the LCD
  /// Note: only ASCII characters are supported.
  MraaReturnCode write(String msg) {}

  /// Sets the cursor to specified coordinates
  MraaReturnCode setCursor(int row, int column) =>
      MraaReturnCode.errorFeatureNotImplemented;

  /// Clears the display of all characters
  MraaReturnCode clear() {}

  /// Returns to the original coordinates (0,0)
  MraaReturnCode home() {}

  MraaReturnCode _writeChar(int value) {}

  MraaReturnCode _setNormalDisplay() {}

  MraaReturnCode _setHorizontalMode() {}

  MraaReturnCode _setVerticalMode() {}

  MraaReturnCode _writeReg(int reg, List<int> data) =>
      _mraa.i2c.writeByteData(_context, data[0], reg);
}
