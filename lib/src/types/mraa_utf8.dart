/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// UTF8 string class
class Utf8 extends ffi.Struct {
  /// Current character
  @ffi.Uint8()
  int char;

  /// From
  static String fromUtf8(ffi.Pointer<Utf8> ptr) {
    final List<int> units = List<int>();
    int len = 0;
    int char = -1;
    while (char != 0) {
      char = ptr.elementAt(len++).load<Utf8>().char;
      units.add(char);
    }
    units.removeLast();
    return const Utf8Decoder().convert(units);
  }

  /// To
  static ffi.Pointer<Utf8> toUtf8(String s) {
    final Uint8List units = const Utf8Encoder().convert(s);
    final ffi.Pointer<Utf8> ptr =
        ffi.Pointer<Utf8>.allocate(count: units.length + 1);
    for (int i = 0; i < units.length; i++) {
      ptr.elementAt(i).load<Utf8>().char = units[i];
    }
    // Add the C string null terminator '\0'
    ptr.elementAt(units.length).load<Utf8>().char = 0;
    return ptr;
  }
}
