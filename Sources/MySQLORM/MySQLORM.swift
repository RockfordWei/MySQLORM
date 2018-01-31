import PerfectMySQL


public class MySQLORM<Table: MySQLORMTable> {
    
    public let execute: MySQLExecute
    
    public init() {
        execute = MySQLExecute(tableName: Table.table)
    }
    
    
}

public extension MySQLORM {
    
    func create(_ value: Table) throws -> Int {
        let id = try execute.insert(data: value.asDic())
        return id
    }
    
    func save(_ value: Table) throws -> Int {
        if value.idIsEmpty() {
            let id = try execute.insert(data: value.asDic(1))
            return id
        }else {
            let first = value.firstKeyValue()
            try execute.update(data: value.asDic(1), idName: first.0, idValue: first.1)
            return Number(first.1).int
        }
    }
    
}

public extension MySQLORM {
    
    func delete(_ value: Table) throws {
        let (idName, idValue) = value.firstKeyValue()
        try execute.execute(statement: execute.deleteSQL(name: idName), params: [String(describing: idValue)])
    }
    
    func delete(_ id: Any) throws {
        let idName = Table.firstKey()
        try execute.execute(statement: execute.deleteSQL(name: idName), params: [String(describing: id)])
    }
    
}

public extension MySQLORM {
    
    func get(_ id: Any) throws -> Table? {
        let idName = Table.firstKey()
        try execute.select(whereClause: "\(idName) = ?", params: [String(describing: id)], orderby: [])
        if let row = execute.results.rows.first {
            return Table(row: row)
        }
        return nil
    }
    
    func find(_ data: [String: Any]) throws -> [Table] {
        let idName = Table.firstKey()
        var params = [Any]()
        var set = [String]()
        data.forEach { (item) in
            params.append(item.value)
            set.append("\(item.key) = ?")
        }
        try execute.select(whereClause: set.joined(separator: ","), params: params, orderby: [idName])
        return execute.results.rows.map({Table(row: $0)})
    }
    
    func findAll() throws -> [Table] {
        let cursor = MySQLExecute.Cursor(limit: 0000000, offset: 0)
        try execute.select(columns: Table.columns().map({$0.key}), whereClause: "1", params: [], orderby: [], cursor: cursor)
        return execute.results.rows.map({Table(row: $0)})
    }
    
}


