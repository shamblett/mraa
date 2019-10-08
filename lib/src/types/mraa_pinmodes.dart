/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The different possible modes for a pin.
enum MraaPinmodes {
  /// Pin Valid
  mraaPinValid,

  /// General Purpose IO
  mraaPinGpio,

  /// Pulse Width Modulation
  mraaPinPwm,

  /// Faster GPIO
  mraaPinFastGpio,

  /// SPI
  MraaPinSpi,

  /// I2C
  mraaPinI2c,

  /// Analog in
  mraaPinAio,

  /// UART
  mraaPinUart
}

/// Pinmodes type support
dynamic _valuesFuncPinmode() => MraaPinmodes.values;

/// Pinmodes types helper
MraaEnumHelper<MraaPinmodes> pinmodes =
    MraaEnumHelper<MraaPinmodes>(_valuesFuncPinmode);
