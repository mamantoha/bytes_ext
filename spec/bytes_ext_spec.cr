require "./spec_helper"

describe Int32 do
  describe "#to_bytes" do
    it { 0x12345678i32.to_bytes.should eq(Bytes[0x78, 0x56, 0x34, 0x12]) }
  end

  describe ".from_bytes" do
    it { Int32.from_bytes(Bytes[0x78, 0x56, 0x34, 0x12]).should eq(0x12345678i32) }
  end

  describe ".from_le_bytes" do
    it { Int32.from_le_bytes(Bytes[0x78, 0x56, 0x34, 0x12]).should eq(0x12345678i32) }
  end

  describe ".from_be_bytes" do
    it { Int32.from_be_bytes(Bytes[0x12, 0x34, 0x56, 0x78]).should eq(0x12345678i32) }
  end
end

describe Int64 do
  describe "#to_bytes" do
    it { (1234_i64).to_bytes.should eq(Bytes[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) }
  end

  describe "#to_le_bytes" do
    it { (1234_i64).to_le_bytes.should eq(Bytes[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) }
  end

  describe "#to_be_bytes" do
    it { (1234_i64).to_be_bytes.should eq(Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2]) }
  end

  describe ".from_bytes" do
    it { Int64.from_bytes(Bytes[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).should eq(1234_i64) }
  end

  describe ".from_le_bytes" do
    it { Int64.from_le_bytes(Bytes[0xD2, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).should eq(1234_i64) }
  end

  describe ".from_be_bytes" do
    it { Int64.from_be_bytes(Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xD2]).should eq(1234_i64) }
  end
end

describe Float32 do
  describe "#to_bytes" do
    it { 12.5f32.to_bytes.should eq(Bytes[0x00, 0x00, 0x48, 0x41]) }
  end

  describe ".from_bytes" do
    it { Float32.from_bytes(Bytes[0x00, 0x00, 0x48, 0x41]).should eq(12.5f32) }
  end

  describe ".from_le_bytes" do
    it { Float32.from_le_bytes(Bytes[0x00, 0x00, 0x48, 0x41]).should eq(12.5f32) }
  end

  describe ".from_be_bytes" do
    it { Float32.from_be_bytes(Bytes[0x41, 0x48, 0x00, 0x00]).should eq(12.5f32) }
  end
end

describe Float64 do
  describe "#to_bytes" do
    it { 12.5.to_bytes.should eq(Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x40]) }
  end

  describe ".from_bytes" do
    it { Float64.from_bytes(Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x40]).should eq(12.5) }
  end

  describe ".from_le_bytes" do
    it { Float64.from_le_bytes(Bytes[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x40]).should eq(12.5) }
  end

  describe ".from_be_bytes" do
    it { Float64.from_be_bytes(Bytes[0x40, 0x29, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]).should eq(12.5) }
  end
end