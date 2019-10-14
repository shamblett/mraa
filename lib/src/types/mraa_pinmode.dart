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
  mraaPinValid,

  /// General Purpose IO
  mraaPinGpio,

  /// Pulse Width Modulation
  mraaPinPwm,

  /// Faster GPIO
  mraaPinFastGpio,

  /// SPI
  mraaPinSpi,

  /// I2C
  mraaPinI2c,

  /// Analog in
  mraaPinAio,

  /// UART
  mraaPinUart
}

/// Pinmodes type support
const Map<int, MraaPinmode> _pinModesValues = <int, MraaPinmode>{
  0: MraaPinmode.mraaPinValid,
  1: MraaPinmode.mraaPinGpio,
  2: MraaPinmode.mraaPinPwm,
  3: MraaPinmode.mraaPinFastGpio,
  4: MraaPinmode.mraaPinSpi,
  5: MraaPinmode.mraaPinI2c,
  6: MraaPinmode.mraaPinAio,
  7: MraaPinmode.mraaPinUart
};

/// Pinmodes types helper
MraaEnumHelper<MraaPinmode> pinmode =
    MraaEnumHelper<MraaPinmode>(_pinModesValues);
