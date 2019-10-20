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
// ignore_for_file: always_specify_types

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

  static const int DISPLAY_CMD_SET_NORMAL = 0xA4;

  // ignore: always_specify_types
  static const List<List<int>> basicFont = [
    [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x00, 0x5F, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x00, 0x07, 0x00, 0x07, 0x00, 0x00, 0x00],
    [0x00, 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00, 0x00],
    [0x00, 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00, 0x00],
    [0x00, 0x23, 0x13, 0x08, 0x64, 0x62, 0x00, 0x00],
    [0x00, 0x36, 0x49, 0x55, 0x22, 0x50, 0x00, 0x00],
    [0x00, 0x00, 0x05, 0x03, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x1C, 0x22, 0x41, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x41, 0x22, 0x1C, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x08, 0x2A, 0x1C, 0x2A, 0x08, 0x00, 0x00],
    [0x00, 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00, 0x00],
    [0x00, 0xA0, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00],
    [0x00, 0x60, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x20, 0x10, 0x08, 0x04, 0x02, 0x00, 0x00],
    [0x00, 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00, 0x00],
    [0x00, 0x00, 0x42, 0x7F, 0x40, 0x00, 0x00, 0x00],
    [0x00, 0x62, 0x51, 0x49, 0x49, 0x46, 0x00, 0x00],
    [0x00, 0x22, 0x41, 0x49, 0x49, 0x36, 0x00, 0x00],
    [0x00, 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00, 0x00],
    [0x00, 0x27, 0x45, 0x45, 0x45, 0x39, 0x00, 0x00],
    [0x00, 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00, 0x00],
    [0x00, 0x01, 0x71, 0x09, 0x05, 0x03, 0x00, 0x00],
    [0x00, 0x36, 0x49, 0x49, 0x49, 0x36, 0x00, 0x00],
    [0x00, 0x06, 0x49, 0x49, 0x29, 0x1E, 0x00, 0x00],
    [0x00, 0x00, 0x36, 0x36, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x00, 0xAC, 0x6C, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x08, 0x14, 0x22, 0x41, 0x00, 0x00, 0x00],
    [0x00, 0x14, 0x14, 0x14, 0x14, 0x14, 0x00, 0x00],
    [0x00, 0x41, 0x22, 0x14, 0x08, 0x00, 0x00, 0x00],
    [0x00, 0x02, 0x01, 0x51, 0x09, 0x06, 0x00, 0x00],
    [0x00, 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00, 0x00],
    [0x00, 0x7E, 0x09, 0x09, 0x09, 0x7E, 0x00, 0x00],
    [0x00, 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00, 0x00],
    [0x00, 0x3E, 0x41, 0x41, 0x41, 0x22, 0x00, 0x00],
    [0x00, 0x7F, 0x41, 0x41, 0x22, 0x1C, 0x00, 0x00],
    [0x00, 0x7F, 0x49, 0x49, 0x49, 0x41, 0x00, 0x00],
    [0x00, 0x7F, 0x09, 0x09, 0x09, 0x01, 0x00, 0x00],
    [0x00, 0x3E, 0x41, 0x41, 0x51, 0x72, 0x00, 0x00],
    [0x00, 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00, 0x00],
    [0x00, 0x41, 0x7F, 0x41, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x20, 0x40, 0x41, 0x3F, 0x01, 0x00, 0x00],
    [0x00, 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00, 0x00],
    [0x00, 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00, 0x00],
    [0x00, 0x7F, 0x02, 0x0C, 0x02, 0x7F, 0x00, 0x00],
    [0x00, 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00, 0x00],
    [0x00, 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00, 0x00],
    [0x00, 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00, 0x00],
    [0x00, 0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00, 0x00],
    [0x00, 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00, 0x00],
    [0x00, 0x26, 0x49, 0x49, 0x49, 0x32, 0x00, 0x00],
    [0x00, 0x01, 0x01, 0x7F, 0x01, 0x01, 0x00, 0x00],
    [0x00, 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00, 0x00],
    [0x00, 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00, 0x00],
    [0x00, 0x3F, 0x40, 0x38, 0x40, 0x3F, 0x00, 0x00],
    [0x00, 0x63, 0x14, 0x08, 0x14, 0x63, 0x00, 0x00],
    [0x00, 0x03, 0x04, 0x78, 0x04, 0x03, 0x00, 0x00],
    [0x00, 0x61, 0x51, 0x49, 0x45, 0x43, 0x00, 0x00],
    [0x00, 0x7F, 0x41, 0x41, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x02, 0x04, 0x08, 0x10, 0x20, 0x00, 0x00],
    [0x00, 0x41, 0x41, 0x7F, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x04, 0x02, 0x01, 0x02, 0x04, 0x00, 0x00],
    [0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00],
    [0x00, 0x01, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x20, 0x54, 0x54, 0x54, 0x78, 0x00, 0x00],
    [0x00, 0x7F, 0x48, 0x44, 0x44, 0x38, 0x00, 0x00],
    [0x00, 0x38, 0x44, 0x44, 0x28, 0x00, 0x00, 0x00],
    [0x00, 0x38, 0x44, 0x44, 0x48, 0x7F, 0x00, 0x00],
    [0x00, 0x38, 0x54, 0x54, 0x54, 0x18, 0x00, 0x00],
    [0x00, 0x08, 0x7E, 0x09, 0x02, 0x00, 0x00, 0x00],
    [0x00, 0x18, 0xA4, 0xA4, 0xA4, 0x7C, 0x00, 0x00],
    [0x00, 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00, 0x00],
    [0x00, 0x00, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x80, 0x84, 0x7D, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00, 0x00],
    [0x00, 0x41, 0x7F, 0x40, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00, 0x00],
    [0x00, 0x7C, 0x08, 0x04, 0x7C, 0x00, 0x00, 0x00],
    [0x00, 0x38, 0x44, 0x44, 0x38, 0x00, 0x00, 0x00],
    [0x00, 0xFC, 0x24, 0x24, 0x18, 0x00, 0x00, 0x00],
    [0x00, 0x18, 0x24, 0x24, 0xFC, 0x00, 0x00, 0x00],
    [0x00, 0x00, 0x7C, 0x08, 0x04, 0x00, 0x00, 0x00],
    [0x00, 0x48, 0x54, 0x54, 0x24, 0x00, 0x00, 0x00],
    [0x00, 0x04, 0x7F, 0x44, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x3C, 0x40, 0x40, 0x7C, 0x00, 0x00, 0x00],
    [0x00, 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00, 0x00],
    [0x00, 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00, 0x00],
    [0x00, 0x44, 0x28, 0x10, 0x28, 0x44, 0x00, 0x00],
    [0x00, 0x1C, 0xA0, 0xA0, 0x7C, 0x00, 0x00, 0x00],
    [0x00, 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00, 0x00],
    [0x00, 0x08, 0x36, 0x41, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x00, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x41, 0x36, 0x08, 0x00, 0x00, 0x00, 0x00],
    [0x00, 0x02, 0x01, 0x01, 0x02, 0x01, 0x00, 0x00],
    [0x00, 0x02, 0x05, 0x05, 0x02, 0x00, 0x00, 0x00]
  ];
}

