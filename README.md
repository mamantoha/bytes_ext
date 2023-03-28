# Byte Conversion Library for Crystal

This library provides methods for converting numeric types (`Int32`, `Int64`, `Float32`, and `Float64`) to and from byte arrays in Crystal programming language. The methods support both little-endian and big-endian byte orders.

Everything in this repository, including the code, tests, and README has been created by ChatGPT-4 with some guidance.

## Features

- `to_bytes`, `to_le_bytes`, and `to_be_bytes` methods for converting numbers to byte arrays
- `from_bytes`, `from_le_bytes`, and `from_be_bytes` methods for creating numbers from byte arrays

## Installation

Add this to your application's shard.yml:

```yaml
dependencies:
  bytes_ext:
    github: mamantoha/bytes_ext
```

## Usage

```crystal
require "bytes_ext"

# Convert an Int32 to its byte representation
i32 = 0x12345678_i32
bytes = i32.to_le_bytes
# => Bytes[0x78, 0x56, 0x34, 0x12]

# Convert a byte array to an Int32
new_i32 = Int32.from_le_bytes(bytes)
# => 0x12345678_i32

# Convert an Int64 to its byte representation
i64 = 1234_i64
bytes = i64.to_le_bytes
# => Bytes[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]

# Convert a byte array to an Int64
new_i64 = Int64.from_le_bytes(bytes)
# => 1234_i64

# Convert a Float32 to its byte representation
f32 = 12.5f32
bytes = f32.to_le_bytes
# => Bytes[0x00, 0x00, 0x48, 0x41]

# Convert a byte array to a Float32
new_f32 = Float32.from_le_bytes(bytes)
# => 12.5f32

# Convert a Float64 to its byte representation
f64 = 12.5
bytes = f64.to_le_bytes
# => Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x40]

# Convert a byte array to a Float64
new_f64 = Float64.from_le_bytes(bytes)
# => 12.5
```

## Contributing

1. Fork it (https://github.com/mamantoha/bytes_ext/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## License

Copyright: 2023 Anton Maminov (anton.maminov@gmail.com)

This library is distributed under the MIT license. Please see the LICENSE file.
