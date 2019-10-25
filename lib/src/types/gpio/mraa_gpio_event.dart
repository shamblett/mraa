/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO event class
class MraaGpioEvent extends ffi.Struct {
  /// Construction
  factory MraaGpioEvent.allocate(int id, int timestamp) =>
      ffi.Pointer<MraaGpioEvent>.allocate().load<MraaGpioEvent>()
        ..id = id
        ..timestamp = timestamp;

  @ffi.Int32()

  /// Id
  int id;

  @ffi.Int64()

  /// Timestamp
  int timestamp;
}
