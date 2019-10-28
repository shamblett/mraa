/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// A send/receive transfer buffer.
/// Normally uses Uint8List(byte) or Uint16List(Word) transfers
class MraaSpiTransferBuffer<T> {
  /// Data sent to the device
  T dataSent;

  /// Data received from the device
  T dataReceived;
}
