//
//  Upsert.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/21.
//

public extension MySQLExecute {
    
    func upsert(columns: [String], params: [Any], conflictKeys: [String]) throws {
        var paramsString: [String] = []
        var upsertParamsString: [String] = []
        var substString: [String] = []
        var upsertString: [String] = []
        (0..<params.count).forEach { (index) in
            paramsString.append(String.init(describing: params[index]))
            substString.append("?")
            if index >= conflictKeys.count {
                upsertString.append("\(String(describing: columns[index])) = ?")
            }
            if !conflictKeys.contains(columns[index]) {
                upsertParamsString.append(String(describing: params[index]))
            }
        }
        paramsString.append(contentsOf: upsertParamsString)
        let str = "INSERT INTO \(tableName) (\(columns.joined(separator: ","))) VALUES(\(substString.joined(separator: ","))) ON DUPLICATE KEY UPDATE \(upsertString.joined(separator: ","))"
        try execute(statement: str, params: paramsString)
    }
    
}
