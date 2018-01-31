//
//  Protocol.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/18.
//

import PerfectLib

public protocol MySQLORMTable {
    init(row: MySQLExecute.Row)
    static var table: String {get}
    static func filterColumn(name: String?) -> Bool
}

public extension MySQLORMTable {
    static var table: String {
        return "\(self)".lowercased()
    }
    static func filterColumn(name: String?) -> Bool {
        return name?.hasPrefix("_") == true
    }
}

public extension MySQLORMTable {
    
    static func columns(_ offset: Int = 0) -> [String: Any] {
        var result: [String: Any] = [:]
        let instance = Self(row: MySQLExecute.Row())
        let mirror = Mirror(reflecting: instance)
        mirror.children.enumerated().forEach { (item) in
            if item.offset >= offset && !filterColumn(name: item.element.label) {
                result[item.element.label ?? ""] = item.element.value
            }
        }
        return result
    }
    
    static func firstKey() -> String {
        return Self(row: MySQLExecute.Row()).firstKeyValue().0
    }
    
    
}

public extension MySQLORMTable {
    
    func firstKeyValue() -> (String, Any) {
        let mirror = Mirror(reflecting: self)
        if let first = mirror.children.first {
            return (first.label ?? "", first.value)
        }
        return ("id", "unknown")
    }
    
    func idIsEmpty() -> Bool {
        let first = firstKeyValue()
        if let str = first.1 as? String {
            return str.isEmpty
        }else {
            let number = Number(first.1)
            return number.int == 0
        }
    }
    
    func asDic(_ offset: Int = 0) throws -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        try mirror.children.enumerated().forEach { (item) in
            if item.offset >= offset && !Self.filterColumn(name: item.element.label) {
                if let value = item.element.value as? [String: Any] {
                    do {
                        result[item.element.label ?? ""] = try value.jsonEncodedString()
                    }catch {
                        throw MySQLExecute.Error.throwError(MySQLExecute.Error.jsonConversionError(error), userInfo: ["jsonEncoded": value])
                    }
                    
                }else if let value = item.element.value as? [String] {
                    result[item.element.label ?? ""] = value.joined(separator: ",")
                }else {
                    result[item.element.label ?? ""] = item.element.value
                }
            }
        }
        return result
    }
    
    
}










