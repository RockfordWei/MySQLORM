//
//  Connect.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/18.
//
//

import PerfectMySQL

extension MySQLExecute {
    class Connect {
        
        public let connector: Connector
        public let server = MySQL()
        
        
        deinit {
            close()
        }
        
        public init(connector: Connector = Connector.default) {
            self.connector = connector
        }
        
        public func open() throws {
            let isConnect = server.connect(host: connector.host, user: connector.username, password: connector.password, db: connector.database, port: UInt32(connector.port))
            if isConnect == false {
                let error = MySQLExecute.Error(code: server.errorCode(), message: server.errorMessage())
                throw MySQLExecute.Error.throwError(error, userInfo: ["connect": server.errorMessage()])
            }
        }
        public func close() {
            server.close()
        }
        
        var error: MySQLExecute.Error {
            return MySQLExecute.Error(code: server.errorCode(), message: server.errorMessage())
        }
        
        
    }
}


