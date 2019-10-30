/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The different possible modes for a pin.
enum MraaPinmode {
  /// Pin Valid
  valid,

  /// General Purpose IO
  gpio,

  /// Pulse Width Modulation
  pwm,

  /// Faster GPIO
  fastGpio,

  /// SPI
  spi,

  /// I2C
  i2c,

  /// Analog in
  aio,

  /// UART
  uart
}

/// Pinmodes type support
const Map<int, MraaPinmode> _pinModesValues = <int, MraaPinmode>{
  0: MraaPinmode.valid,
  1: MraaPinmode.gpio,
  2: MraaPinmode.pwm,
  3: MraaPinmode.fastGpio,
  4: MraaPinmode.spi,
  5: MraaPinmode.i2c,
  6: MraaPinmode.aio,
  7: MraaPinmode.uart
};

/// Pinmodes types helper
MraaEnumHelper<MraaPinmode> pinmode =
    MraaEnumHelper<MraaPinmode>(_pinModesValues);
