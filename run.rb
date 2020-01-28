require 'ffi'

module SwiftFFILib
  extend FFI::Library
  ffi_lib ['.build/debug/libswift-ffi.dylib', '.build/debug/libswift-ffi.so']

  attach_function :swift_ffi_print, [:string], :void
  attach_function :swift_ffi_values_multiply, [:int, :int], :int
  attach_function :unsafe_swift_ffi_duplicate_string, :swift_ffi_duplicate_string, [:string], :strptr

  def self.swift_ffi_duplicate_string(string) 
    result, ptr = unsafe_swift_ffi_duplicate_string(string)
    result = String.new(result)
    free(ptr)
    result
  end
  
  ffi_lib FFI::Library::LIBC

  attach_function :free, [:pointer], :void
end

string_value = "String Value"
STDERR.puts "Calling a func that prints \"#{string_value}\""
SwiftFFILib.swift_ffi_print(string_value)
STDERR.puts "Calling a func that duplicates \"#{string_value}\""
duplicated = SwiftFFILib.swift_ffi_duplicate_string(string_value)
STDERR.puts "Duplicated = \"#{duplicated}\""
multiplied = SwiftFFILib.swift_ffi_values_multiply(2, 3)
STDERR.puts "Calling a func with Int arguments"
STDERR.puts "2 * 3 = #{multiplied}"
