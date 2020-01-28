# swift-ffi
[![Travis (.org)](https://img.shields.io/travis/igor-makarov/swift-ffi?style=flat-square)](https://travis-ci.com/igor-makarov/swift-ffi)

Shows how to use Swift code in a Ruby FFI.

See [swift_ffi.swift](Sources/swift-ffi/swift_ffi.swift) for the Swift code and [run.rb](run.rb) for the Ruby code.

The Swift code is exported as free functions using `@_cdecl` attribute. It's a little undocumented, but will probably be canonized at some point.  

### Note:
The string function `swift_ffi_duplicate_string` returns a 'fresh' string, which means the dealloc is the responsibility of the Ruby code in this case. The Ruby code copies and frees the string before exposing it.  Different C API design might have different constraints.
