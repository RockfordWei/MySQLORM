//
//  Number.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/21.
//


public struct Number {
    
    let value: Any?
    let _int: Int?
    let _int8: Int8?
    let _int16: Int16?
    let _int32: Int32?
    let _int64: Int64?
    let _uint: UInt?
    let _uint8: UInt8?
    let _uint16: UInt16?
    let _uint32: UInt32?
    let _uint64: UInt64?
    let _float: Float?
    let _float32: Float32?
    let _float64: Float64?
    let _float80: Float80?
    let _double: Double?
    let _string: String?
    
    public init(_ value: Any?) {
        self.value = value
        _int = value as? Int
        _int8 = value as? Int8
        _int16 = value as? Int16
        _int32 = value as? Int32
        _int64 = value as? Int64
        _uint = value as? UInt
        _uint8 = value as? UInt8
        _uint16 = value as? UInt16
        _uint32 = value as? UInt32
        _uint64 = value as? UInt64
        _float = value as? Float
        _float32 = value as? Float32
        _float64 = value as? Float64
        _float80 = value as? Float80
        _double = value as? Double
        _string = value as? String
    }
    
}

public extension Number {
    var bool: Bool {
        return double != 0
    }
    var int: Int {
        if let i = _int64Value {
            return Int(i)
        }
        if let u = _uint64Value {
            return Int(u)
        }
        if let d = _doubleValue {
            return Int(d)
        }
        return 0
    }
    
    var int8: Int8 {
        if let i = _int64Value {
            return Int8(i)
        }
        if let u = _uint64Value {
            return Int8(u)
        }
        if let d = _doubleValue {
            return Int8(d)
        }
        return 0
    }
    
    var int16: Int16 {
        if let i = _int64Value {
            return Int16(i)
        }
        if let u = _uint64Value {
            return Int16(u)
        }
        if let d = _doubleValue {
            return Int16(d)
        }
        return 0
    }
    
    var int32: Int32 {
        if let i = _int64Value {
            return Int32(i)
        }
        if let u = _uint64Value {
            return Int32(u)
        }
        if let d = _doubleValue {
            return Int32(d)
        }
        return 0
    }
    
    var int64: Int64 {
        if let i = _int64Value {
            return Int64(i)
        }
        if let u = _uint64Value {
            return Int64(u)
        }
        if let d = _doubleValue {
            return Int64(d)
        }
        return 0
    }
    
    var uint: UInt {
        if let i = _int64Value {
            return UInt(i)
        }
        if let u = _uint64Value {
            return UInt(u)
        }
        if let d = _doubleValue {
            return UInt(d)
        }
        return 0
    }
    
    var uint8: UInt8 {
        if let i = _int64Value {
            return UInt8(i)
        }
        if let u = _uint64Value {
            return UInt8(u)
        }
        if let d = _doubleValue {
            return UInt8(d)
        }
        return 0
    }
    
    var uint16: UInt16 {
        if let i = _int64Value {
            return UInt16(i)
        }
        if let u = _uint64Value {
            return UInt16(u)
        }
        if let d = _doubleValue {
            return UInt16(d)
        }
        return 0
    }
    
    var uint32: UInt32 {
        if let i = _int64Value {
            return UInt32(i)
        }
        if let u = _uint64Value {
            return UInt32(u)
        }
        if let d = _doubleValue {
            return UInt32(d)
        }
        return 0
    }
    
    var uint64: UInt64 {
        if let i = _int64Value {
            return UInt64(i)
        }
        if let u = _uint64Value {
            return UInt64(u)
        }
        if let d = _doubleValue {
            return UInt64(d)
        }
        return 0
    }
    
    var float: Float {
        if let i = _int64Value {
            return Float(i)
        }
        if let u = _uint64Value {
            return Float(u)
        }
        if let d = _doubleValue {
            return Float(d)
        }
        return 0
    }
    
    var float32: Float32 {
        if let i = _int64Value {
            return Float32(i)
        }
        if let u = _uint64Value {
            return Float32(u)
        }
        if let d = _doubleValue {
            return Float32(d)
        }
        return 0
    }
    
    var float64: Float64 {
        if let i = _int64Value {
            return Float64(i)
        }
        if let u = _uint64Value {
            return Float64(u)
        }
        if let d = _doubleValue {
            return Float64(d)
        }
        return 0
    }
    
    var float80: Float80 {
        if let i = _int64Value {
            return Float80(i)
        }
        if let u = _uint64Value {
            return Float80(u)
        }
        if let d = _doubleValue {
            return Float80(d)
        }
        return 0
    }
    
    var double: Double {
        if let i = _int64Value {
            return Double(i)
        }
        if let u = _uint64Value {
            return Double(u)
        }
        if let d = _doubleValue {
            return Double(d)
        }
        return 0
    }
    
    
}

extension Number {
    var _int64Value: Int64? {
        if let i = _int {
            return Int64(i)
        }
        if let i = _int8 {
            return Int64(i)
        }
        if let i = _int16 {
            return Int64(i)
        }
        if let i = _int32 {
            return Int64(i)
        }
        return _int64 ?? (_string != nil ? Int64(_string!) : nil)
    }
    
    var _uint64Value: UInt64? {
        if let u = _uint {
            return UInt64(u)
        }
        if let u = _uint8 {
            return UInt64(u)
        }
        if let u = _uint16 {
            return UInt64(u)
        }
        if let u = _uint32 {
            return UInt64(u)
        }
        return _uint64 ?? (_string != nil ? UInt64(_string!) : nil)
    }
    
    var _doubleValue: Double? {
        if let f = _float {
            return Double(f)
        }
        if let f = _float32 {
            return Double(f)
        }
        if let f = _float64 {
            return Double(f)
        }
        if let f = _float80 {
            return Double(f)
        }
        return _double ?? (_string != nil ? Double(_string!) : nil)
    }
}
