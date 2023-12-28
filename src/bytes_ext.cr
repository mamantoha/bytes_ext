macro bytes_ext_impl(
  type,
  unsigned_type,
  # There are all for use *only* in doc comments.
  swap_op,
  le_bytes,
  be_bytes
)
  struct {{type.id}}
    # Return the memory representation of this number as a byte array
    def to_bytes(endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : Bytes
      io = IO::Memory.new
      io.write_bytes(self, endian)
      io.rewind
      io.getb_to_end
    end

    # Return the memory representation of this number as a byte array in little-endian byte order.
    #
    # ```
    # bytes = {{swap_op.id}}.to_le_bytes
    # # => Bytes{{le_bytes.id}}
    # ```
    def to_le_bytes  : Bytes
      to_bytes(IO::ByteFormat::LittleEndian)
    end

    # Return the memory representation of this number as a byte array in big-endian (network) byte order.
    #
    # ```
    # bytes = {{swap_op}}.to_be_bytes
    # # => Bytes{{be_bytes.id}}
    # ```
    def to_be_bytes  : Bytes
      to_bytes(IO::ByteFormat::BigEndian)
    end

    def to_ne_bytes : Bytes
      to_bytes(IO::ByteFormat::SystemEndian)
    end

    # Create a `{{type.id}}` value from its representation as a byte array.
    def self.from_bytes(bytes : Bytes, endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : {{type.id}}
      raise ArgumentError.new("Expected exactly #{sizeof({{type}})} bytes") unless bytes.size == sizeof({{type}})

      memory_io = IO::Memory.new(bytes)
      {{type.id}}.from_io(memory_io, endian)
    end

    # Create a `{{type.id}}` value from its representation as a byte array in little endian.
    #
    # ```
    # bytes = Bytes{{le_bytes.id}}
    # {{type.id}}.from_le_bytes(bytes)
    # # => {{swap_op.id}}
    # ```
    def self.from_le_bytes(bytes : Bytes) : {{type.id}}
      self.from_bytes(bytes, IO::ByteFormat::LittleEndian)
    end

    # Create a `{{type.id}}` value from its representation as a byte array in big endian.
    #
    # ```
    # bytes = Bytes{{be_bytes.id}}
    # {{type.id}}.from_be_bytes(bytes)
    # # => {{swap_op.id}}
    # ```
    def self.from_be_bytes(bytes : Bytes) : {{type.id}}
      self.from_bytes(bytes, IO::ByteFormat::BigEndian)
    end

    def self.from_ne_bytes(bytes : Bytes) : {{type.id}}
      self.from_bytes(bytes, IO::ByteFormat::SystemEndian)
    end
  end
end

bytes_ext_impl Int8,
  UInt8,
  "0x12i8",
  "[0x12]",
  "[0x78]"

bytes_ext_impl Int16,
  UInt16,
  "0x1234i16",
  "[0x34, 0x12]",
  "[0x12, 0x34]"

bytes_ext_impl Int32,
  UInt32,
  "0x12345678i32",
  "[0x12, 0x34, 0x56, 0x78]",
  "[0x78, 0x56, 0x34, 0x12]"

bytes_ext_impl Int64,
  UInt64,
  "1234_i64",
  "[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]",
  "[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2]"

bytes_ext_impl Int128,
  UInt128,
  "0x12345678901234567890123456789012_i128",
  "[0x12, 0x90, 0x78, 0x56, 0x34, 0x12, 0x90, 0x78, 0x56, 0x34, 0x12, 0x90, 0x78, 0x56, 0x34, 0x12]",
  "[0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56, 0x78, 0x90, 0x12]"

bytes_ext_impl Float32,
  UInt32,
  "12.5f32",
  "[0x00, 0x00, 0x48, 0x41]",
  "[0x41, 0x48, 0x00, 0x00]"

bytes_ext_impl Float64,
  UInt64,
  "12.5",
  "[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x40]",
  "[0x40, 0x29, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]"

bytes_ext_impl UInt8,
  UInt8,
  "0x12u8",
  "[0x12]",
  "[0x12]"

bytes_ext_impl UInt16,
  UInt16,
  "0x1234u16",
  "[0x34, 0x12]",
  "[0x12, 0x34]"

bytes_ext_impl UInt32,
  UInt32,
  "12345678_u32",
  "[0x78, 0x56, 0x34, 0x12]",
  "[0x12, 0x34, 0x56, 0x78]"

bytes_ext_impl UInt64,
  UInt64,
  "1234567890123456_u64",
  "[0x56, 0x34, 0x12, 0x90, 0x78, 0x56, 0x34, 0x12]",
  "[0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56]"

bytes_ext_impl UInt128,
  UInt128,
  "0x12345678901234567890123456789012_u128",
  "[0x12, 0x90, 0x78, 0x56, 0x34, 0x12, 0x90, 0x78, 0x56, 0x34, 0x12, 0x90, 0x78, 0x56, 0x34, 0x12]",
  "[0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56, 0x78, 0x90, 0x12, 0x34, 0x56, 0x78, 0x90, 0x12]"
