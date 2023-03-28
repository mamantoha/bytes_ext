{% for type in %w(UInt32 UInt64) %}
  struct {{type.id}}
    def to_bytes(endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : Bytes
      # Calculate the number of bytes based on the size of the type
      num_bytes = sizeof({{type.id}})

      # Create a new empty array with the appropriate number of bytes
      byte_array = Bytes.new(num_bytes)

      # Check if the system's byte order is the same as the desired endianness
      if (endian == IO::ByteFormat::LittleEndian) == (IO::ByteFormat::SystemEndian == IO::ByteFormat::LittleEndian)
        # The system's byte order matches the desired endianness
        # Write the value to the byte array using a pointer
        pointer = Pointer({{type.id}}).new(byte_array.to_unsafe.address)
        pointer.value = self
      else
        # The system's byte order is different from the desired endianness
        # Write the value to the byte array byte-by-byte, reversing the order
        num_bytes.times do |i|
          byte_array[num_bytes - 1 - i] = ((self >> (i * 8)) & 0xFF).to_u8
        end
      end

      byte_array
    end
  end
{% end %}

macro bytes_ext_impl(
  type,
  unsigned_type,
  # There are all for use *only* in doc comments.
  swap_op,
  le_bytes,
  be_bytes
)
  struct {{type.id}}
    # Raw transmutation from `UInt32`.
    def self.from_bits(v : UInt32) : {{type.id}}
      # Convert the `UInt32` value to `{{type.id}}` with the same bit representation
      v.unsafe_as({{type.id}})
    end

    # Raw transmutation to `UInt32`.
    def to_bits : {{unsigned_type.id}}
      # Convert the value to `UInt32` with the same bit representation
      self.unsafe_as({{unsigned_type.id}})
    end

    # Return the memory representation of this floating point number as a byte array
    def to_bytes(endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : Bytes
      to_bits.to_bytes(endian)
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
    # # => {{swap_op.id}}
    # ```
    def self.from_le_bytes(bytes : Bytes, endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : {{type.id}}
      self.from_bytes(bytes, IO::ByteFormat::LittleEndian)
    end

    # Create a `{{type.id}}` value from its representation as a byte array in big endian.
    #
    # ```
    # bytes = Bytes{{be_bytes.id}}
    # # => {{swap_op.id}}
    # ```
    def self.from_be_bytes(bytes : Bytes, endian : IO::ByteFormat = IO::ByteFormat::SystemEndian) : {{type.id}}
      self.from_bytes(bytes, IO::ByteFormat::BigEndian)
    end
  end
end

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