/// A local support implementation of the UPM LCD sensor, taken from the UPM lcd/ssd1327.cxx
/// implementation.
///
/// The SSD1327 is a 96x96 dot-matrix OLED/PLED segment driver with a controller.
/// This implementation supports the Grove LED 96*96 display module,
/// which is an OLED monochrome display.
class MraaUpmLcd {
  MraaUpmLcd(this._mraa, this._context) {
    // Set the device address
    _mraa.i2c.address(_context, lcdDeviceAddress);
  }

  /// The initialised MRAA library
  Mraa _mraa;

  /// The initialised I2C context
  ffi.Pointer<MraaI2cContext> _context;

  static const int lcdDeviceAddress = 0x3C;
  static const Duration INIT_SLEEP = Duration(milliseconds: 50);
  static const Duration CMD_SLEEP = Duration(milliseconds: 10);

  MraaReturnCode error = MraaReturnCode.success;

  int _grayHigh = 0;
  int _grayLow = 0;

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

    // Initialize the screen
    clear();
    setGrayLevel(12);
    _setNormalDisplay();
    _setVerticalMode();
  }

  /// Draws an image.
  /// Pixels are arranged in one byte for 8 vertical pixels and not addressed individually.
  MraaReturnCode draw(Uint8List data, int bytes) {
    const MraaReturnCode error = MraaReturnCode.success;

    _setHorizontalMode();
    for (int row = 0; row < bytes; row++) {
      for (int col = 0; col < 8; col += 2) {
        int value = 0x0;

        final int bitOne = (data[row] << col) & 0x80;
        final int bitTwo = (data[row] << (col + 1)) & 0x80;

        value |= (bitOne != 0) ? _grayHigh : 0x00;
        value |= (bitTwo != 0) ? _grayLow : 0x00;

        _writeReg(MraaUpmLcdDefinitions.LCD_DATA, <int>[value]);
        sleep(CMD_SLEEP - const Duration(milliseconds: 2));
      }
    }

    return error;
  }

  /// Sets the gray level for the LCD panel
  void setGrayLevel(int level) {
    _grayHigh = (level << 4) & 0xF0;
    _grayLow = level & 0x0F;
  }

  /// Writes a string to the LCD
  /// Note: only ASCII characters are supported.
  MraaReturnCode write(String msg) {
    const MraaReturnCode error = MraaReturnCode.success;

    _setVerticalMode();
    msg.codeUnits.forEach(_writeChar);
    return error;
  }

  /// Sets the cursor to specified coordinates
  MraaReturnCode setCursor(int row, int column) {
    const MraaReturnCode error = MraaReturnCode.success;
    // Column Address
    _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x15]); /* Set Column Address */
    sleep(CMD_SLEEP);
    _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x08 + (column * 4)]);
    /* Start Column:
       Start from 8 */
    sleep(CMD_SLEEP);
    _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x37]); /* End Column */
    sleep(CMD_SLEEP);
    // Row Address
    _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x75]); /* Set Row Address */
    sleep(CMD_SLEEP);
    _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x00 + (row * 8)]); /* Start Row*/
    sleep(CMD_SLEEP);
    _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x07 + (row * 8)]); /* End Row*/
    sleep(CMD_SLEEP);

    return error;
  }

  /// Clears the display of all characters
  MraaReturnCode clear() {
    int columnIdx, rowIdx;

    for (rowIdx = 0; rowIdx < 12; rowIdx++) {
      // clear all columns
      for (columnIdx = 0; columnIdx < 12; columnIdx++) {
        _writeChar(' '.codeUnitAt(0));
      }
    }

    return MraaReturnCode.success;
  }

  /// Returns to the original coordinates (0,0)
  MraaReturnCode home() => setCursor(0, 0);

  MraaReturnCode _writeChar(int value) {
    MraaReturnCode rv = MraaReturnCode.success;
    int calcValue = value;
    if (value < 0x20 || value > 0x7F) {
      calcValue = 0x20; // space
    }

    for (int row = 0; row < 8; row = row + 2) {
      for (int col = 0; col < 8; col++) {
        int data = 0x0;

        final int bitOne =
            ((MraaUpmLcdDefinitions.basicFont[calcValue - 32][row]) >> col) &
                0x1;
        final int bitTwo = ((MraaUpmLcdDefinitions.basicFont[calcValue - 32]
                    [row + 1]) >>
                col) &
            0x1;

        data |= (bitOne != 0) ? _grayHigh : 0x00;
        data |= (bitTwo != 0) ? _grayLow : 0x00;

        rv = _writeReg(MraaUpmLcdDefinitions.LCD_DATA, <int>[data]);
        sleep(CMD_SLEEP - const Duration(milliseconds: 2));
      }
    }
    return rv;
  }

  MraaReturnCode _setNormalDisplay() =>
      _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[
        MraaUpmLcdDefinitions.DISPLAY_CMD_SET_NORMAL
      ]); // set to normal display '1' is ON

  MraaReturnCode _setHorizontalMode() {
    MraaReturnCode rv = MraaReturnCode.success;
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA0]); // remap to
    sleep(CMD_SLEEP);
    rv = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x42]); // horizontal mode
    sleep(CMD_SLEEP);

    // Row Address
    rv = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x75]); // Set Row Address
    sleep(CMD_SLEEP);
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x00]); // Start 0
    sleep(CMD_SLEEP);
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x5f]); // End 95
    sleep(CMD_SLEEP);

    // Column Address
    rv = _writeReg(
        MraaUpmLcdDefinitions.LCD_CMD, <int>[0x15]); // Set Column Address
    sleep(CMD_SLEEP);
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD,
        <int>[0x08]); // Start from 8th Column of driver
    // IC. This is 0th Column for OLED
    sleep(CMD_SLEEP);
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD,
        <int>[0x37]); // End at  (8 + 47)th column. Each
    // Column has 2 pixels(or segments)
    sleep(CMD_SLEEP);
    return rv;
  }

  MraaReturnCode _setVerticalMode() {
    MraaReturnCode rv = MraaReturnCode.success;
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0xA0]); // remap to
    sleep(CMD_SLEEP);
    rv = _writeReg(MraaUpmLcdDefinitions.LCD_CMD, <int>[0x46]); // Vertical mode
    sleep(CMD_SLEEP);
    return rv;
  }

  MraaReturnCode _writeReg(int reg, List<int> data) =>
      _mraa.i2c.writeByteData(_context, data[0], reg);
}
