/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO output driver modes.
enum MraaGpioOutputDriverMode {
  /// Open Drain Configuration
  openDrain,

  /// Push Pull Configuration
  pushPull
}

/// GPIO output driver mode type support
const Map<int, MraaGpioOutputDriverMode> _gpioOutputDriverModeValues =
    <int, MraaGpioOutputDriverMode>{
  0: MraaGpioOutputDriverMode.openDrain,
  1: MraaGpioOutputDriverMode.pushPull
};

/// GPIO output driver mode types helper
MraaEnumHelper<MraaGpioOutputDriverMode> gpioOutputDriverModes =
    MraaEnumHelper<MraaGpioOutputDriverMode>(_gpioOutputDriverModeValues);
