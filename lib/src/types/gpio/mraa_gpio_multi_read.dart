/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The values of a range of GPIO pins read in a multi read operation.
class MraaGpioMultiRead {
  /// Pin values
  List<int> values =[];

  /// Length
  int get length => values.length;
}
