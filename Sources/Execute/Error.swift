//
//  Error.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/18.
//
//

public extension MySQLExecute {
    
    public struct Error: Swift.Error {
        
        static var willThrow: ((_ error: MySQLExecute.Error, _ userInfo: [String: Any]) -> ())?
        
        public let code: Int
        public let message: String
        
        public init(code: UInt32, message: String) {
            self.code = Int(code)
            self.message = message
        }
    }
    
}

extension MySQLExecute.Error: CustomStringConvertible {
    public var description: String {
        return "MySQL \(code) error: \(message)"
    }
}

public extension MySQLExecute.Error {
    
    /// conversion JSONConversionError to MySQLExecute.Error (code = 2000, message = "\(error)")
    ///
    /// - Parameter error: JSON Conversion Error
    /// - Returns: MySQLExecute Error
    static func jsonConversionError(_ error: Swift.Error) -> MySQLExecute.Error {
        return MySQLExecute.Error(code: 2000, message: "\(error)")
    }
    static func throwError(_ error: MySQLExecute.Error, userInfo: [String: Any]) -> MySQLExecute.Error {
        willThrow?(error, userInfo)
        return error
    }
}




