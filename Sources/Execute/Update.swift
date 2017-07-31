//
//  Update.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/21.
//

public extension MySQLExecute {
    
    func update(columns: [String], params: [Any], idName: String, idValue: Any) throws {
        var paramsString = [String]()
        var set = [String]()
        (0..<params.count).forEach { (index) in
            paramsString.append(String.init(describing: params[index]))
            set.append("\(columns[index]) = ?")
        }
        paramsString.append(String.init(describing: idValue))
        let str = "UPDATE \(tableName) SET \(set.joined(separator: ",")) WHERE \(idName) = ?"
        try execute(statement: str, params: paramsString)
    }
    
    func update(data: [String: Any], idName: String, idValue: Any) throws {
        var columns = [String]()
        var params = [Any]()
        data.forEach { (item) in
            columns.append(item.key)
            params.append(item.value)
        }
        try update(columns: columns, params: params, idName: idName, idValue: idValue)
    }
    
}
