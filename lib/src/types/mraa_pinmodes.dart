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
  mraaPinSpi,

  /// I2C
  mraaPinI2c,

  /// Analog in
  mraaPinAio,

  /// UART
  mraaPinUart
}

/// Pinmodes type support
const Map<int,MraaPinmodes> _pinModesValues = <int,MraaPinmodes>{
  0:MraaPinmodes.mraaPinValid,
  1:MraaPinmodes.mraaPinGpio,
  2:MraaPinmodes.mraaPinPwm,
  3:MraaPinmodes.mraaPinFastGpio,
  4:MraaPinmodes.mraaPinSpi,
  5:MraaPinmodes.mraaPinI2c,
  6:MraaPinmodes.mraaPinAio,
  7:MraaPinmodes.mraaPinUart
};

/// Pinmodes types helper
MraaEnumHelper<MraaPinmodes> pinmodes =
    MraaEnumHelper<MraaPinmodes>(_pinModesValues);
