import Foundation

// prints the provided C String
@_cdecl("swift_ffi_print")
public func FFIPrint(_ cString: UnsafePointer<CChar>) {
    // Convert from C String to Swift string
    let converted = String(cString: cString)
    print("Swift print: \"\(converted)\"")
}

// multiplies two integers
@_cdecl("swift_ffi_values_multiply") 
public func FFIValuesMultiply(_ argument1: Int, _ argument2: Int) -> Int{
    argument1 * argument2
}

// duplicates the provided C String
// returns a 'fresh' string (API consumer is responsible to free it)
@_cdecl("swift_ffi_duplicate_string")
public func FFIDuplicate(_ cString: UnsafePointer<CChar>) -> UnsafePointer<CChar> {
    // Convert from C String to Swift string
    let converted = String(cString: cString)
    let duplicated = converted + " " + converted
    // use libc `strdup` to return a retained C String
    // freeing the string is the responsiblity of the API consumer
    return UnsafePointer(strdup(duplicated))
}
