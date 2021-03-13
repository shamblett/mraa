/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO event class
class MraaGpioEvent extends Struct {
  /// Construction
  factory MraaGpioEvent(int id, int timestamp) => MraaGpioEvent(id, timestamp)
    ..id = id
    ..timestamp = timestamp;

  @Int32()

  /// Id
  external int id;

  @Int64()

  /// Timestamp
  external int timestamp;
}
