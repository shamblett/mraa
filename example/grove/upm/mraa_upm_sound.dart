/**
* Package : mraa
* Author : S. Hamblett <steve.hamblett@linux.com>
* Date   : 13/11/2019
* Copyright :  S.Hamblett
*/

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:mraa/mraa.dart';

/// Grove - Sound Sensor can detect the sound intensity of the environment.
/// The main component of the module is a simple microphone, which is based
/// on the LM386 amplifier and an electret microphone.
class MraaUpmSound {
  MraaUpmSound(this._mraa, this._context, [this.sampleCount = 5]);

  /// The initialised MRAA library
  final Mraa _mraa;

  /// The initialised device context
  final ffi.Pointer<MraaAioContext> _context;

  /// The sample count
  final int sampleCount;

  /// Get a raw value directly from the sound sensor
  int rawValue() => _mraa.aio.read(_context);

  /// Get a smoothed value averaged over [sampleCount] samples
  int value() {
    int retValue = 0;
    for (int i = 0; i < sampleCount; i++) {
      retValue += rawValue();
      sleep(const Duration(milliseconds: 10));
    }
    return retValue ~/ sampleCount;
  }

  /// Gat a scaled value from 1..10, i.e for driving a led bar
  int scaledValue() => value() ~/ 100;
}
