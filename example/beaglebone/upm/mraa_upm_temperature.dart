/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'dart:ffi' as ffi;
import 'dart:math';
import 'package:mraa/mraa.dart';

/// The values class for the UPM temperature class
class MraaUpmTemperatureValues {
  /// Raw value
  int raw;

  /// Celsius
  double celsius;

  /// Timestamp
  DateTime validAt;

  @override
  String toString() =>
      'Temperature values at $validAt :: Raw : $raw : Celsius ${celsius.toStringAsFixed(2)}';
}

/// A local support implementation of the UPM temperature sensor
/// we can use for the Grove temperature sensor
class MraaUpmTemperature {
  MraaUpmTemperature(this._mraa, this._context);

  /// The initialised MRAA library
  Mraa _mraa;

  /// The initialised device context
  ffi.Pointer<MraaAioContext> _context;

  /// Get the raw and Celsius temperature values and timestamp them.
  MraaUpmTemperatureValues getValues() {
    // Get the ADC value range for temperature conversion
    final int maxAdc = 1 << _mraa.aio.getBit(_context);
    final MraaUpmTemperatureValues values = MraaUpmTemperatureValues();
    values.raw = _mraa.aio.read(_context);
    final double r = (maxAdc - values.raw) * 10000.0 / values.raw;
    values.celsius = 1.0 / (log(r / 10000.0) / 3975.0 + 1.0 / 298.15) - 273.15;
    values.validAt = DateTime.now();
    return values;
  }
}
