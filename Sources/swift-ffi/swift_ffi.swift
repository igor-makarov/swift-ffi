import Foundation

@_cdecl("swift_ffi_print")
public func FFIPrint(_ cString: UnsafePointer<CChar>) {
    let converted = String(cString: cString)
    print("Swift print: \"\(converted)\"")
}

@_cdecl("swift_ffi_values_multiply") 
public func FFIValuesMultiply(_ argument1: Int, _ argument2: Int) -> Int{
    argument1 * argument2
}

@_cdecl("swift_ffi_duplicate_string")
public func FFIDuplicate(_ cString: UnsafePointer<CChar>) -> UnsafePointer<CChar> {
    let converted = String(cString: cString)
    let duplicated = converted + " " + converted
    return UnsafePointer(strdup(duplicated))
}
