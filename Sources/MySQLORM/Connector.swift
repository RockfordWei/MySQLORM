//
//  Connector.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/18.
//
//

extension MySQLExecute {
    public struct Connector {
        public static var host: String = ""
        public static var port: Int = 3306
        public static var username: String = ""
        public static var password: String = ""
        public static var database: String = ""
        
        public let host: String
        public let port: Int
        public let username: String
        public let password: String
        public let database: String
        
        public static let `default`: Connector = Connector(host: Connector.host, port: Connector.port, username: Connector.username, password: Connector.password, database: Connector.database)
        
    }
}


