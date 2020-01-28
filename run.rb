require 'ffi'

module SwiftFFILib
  extend FFI::Library
  # Two possible extensions, .so for Linux, .dylib for macOS
  ffi_lib ['.build/debug/libswift-ffi.dylib', '.build/debug/libswift-ffi.so']

  attach_function :swift_ffi_print, [:string], :void
  attach_function :swift_ffi_values_multiply, [:int, :int], :int
  # attach with a temporary name - wrapped below  
  attach_function :unsafe_swift_ffi_duplicate_string, :swift_ffi_duplicate_string, [:string], :strptr

  # the wrapped version of the C function 
  def self.swift_ffi_duplicate_string(string)
    # get the string with a pointer
    result, ptr = unsafe_swift_ffi_duplicate_string(string)
    # create a managed copy
    result = String.new(result)
    # free the pointer
    free(ptr)
    result
  end
  
  ffi_lib FFI::Library::LIBC

  attach_function :free, [:pointer], :void
end

string_value = "String Value"

# print using Swift `print(_:)`
STDERR.puts "Calling a func that prints \"#{string_value}\""
SwiftFFILib.swift_ffi_print(string_value)
STDERR.puts

# duplicate a string using the wrapped function
STDERR.puts "Calling a func that duplicates \"#{string_value}\""
duplicated = SwiftFFILib.swift_ffi_duplicate_string(string_value)
STDERR.puts "Duplicated = \"#{duplicated}\""
STDERR.puts

# multiply two integers
multiplied = SwiftFFILib.swift_ffi_values_multiply(2, 3)
STDERR.puts "Calling a func with Int arguments"
STDERR.puts "2 * 3 = #{multiplied}"
