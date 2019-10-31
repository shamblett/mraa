/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO pin directions.
enum MraaGpioDirection {
  /// Out
  out,

  /// In
  inn,

  /// Out high
  outHigh,

  /// Out Low
  outLow
}

/// GPIO direction type support
const Map<int, MraaGpioDirection> _gpioDirectionValues =
    <int, MraaGpioDirection>{
  0: MraaGpioDirection.out,
  1: MraaGpioDirection.inn,
  2: MraaGpioDirection.outHigh,
  3: MraaGpioDirection.outLow
};

/// GPIO direction types helper
MraaEnumHelper<MraaGpioDirection> gpioDirections =
    MraaEnumHelper<MraaGpioDirection>(_gpioDirectionValues);
