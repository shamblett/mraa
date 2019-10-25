/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// LED context class for the opaque mraa_led_context structure
class MraaLedContext extends ffi.Struct {
  /// Construction
  factory MraaLedContext.allocate() =>
      ffi.Pointer<MraaLedContext>.allocate().load<MraaLedContext>();
}
