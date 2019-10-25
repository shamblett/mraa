/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// I2C context class for the opaque mraa_i2c_context structure
class MraaI2cContext extends ffi.Struct {
  /// Construction
  factory MraaI2cContext.allocate() =>
      ffi.Pointer<MraaI2cContext>.allocate().load<MraaI2cContext>();
}
