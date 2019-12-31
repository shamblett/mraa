/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

import 'package:mraa/mraa.dart';

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations
// ignore_for_file: avoid_print

int main() {
  final Mraa mraa = Mraa();

  // Set any options such as no JSON loading here
  // mraa.noJsonLoading = true;

  // Initialise the package, you MUST do this after setting any
  // options if you don't the API calls will throw no such method error.
  mraa.initialise();

  // Call the MRAA API functions
  final String mraaVersion = mraa.common.version();
  print('Version is : $mraaVersion');

  return 0;
}
