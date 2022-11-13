/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The SPI MRAA API
///
/// An SPI object in MRAA represents a spidev device. Linux spidev devices
/// are created per SPI bus and every chip select available on that
/// bus has another spidev 'file'.
class MraaSpi {
  /// Construction
  MraaSpi(this._impl, this._noJsonLoading);

  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// Initialise - mraa_spi_init
  ///
  /// Initialise an [MraaSpiContext], uses board mapping. Sets the muxes
  MraaSpiContext initialise(int busId) => _impl.mraa_spi_init(busId);

  /// Initialise raw- mraa_spi_init_raw
  ///
  /// Initialise an [MraaSpiContext] without any board configuration,
  /// selects a bus and a mux.
  MraaSpiContext initialiseRaw(int busId, int cs) =>
      _impl.mraa_spi_init_raw(busId, cs);

  /// Mode - mraa_spi_mode
  ///
  /// Set the SPI device mode. see spidev 0-3.
  MraaReturnCode mode(MraaSpiContext dev, MraaSpiMode mode) =>
      MraaReturnCode.returnCode(_impl.mraa_spi_mode(dev, mode.code));

  /// Frequency - mraa_spi_frequency
  ///
  /// Set the SPI device operating clock frequency in Hz
  MraaReturnCode frequency(MraaSpiContext dev, int hz) =>
      MraaReturnCode.returnCode(_impl.mraa_spi_frequency(dev, hz));

  /// Write - mraa_spi_write
  ///
  /// Write Single Byte to the SPI device.
  /// Returns data received on the miso line or [Mraa.generalError]
  /// in case of error.
  int write(MraaSpiContext dev, int data) => _impl.mraa_spi_write(dev, data);

  /// Write word - mraa_spi_write_word
  ///
  /// Write Two Bytes to the SPI device.
  /// Returns data received on the miso line or [Mraa.generalError]
  /// in case of error.
  int writeWord(MraaSpiContext dev, int data) =>
      _impl.mraa_spi_write_word(dev, data);

  /// Write buffer - mraa_spi_write_buf
  ///
  /// Write Buffer of bytes to the SPI device.
  /// Returns NULL if an error occurs.
  /// Maximum length is 4096
  Uint8List writeBuffer(MraaSpiContext dev, Uint8List data, int length) {
    final ptr = ffi.calloc.allocate<Uint8>(length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final retData = _impl.mraa_spi_write_buf(dev, ptr, length);
    if (retData == nullptr) {
      return Uint8List(0);
    }
    final retDataList = retData.asTypedList(length);
    final ret = Uint8List(length);
    ret.setAll(0, retDataList);
    ffi.calloc.free(retData);
    return ret;
  }

  /// Write buffer word - mraa_spi_write_buf_word
  ///
  /// Write a buffer of words to the SPI device.
  /// Returns NULL if an error occurs.
  /// Maximum length is 4096
  Uint16List writeBufferWord(MraaSpiContext dev, Uint16List data, int length) {
    final ptr = ffi.calloc.allocate<Uint16>(length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, data);
    final retData = _impl.mraa_spi_write_buf_word(dev, ptr, length);
    if (retData == nullptr) {
      return Uint16List(0);
    }
    final retDataList = retData.asTypedList(length);
    final ret = Uint16List(length);
    ret.setAll(0, retDataList);
    ffi.calloc.free(retData);
    return ret;
  }

  /// Transfer buffer - mraa_spi_transfer_buf
  ///
  /// Transfer a buffer of bytes to the SPI device. Both send and receive
  /// buffers are passed in using the [buffer] parameter.
  /// Maximum length 4096 both ways
  MraaReturnCode transferBuffer(
      MraaSpiContext dev, MraaSpiTransferBuffer<Uint8List> buffer, int length) {
    final ptr = ffi.calloc.allocate<Uint8>(length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final retData = ffi.calloc.allocate<Uint8>(length);
    final status = MraaReturnCode.returnCode(
        _impl.mraa_spi_transfer_buf(dev, ptr, retData, length));
    if (status != MraaReturnCode.success) {
      ffi.calloc.free(retData);
      return status;
    }
    if (retData == nullptr) {
      buffer.dataReceived = Uint8List(0);
      ffi.calloc.free(retData);
      return status;
    }
    final retDataList = retData.asTypedList(length);
    buffer.dataReceived = Uint8List(length);
    buffer.dataReceived.setAll(0, retDataList);
    return status;
  }

  /// Transfer buffer word - mraa_spi_transfer_buf_word
  ///
  /// Transfer a buffer of words to the SPI device. Both send and receive
  /// buffers are passed in using the [buffer] parameter.
  /// Maximum length 4096 both ways
  MraaReturnCode transferBufferWord(MraaSpiContext dev,
      MraaSpiTransferBuffer<Uint16List> buffer, int length) {
    final ptr = ffi.calloc.allocate<Uint16>(length);
    final ptrData = ptr.asTypedList(length);
    ptrData.setAll(0, buffer.dataSent);
    final retData = ffi.calloc.allocate<Uint16>(length);
    final status = MraaReturnCode.returnCode(
        _impl.mraa_spi_transfer_buf_word(dev, ptr, retData, length));
    final retDataList = retData.asTypedList(length);
    if (status != MraaReturnCode.success) {
      ffi.calloc.free(retData);
      return status;
    }
    if (retData == nullptr) {
      buffer.dataReceived = Uint16List(0);
      ffi.calloc.free(retData);
      return status;
    }
    buffer.dataReceived = Uint16List(length);
    buffer.dataReceived.setAll(0, retDataList);
    return status;
  }

  /// Lsb mode - mraa_spi_lsbmode
  ///
  /// Change the SPI LSB mode
  /// [lsb] set to true indicates use the least significant bit transmission
  MraaReturnCode lsbMode(MraaSpiContext dev, bool lsb) {
    final mode = lsb ? 1 : 0;
    return MraaReturnCode.returnCode(_impl.mraa_spi_lsbmode(dev, mode));
  }

  /// Bits per word - mraa_spi_bit_per_word
  ///
  /// Set bits per word for transactions, defaults at 8
  MraaReturnCode bitsPerWord(MraaSpiContext dev, int bits) =>
      MraaReturnCode.returnCode(_impl.mraa_spi_bit_per_word(dev, bits));

  /// Stop - mraa_spi_stop
  ///
  /// De-inits an [MraaSpiContext] device
  MraaReturnCode stop(MraaSpiContext dev) =>
      MraaReturnCode.returnCode(_impl.mraa_spi_stop(dev));
}
