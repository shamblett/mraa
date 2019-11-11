/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/11/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:mraa/mraa.dart';

class My9221Context {
  ffi.Pointer<MraaGpioContext> gpioClk;
  ffi.Pointer<MraaGpioContext> gpioData;

  bool autoRefresh = true;
  // We're only doing 8-bit greyscale, so the high order bits are
  // always 0
  int lowIntensity;
  int highIntensity;

  int maxLed;

  int instances;

  // An array of Uint16's representing our bit states (on/off)
  // intensities.  Only the low 8 bits are used, but in the future
  // 16bit support can work here as well.
  Uint16List bitStates;

  int commandWord;

  bool initialized;
}

/// Grove – LED Bar is comprised of a 10 segment LED gauge bar and an MY9221 LED controlling chip.
/// It can be used as an indicator for remaining battery life, voltage, water level, music volume
/// or other values that require a gradient display. There are 10 LED bars in the LED bar graph:
/// one red, one yellow, one light green, and seven green bars.
class MraaUpmLedBar {
  MraaUpmLedBar(Mraa mraa, ffi.Pointer<MraaGpioContext> clockPin,
      ffi.Pointer<MraaGpioContext> dataPin) {
    _dev = My9221Context();
    _dev.gpioClk = clockPin;
    _dev.gpioData = dataPin;
    _mraa = mraa;
  }

  static const int ledPerInstance = 12;

  My9221Context _dev;
  Mraa _mraa;

  ///Initialise - must be called before use
  void initialise() {
    MraaReturnCode ret;
    ret = _mraa.gpio.direction(_dev.gpioClk, MraaGpioDirection.out);
    if (ret != MraaReturnCode.success) {
      print(
          'initialise - Failed to set direction for clock pin, statis is ${returnCode.asString(ret)}');
    }
    ret = _mraa.gpio.direction(_dev.gpioData, MraaGpioDirection.out);
    if (ret != MraaReturnCode.success) {
      print(
          'initialise - Failed to set direction for data pin, statis is ${returnCode.asString(ret)}');
    }
    setLowIntensityValue(0x00);
    setHighIntensityValue(0xFF);
    _dev.commandWord = 0x0000; // all defaults
    _dev.instances = 1;
    _dev.bitStates = Uint16List(ledPerInstance);
    autoRefresh = true;
    _dev.maxLed = ledPerInstance;
    clearAll();
    _dev.initialized = true;
  }

  void close() {
    if (_dev.initialized) {
      clearAll();
      if (_dev.autoRefresh) {
        refresh();
      }
    }
    _mraa.gpio.close(_dev.gpioClk);
    _mraa.gpio.close(_dev.gpioData);
  }

  /// Set level (0-10)
  /// Level 0 means all leds off
  /// Level 10 means all leds on
  /// Level 4.5 means 4 LEDs on and the 5th LED's half on
  void setLevel(double level) {
    double localLevel = level;
    localLevel = max(0, min(10, level));
    localLevel *=
        8; // there are 8 (noticable) levels of brightness on each segment

    // Place number of 'level' of 1-bits on __state
    for (int i = 0; i < 10; i++) {
      _dev.bitStates[i] = (localLevel > 8)
          ? ~0
          : (localLevel > 0) ? ~(~0 << localLevel.toInt()) : 0;

      localLevel -= 8;
    }
    ;

    int state = 0;
    for (int i = 0; i < _dev.maxLed; i++) {
      state += _dev.bitStates[i] << i;
    }
    send16BitBlock(state);
  }

  void setLed(int led, {bool on}) {
    final int maxLed = _dev.maxLed - 1;
    int localLed = led;

    if (localLed > maxLed) {
      localLed = maxLed;
    }
    if (localLed < 0) {
      localLed = 0;
    }
    _dev.bitStates[localLed] = on ? _dev.highIntensity : _dev.lowIntensity;
    if (_dev.autoRefresh) {
      refresh();
    }
  }

  void setLowIntensityValue(int intensity) =>
      _dev.lowIntensity = intensity & 0xff;

  void setHighIntensityValue(int intensity) =>
      _dev.highIntensity = intensity & 0xff;

  void setAll() {
    for (int i = 0; i < _dev.maxLed; i++) {
      _dev.bitStates[i] = _dev.highIntensity;
    }

    if (_dev.autoRefresh) {
      refresh();
    }
  }

  void clearAll() {
    for (int i = 0; i < _dev.maxLed; i++) {
      _dev.bitStates[i] = _dev.lowIntensity;
    }

    if (_dev.autoRefresh) {
      refresh();
    }
  }

  set autoRefresh(bool enable) => _dev.autoRefresh = enable;

  int get maxLed => _dev.maxLed;

  void refresh() {
    send16BitBlock(_dev.commandWord);
    for (int i = 0; i < 10; i++) {
      send16BitBlock(_dev.bitStates[i]);
    }
    // Two extra empty bits for padding the command to the correct length
    send16BitBlock(0x00);
    send16BitBlock(0x00);
    lockData();
  }

  void lockData() {
    print('latching');
    _mraa.gpio.write(_dev.gpioData, 0);
    _mraa.gpio.write(_dev.gpioClk, 1);
    _mraa.gpio.write(_dev.gpioClk, 0);
    _mraa.gpio.write(_dev.gpioClk, 1);
    _mraa.gpio.write(_dev.gpioClk, 0);
    sleep(const Duration(microseconds: 240));

    for (int idx = 0; idx < 4; idx++) {
      _mraa.gpio.write(_dev.gpioData, 1);
      _mraa.gpio.write(_dev.gpioData, 0);
    }
    sleep(const Duration(microseconds: 1));
    _mraa.gpio.write(_dev.gpioClk, 1);
    _mraa.gpio.write(_dev.gpioClk, 0);
  }

  void send16BitBlock(int data) {
    MraaReturnCode ret;
    int localData = data;
    int state = 0;
    for (int bitIdx = 0; bitIdx < 16; bitIdx++) {
      state = localData & 0x8000 == 1 ? 1 : 0;
      ret = _mraa.gpio.write(_dev.gpioData, state);
      print('Sent state $state');
      if (ret != MraaReturnCode.success) {
        print(
            'send16BitBlock - Failed to write state to data pin, status is ${returnCode.asString(ret)}, state is $state');
      }
      state = _mraa.gpio.read(_dev.gpioClk);
      if (state == Mraa.generalError) {
        print(
            'send16BitBlock - Failed to read state of clock pin, status is ${returnCode.asString(ret)}');
      }
      if (state != 0) {
        state = 0;
      } else {
        state = 1;
      }
      ret = _mraa.gpio.write(_dev.gpioClk, state);
      if (ret != MraaReturnCode.success) {
        print(
            'send16BitBlock - Failed to write state to clock pin, status is ${returnCode.asString(ret)}, state is $state');
      }
      localData <<= 1;
    }
  }
}
