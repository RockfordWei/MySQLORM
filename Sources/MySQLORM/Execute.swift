//
//  Execute.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/21.
//
//

import PerfectMySQL


public class MySQLExecute {
    public var lastStatement: MySQLStmt?
    public var tableName: String
    public let results = ResultSet()
    public init(tableName: String) {
        self.tableName = tableName
    }
    
    public func execute(statement: String) throws -> MySQL.Results {
        let connection = Connect()
        try connection.open()
        let success = connection.server.query(statement: statement)
        guard success else {
            throw MySQLExecute.Error.throwError(connection.error, userInfo: ["statement": statement])
        }
        let result = connection.server.storeResults()!
        connection.close()
        return result
    }
    
    private func fieldNamesToStringArray(_ dic: [Int:String]) -> [String] {
        return (0..<dic.count).map({dic[$0] ?? ""})
    }
    
    public func execute(statement: String, params: [String], isInsert: Bool = false) throws {
        let connection = Connect()
        try connection.open()
        lastStatement = MySQLStmt(connection.server)
        defer {
            lastStatement?.close()
        }
        let isPrepare = lastStatement?.prepare(statement: statement)
        guard isPrepare == true else {
            throw MySQLExecute.Error.throwError(connection.error, userInfo: ["statement": statement, "params": params])
        }
        params.forEach({lastStatement?.bindParam($0)})
        let isExecute = lastStatement?.execute()
        guard isExecute == true else {
            throw MySQLExecute.Error.throwError(connection.error, userInfo: ["statement": statement, "params": params])
        }
        let result = lastStatement?.results()
        results.foundSetCount = result?.numRows ?? 0
        if isInsert {
            results.insertedID = Int(lastStatement?.insertId() ?? 0)
        }
        connection.close()
    }
    
    public func executeRows(statement: String, params: [String]) throws -> [Row] {
        let connection = Connect()
        try connection.open()
        lastStatement = MySQLStmt(connection.server)
        let isPrepare = lastStatement?.prepare(statement: statement)
        guard isPrepare == true else {
            throw MySQLExecute.Error.throwError(connection.error, userInfo: ["statement": statement, "params": params])
        }
        params.forEach({lastStatement?.bindParam($0)})
        let isExecute = lastStatement?.execute()
        guard isExecute == true else {
            throw MySQLExecute.Error.throwError(connection.error, userInfo: ["statement": statement, "params": params])
        }
        (0..<Int(lastStatement?.fieldCount() ?? 0)).forEach { (index) in
            if let info = lastStatement?.fieldInfo(index: index) {
                results.fieldInfo[info.name] = String(describing: info.type)
            }
        }
        let result = lastStatement?.results()
        results.foundSetCount = result?.numRows ?? 0
        results.fieldNames = fieldNamesToStringArray(lastStatement?.fieldNames() ?? [:])
        let rows = parseRows(result: result, resultSet: results)
        connection.close()
        return rows
    }
    
}



