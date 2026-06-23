# bytes_ext

[![Crystal CI](https://github.com/mamantoha/bytes_ext/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/bytes_ext/actions/workflows/crystal.yml)
[![GitHub release](https://img.shields.io/github/release/mamantoha/bytes_ext.svg)](https://github.com/mamantoha/bytes_ext/releases)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://mamantoha.github.io/bytes_ext/)
[![License](https://img.shields.io/github/license/mamantoha/bytes_ext.svg)](https://github.com/mamantoha/bytes_ext/blob/master/LICENSE)

Byte conversion helpers for Crystal numeric types.

`bytes_ext` adds Rust-style byte conversion methods to integers and floats, making it easy to convert values to and from little-endian, big-endian, and native-endian byte arrays.

## Installation

Add the shard to your application's `shard.yml`:

```yaml
dependencies:
  bytes_ext:
    github: mamantoha/bytes_ext
```

Then require it:

```crystal
require "bytes_ext"
```

## API

The following methods are added to supported numeric types:

```crystal
value.to_le_bytes
value.to_be_bytes
value.to_ne_bytes
value.to_bytes
```

The following class methods parse bytes back into values:

```crystal
Int32.from_le_bytes(bytes)
Int32.from_be_bytes(bytes)
Int32.from_ne_bytes(bytes)
Int32.from_bytes(bytes)
```

`to_ne_bytes` and `from_ne_bytes` use native-endian byte order. `to_bytes` and `from_bytes` are native-endian by default, and also accept an explicit `IO::ByteFormat`.

## Supported Types

- `Int8`, `Int16`, `Int32`, `Int64`, `Int128`
- `UInt8`, `UInt16`, `UInt32`, `UInt64`, `UInt128`
- `Float32`, `Float64`

## Examples

### Little Endian

```crystal
i32 = 0x12345678_i32
bytes = i32.to_le_bytes
# => Bytes[0x78, 0x56, 0x34, 0x12]

Int32.from_le_bytes(bytes)
# => 0x12345678_i32
```

### Big Endian

```crystal
i32 = 0x12345678_i32
bytes = i32.to_be_bytes
# => Bytes[0x12, 0x34, 0x56, 0x78]

Int32.from_be_bytes(bytes)
# => 0x12345678_i32
```

### Native Endian

```crystal
i32 = 0x12345678_i32
bytes = i32.to_ne_bytes

Int32.from_ne_bytes(bytes)
# => 0x12345678_i32
```

### Explicit Byte Format

```crystal
i32 = 0x12345678_i32
bytes = i32.to_bytes(IO::ByteFormat::BigEndian)
# => Bytes[0x12, 0x34, 0x56, 0x78]

Int32.from_bytes(bytes, IO::ByteFormat::BigEndian)
# => 0x12345678_i32
```

### Floats

```crystal
f32 = 12.5_f32
bytes = f32.to_le_bytes
# => Bytes[0x00, 0x00, 0x48, 0x41]

Float32.from_le_bytes(bytes)
# => 12.5_f32
```

## Development

Run the test suite with:

```sh
crystal spec
```

## Contributing

1. Fork the repository.
2. Create a feature branch.
3. Make your changes with focused tests.
4. Open a pull request.

## License

This shard is available under the MIT license. See [LICENSE](LICENSE).
