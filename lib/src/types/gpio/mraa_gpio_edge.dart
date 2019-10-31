/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO Edge types for interrupts.
enum MraaGpioEdge {
  /// No interrupt on Gpio
  none,

  /// Interrupt on rising & falling
  both,

  /// Interrupt on rising only
  rising,

  /// Interrupt on falling only
  falling
}

/// GPIO edge type support
const Map<int, MraaGpioEdge> _gpioEdgeValues = <int, MraaGpioEdge>{
  0: MraaGpioEdge.none,
  1: MraaGpioEdge.both,
  2: MraaGpioEdge.rising,
  3: MraaGpioEdge.falling
};

/// GPIO edge types helper
MraaEnumHelper<MraaGpioEdge> gpioEdge =
    MraaEnumHelper<MraaGpioEdge>(_gpioEdgeValues);
