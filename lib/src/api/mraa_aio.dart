/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The AIO MRAA API
///
/// AIO is the analogue input & output interface to MRAA
/// It is used to read or set the voltage applied to an AIO pin.
class MraaAio {
  /// Construction
  MraaAio(this._impl, this._noJsonLoading, this._useGrovePi) {
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  final bool _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  /// Initialise - mraa_aio_init
  ///
  /// Initialise an analogue input device connected to the specified pin.
  /// AIO pins are always 0 indexed regardless of their position.
  /// Check your board mapping for details.
  MraaAioContext initialise(int pin) =>
      _impl.mraa_aio_init(pin + _grovePiPinOffset);

  /// Read - mraa_aio_read_float
  ///
  /// Read the input voltage and return it as a normalized double (0.0 - 1.0).
  /// Returns The current input voltage or [Mraa.aioReadDoubleError] on error.
  double readDouble(MraaAioContext dev) => _impl.mraa_aio_read_float(dev);

  /// Read - mraa_aio_read
  ///
  /// Read the input voltage. By default MRAA will shift the raw value
  /// up or down to a 10 bit value.
  /// Returns the current input voltage or [Mraa.aioReadError] for error
  int read(MraaAioContext dev) => _impl.mraa_aio_read(dev);

  /// Close - mraa_aio_close
  ///
  /// Close the analogue input context, this will free the
  /// memory for the context.
  MraaReturnCode close(MraaAioContext dev) =>
      returnCode.fromInt(_impl.mraa_aio_close(dev));

  /// Set bit - mraa_aio_set_bit
  ///
  /// Set the bit value which MRAA will shift the raw reading
  /// from the ADC to, i.e. 10bits
  MraaReturnCode setBit(MraaAioContext dev, int bits) =>
      returnCode.fromInt(_impl.mraa_aio_set_bit(dev, bits));

  /// Set bit - mraa_aio_get_bit
  ///
  /// Gets the bit value mraa is shifting the analogue read to.
  int getBit(MraaAioContext dev) => _impl.mraa_aio_get_bit(dev);
}
