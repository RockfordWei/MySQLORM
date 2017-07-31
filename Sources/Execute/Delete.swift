//
//  Delete.swift
//  MySQLORM
//
//  Created by 王传辉 on 2017/7/21.
//

import PerfectLib

public extension MySQLExecute {
    
    func delete(id: Int, name: String = "id") throws {
        try execute(statement: deleteSQL(name: name), params: [String(id)])
    }
    func delete(id: String, name: String = "id") throws {
        try execute(statement: deleteSQL(name: name), params: [id])
    }
    func delete(id: UUID, name: String = "id") throws {
        try execute(statement: deleteSQL(name: name), params: [id.string])
    }
    
    func deleteSQL(name: String = "id") -> String {
        return "DELETE FROM \(tableName) WHERE \(name) = ?"
    }
    
}


