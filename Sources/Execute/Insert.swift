//
//  Insert.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/21.
//


public extension MySQLExecute {
    
    func insert(data: [String: Any]) throws -> Int {
        var columns: [String] = []
        var params: [Any] = []
        data.forEach { (item) in
            columns.append(item.key)
            params.append(item.value)
        }
        return try insert(columns: columns, params: params)
    }
    
    func insert(columns: [String], params: [Any]) throws -> Int {
        var paramsString = [String]()
        var substString = [String]()
        params.forEach { (item) in
            paramsString.append(String.init(describing: item))
            substString.append("?")
        }
        let str = "INSERT INTO \(tableName) (\(columns.joined(separator: ","))) VALUES(\(substString.joined(separator: ",")))"
        try execute(statement: str, params: paramsString, isInsert: true)
        return results.insertedID
    }
    
}

