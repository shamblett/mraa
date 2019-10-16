/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO context class for the opaque mraa_gpio_context structure
class MraaGpioContext extends ffi.Struct<MraaGpioContext> {
  /// Construction
  factory MraaGpioContext.allocate() =>
      ffi.Pointer<MraaGpioContext>.allocate().load<MraaGpioContext>();
}
