/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../mraa.dart';

/// The I2C MRAA API
///
/// An I2C context represents a master on an iI2C bus and that context
/// can communicate to multiple I2C slaves by configuring the address.
/// It is considered best practice to make sure the address is correct
/// before doing any calls on I2C, in case another application changed the
/// address on that bus. Multiple instances of the same bus can exist.
class MraaI2c {
  /// Construction
  MraaI2c(this._impl, this._noJsonLoading);

  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// Initialise - mraa_i2c_init
  ///
  /// Initialise an [MraaI2cContext], using board definitions
  /// Returns the initialised [MraaI2cContext] or NULL
  MraaI2cContext initialise(int bus) => _impl.mraa_i2c_init(bus);

  /// Initialise raw - mraa_i2c_init_raw
  ///
  /// Initialise an [MraaI2cContext], using I2C bus to use
  /// i.e. /dev/i2c-2 would be "2"
  /// Returns the initialised [MraaI2cContext] or NULL
  MraaI2cContext initialiseRaw(int bus) => _impl.mraa_i2c_init_raw(bus);

  /// Frequency - mraa_i2c_frequency
  ///
  /// Sets the frequency of the I2C context.
  /// Most platforms do not support this.
  MraaReturnCode frequency(MraaI2cContext context, MraaI2cMode mode) =>
      MraaReturnCode.returnCode(_impl.mraa_i2c_frequency(context, mode.code));

  /// Read - mraa_i2c_read
  ///
  /// Simple bulk read from an I2C context up to length bytes
  /// Returns the length read or [Mraa.generalError]
  int read(MraaI2cContext context, Pointer<Uint8> data, int length) =>
      _impl.mraa_i2c_read(context, data, length);

  /// Read byte = mraa_i2C_read_byte
  ///
  /// Simple read for a single byte from an i2c context
  /// Returns [Mraa.generalError] on failure
  int readByte(MraaI2cContext context) => _impl.mraa_i2c_read_byte(context);

  /// Read byte data - mraa_i2c_read_byte_data
  ///
  /// Read a single byte from an I2C context, from the designated register
  /// Returns [Mraa.generalError] on failure
  int readByteData(MraaI2cContext context, int register) =>
      _impl.mraa_i2c_read_byte_data(context, register);

  /// Read word data - mraa_i2c_read_word_data
  ///
  /// Read a single word from an I2C context, from designated register
  /// Returns [Mraa.generalError] on failure
  int readWordData(MraaI2cContext context, int register) =>
      _impl.mraa_i2c_read_word_data(context, register);

  /// Read bytes data - mraa_i2c_read_bytes_data
  ///
  /// Bulk read from an I2C context, starting from the designated register
  /// Returns the length in bytes passed to the function or [Mraa.generalError]
  int readBytesData(
    MraaI2cContext context,
    int command,
    Pointer<Uint8> data,
    int length,
  ) => _impl.mraa_i2c_read_bytes_data(context, command, data, length);

  /// Write - mraa_i2c_write
  ///
  /// Write length bytes to the bus, the first byte in the array is the command/register to write.
  MraaReturnCode write(
    MraaI2cContext context,
    Pointer<Uint8> data,
    int length,
  ) => MraaReturnCode.returnCode(_impl.mraa_i2c_write(context, data, length));

  /// Write byte - mraa_i2c_write_byte
  ///
  /// Write a single byte to an I2C context
  MraaReturnCode writeByte(MraaI2cContext context, int data) =>
      MraaReturnCode.returnCode(_impl.mraa_i2c_write_byte(context, data));

  /// Write byte data - mraa_write_byte_data
  ///
  /// Write a single byte to an i2c context
  MraaReturnCode writeByteData(MraaI2cContext context, int data, int command) =>
      MraaReturnCode.returnCode(
        _impl.mraa_i2c_write_byte_data(context, data, command),
      );

  /// Write word data - mraa_write_byte_data
  ///
  /// Write a single word to an I2C context
  MraaReturnCode writeWordData(MraaI2cContext context, int data, int command) =>
      MraaReturnCode.returnCode(
        _impl.mraa_i2c_write_byte_data(context, data, command),
      );

  /// Address - mraa_i2c_address
  ///
  /// Sets the I2C slave address.
  MraaReturnCode address(MraaI2cContext context, int address) =>
      MraaReturnCode.returnCode(_impl.mraa_i2c_address(context, address));

  /// Stop - mraa_i2c_stop
  ///
  /// De-inits an [MraaI2cContext]
  MraaReturnCode stop(MraaI2cContext context) =>
      MraaReturnCode.returnCode(_impl.mraa_i2c_stop(context));
}
