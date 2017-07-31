//
//  Parse.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/20.
//
//

import MySQL

extension MySQLExecute {
    
    public func parseRows(result: MySQLStmt.Results?, resultSet: ResultSet) -> [Row] {
        var rows: [Row] = []
        _ = result?.forEachRow { (row: MySQLStmt.Results.Element) in
            var params = [String: Any]()
            (0..<(result?.numFields ?? 0)).forEach({ (index) in
                let fieldName = resultSet.fieldNames[index]
                if let type = resultSet.fieldInfo[fieldName] {
                    switch type {
                    case "integer", "double", "bytes", "string", "date":
                        params[fieldName] = row[index]
                    default:
                        params[fieldName] = String(describing: row[index]!)
                    }
                }
            })
            let myRow = Row()
            myRow.data = params
            rows.append(myRow)
        }
        return rows
    }
    
}
