/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO output modes
enum MraaGpioOutputMode {
  /// Default. Strong high and low
  strong,

  /// Resistive High
  pullup,

  /// Resistive High
  pulldown,

  /// High Z State
  hiz
}

/// GPIO output mode type support
const Map<int, MraaGpioOutputMode> _gpioOutputModeValues =
    <int, MraaGpioOutputMode>{
  0: MraaGpioOutputMode.strong,
  1: MraaGpioOutputMode.pullup,
  2: MraaGpioOutputMode.pulldown,
  3: MraaGpioOutputMode.hiz
};

/// GPIO output mode types helper
MraaEnumHelper<MraaGpioOutputMode> gpioOutputModes =
    MraaEnumHelper<MraaGpioOutputMode>(_gpioOutputModeValues);
