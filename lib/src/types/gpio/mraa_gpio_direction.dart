/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO pin directions
enum MraaGpioDirection {
  /// Out
  mraaGpioOut,

  /// In
  mraaGpioIn,

  /// Out high
  mraaGpioOutHigh,

  /// Out Low
  mraaGpioOutLow
}

/// GPIO direction type support
const Map<int, MraaGpioDirection> _gpioDirectionValues =
    <int, MraaGpioDirection>{
  0: MraaGpioDirection.mraaGpioOut,
  1: MraaGpioDirection.mraaGpioIn,
  2: MraaGpioDirection.mraaGpioOutHigh,
  3: MraaGpioDirection.mraaGpioOutLow
};

/// GPIO direction types helper
MraaEnumHelper<MraaGpioDirection> gpioDirections =
    MraaEnumHelper<MraaGpioDirection>(_gpioDirectionValues);
