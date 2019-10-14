/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// I2C speeds/modes
enum MraaI2cMode {
  /// Standard
  std,

  /// Fast
  fast,

  /// High speed
  high
}

/// I2C mode type support
const Map<int, MraaI2cMode> _i2cModeValues = <int, MraaI2cMode>{
  0: MraaI2cMode.std,
  1: MraaI2cMode.fast,
  2: MraaI2cMode.high
};

/// I2C mode types helper
MraaEnumHelper<MraaI2cMode> i2cMode =
    MraaEnumHelper<MraaI2cMode>(_i2cModeValues);
