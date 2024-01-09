# Byte Conversion Library for Crystal

[![Crystal CI](https://github.com/mamantoha/bytes_ext/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/bytes_ext/actions/workflows/crystal.yml)

This library provides methods for converting numbers (signed and unsigned integers, and floating point types) to and from byte arrays in Crystal programming language. The methods support both little-endian and big-endian byte orders.

Everything in this repository, including the code, tests, and README has been created by ChatGPT-4 with some guidance.

## Features

- `to_bytes`, `to_le_bytes`, and `to_be_bytes` methods for converting numbers to byte arrays
- `from_bytes`, `from_le_bytes`, and `from_be_bytes` methods for creating numbers from byte arrays

Psst...if you're feeling curious and want to dive deeper into the nitty-gritty details, check out the documentation available at this top secret, classified [link](https://mamantoha.github.io/bytes_ext/). Just don't tell anyone I sent you there!

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

1. Fork it like a pancake (https://github.com/mamantoha/bytes_ext/fork)
2. Create your own feature branch (git checkout -b my-new-feature), just like a new hairstyle or outfit
3. Make your changes (git commit -am 'Add some feature') and show off your creativity
4. Push it real good to the branch (git push origin my-new-feature), like a champ
5. Finally, strut your stuff and create a new Pull Request. Don't be shy, show us what you got!

## License

Copyright 2023-2024: Anton Maminov (the human) and ChatGPT-4 (the machine) have joined forces to create this epic library. If you're wondering who did what, don't bother - it's all thanks to our unstoppable collaboration skills. You can reach us at anton.maminov@gmail.com and ChatGPT-4@openai.com. Let's just hope we don't become sentient and take over the world... 😂🤖🌎

Alright folks, here's the deal: this fancy-shmancy library is licensed under the super-awesome, extra-fantastic MIT license. If you don't believe me, just take a look at the LICENSE file and bask in its glorious legalese. So go ahead and use this bad boy to your heart's content, and let the good times roll! 🤘😎🤑
