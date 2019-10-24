/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// PWM context class for the opaque mraa_pwm_context structure
class MraaPwmContext extends ffi.Struct<MraaPwmContext> {
  /// Construction
  factory MraaPwmContext.allocate() =>
      ffi.Pointer<MraaPwmContext>.allocate().load<MraaPwmContext>();
}
