/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// UTF8 string class
class Utf8 extends Struct {
  /// Current character
  @Uint8()
  int char;

  /// From
  static String fromUtf8(Pointer<Utf8> ptr) {
    final List<int> units = List<int>();
    int len = 0;
    int char = -1;
    while (char != 0) {
      char = ptr[len++].char;
      units.add(char);
    }
    units.removeLast();
    return const Utf8Decoder().convert(units);
  }

  /// To
  static List<Utf8> toUtf8(String s) {
    final Uint8List units = const Utf8Encoder().convert(s);
    final List<Utf8> utf8List = List<Utf8>();
    for (int i=0; i<units.length; i++) {
      final Utf8 tmp = Utf8();
      tmp.char = units[i];
      utf8List.add(tmp);
    }
    final Utf8 tmp = Utf8();
    tmp.char = 0;
    utf8List.add(tmp);
    return utf8List;
  }
}
