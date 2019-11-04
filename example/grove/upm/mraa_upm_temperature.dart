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
  /// Construction
  MraaUpmTemperatureValues() {
    validAt = DateTime.now();
  }

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

  /// Scaling factor for raw analog value from the ADC, useful for mixed 3.3V/5V boards, default 1.0
  static const double scale = 1.0;

  /// Zero power resistance, this is 100K (default) for v1.1-v1.2 and 10K for v1.0 of the sensor
  static const int r0 = 100000;

  /// Thermistor nominal B constant, this is 4275 (default) for v1.1-v1.2 and 3975 for v1.0 of the sensor
  static const int b = 4275;

  /// The initialised MRAA library
  Mraa _mraa;

  /// The initialised device context
  ffi.Pointer<MraaAioContext> _context;

  /// Get the raw and Celsius temperature values and timestamp them.
  MraaUpmTemperatureValues getValues() {
    final int raw = _mraa.aio.read(_context);
    return calculateCelsius(raw);
  }

  MraaUpmTemperatureValues calculateCelsius(int rawValue) {
    final MraaUpmTemperatureValues values = MraaUpmTemperatureValues();
    if (rawValue == Mraa.generalError) {
      values.celsius = -1.0;
      values.raw = -1;
      return values;
    }
    values.raw = rawValue;
    final double r = (1023.0 - values.raw) * (r0 / values.raw);
    values.celsius = 1.0 / (log(r / r0) / b + 1.0 / 298.15) - 273.15;
    return values;
  }
}
