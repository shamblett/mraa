/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:math';
import 'package:mraa/mraa.dart';

/// The values class for the UPM light class
class MraaUpmLightValues {
  /// Raw value
  int raw;

  /// Lux
  double lux;

  /// Timestamp
  DateTime validAt;

  @override
  String toString() =>
      'Light values at $validAt :: Raw : $raw : Lux ${lux.toStringAsFixed(2)}';
}

/// A local support implementation of the UPM light sensor
/// we can use for the Grove light sensor
class MraaUpmLight {
  MraaUpmLight(this._mraa, this._context);

  /// The initialised MRAA library
  Mraa _mraa;

  /// The initialised device context
  ffi.Pointer<MraaAioContext> _context;

  /// Get the raw and Lux light values and timestamp them.
  MraaUpmLightValues getValues() {
    // Get the ADC value range for Lux conversion
    final int maxAdc = (1 << _mraa.aio.getBit(_context)) - 1;
    final int raw = _mraa.aio.read(_context);
    return calculateLux(raw, maxAdc);
  }

  MraaUpmLightValues calculateLux(int rawValue, int maxAdc) {
    final MraaUpmLightValues values = MraaUpmLightValues();
    values.raw = rawValue;
    values.lux = 10000.0 /
        pow(((maxAdc - values.raw) * 10.0 / values.raw) * 15.0, 4.0 / 3.0);
    return values;
  }
}
