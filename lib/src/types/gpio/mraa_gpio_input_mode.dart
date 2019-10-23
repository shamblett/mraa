/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO input modes
enum MraaGpioInputMode {
  /// Resistive High
  activeHigh,

  /// Resistive Low
  activeLow
}

/// GPIO input mode type support
const Map<int, MraaGpioInputMode> _gpioInputModeValues =
    <int, MraaGpioInputMode>{
  0: MraaGpioInputMode.activeHigh,
  1: MraaGpioInputMode.activeLow
};

/// GPIO input mode types helper
MraaEnumHelper<MraaGpioInputMode> gpioInputModes =
    MraaEnumHelper<MraaGpioInputMode>(_gpioInputModeValues);
