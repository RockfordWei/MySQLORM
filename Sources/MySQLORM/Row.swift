//
//  Row.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/20.
//
//

import PerfectLib

public extension MySQLExecute {
    
    public class Row {
        
        public var id: ID = .int(0)
        
        public var data: [String: Any] = [:]
        
        public var idNumber: Number {
            return Number(data["id"])
        }
        
        public init() {
            
        }
        
        public init(_ value: Int) {
            id = ID.int(value)
        }
        
        public init(_ value: String) {
            id = ID.string(value)
        }
        
        public init(_ value: UUID) {
            id = ID.uuid(value)
            
        }
        
        
    }
    
}

extension MySQLExecute {
    
    public enum ID {
        case string(String)
        case int(Int)
        case uuid(UUID)
        
        public var stringValue: String {
            if case .string(let value) = self {
                return value
            }
            return ""
        }
        
        public var intValue: Int {
            if case .int(let value) = self {
                return value
            }
            return 0
        }
        
        public var uuidValue: UUID? {
            if case .uuid(let value) = self {
                return value
            }
            return nil
        }
        
    }
    
}







