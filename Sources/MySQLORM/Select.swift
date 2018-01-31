//
//  File.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/19.
//
//


public extension MySQLExecute {
    
    func select(whereClause: String, params: [Any], orderby: [String], cursor: Cursor = Cursor(), joins: [DataSourceJoin] = [], having: [String] = [], groupBy: [String] = []) throws {
        try select(columns: [], whereClause: whereClause, params: params, orderby: orderby, cursor: cursor, joins: joins, having: having, groupBy: groupBy)
    }
    
    func select(columns: [String], whereClause: String, params: [Any], orderby: [String], cursor: Cursor = Cursor(), joins: [DataSourceJoin] = [], having: [String] = [], groupBy: [String] = []) throws {
        let clauseCount = "COUNT(*) AS counter"
        var clauseSelectList = "*"
        var clauseWhere = ""
        var clauseOrder = ""
        if columns.count > 0 {
            clauseSelectList = columns.joined(separator: ",")
        }
        if whereClause.count > 0 {
            clauseWhere = " WHERE \(whereClause)"
        }
        let paramsString = params.map({String(describing: $0)})
        if orderby.count > 0 {
            clauseOrder = " ORDER BY \(orderby.joined(separator: ", "))"
        }
        
        var joinClause = ""
        joins.forEach({ (join) in
            switch join.direction {
            case .inner:
                joinClause += " INNER JOIN \(join.table) ON \(join.onCondition)"
            default:
                ()
            }
        })
        var str = "SELECT \(clauseSelectList) FROM \(tableName) \(joinClause) \(clauseWhere) \(clauseOrder)"
        let strCount = "SELECT \(clauseCount) FROM \(tableName) \(joinClause) \(clauseWhere)"
        if cursor.limit > 0 {
            let limit = " LIMIT \(cursor.limit)"
            str += limit
        }
        if cursor.offset > 0 {
            let offset = " OFFSET \(cursor.offset)"
            str += offset
        }
        let getCount = try executeRows(statement: strCount, params: paramsString)
        let numRecords = getCount.first?.data["counter"] ?? 0
        results.cursorData = Cursor(limit: cursor.limit, offset: cursor.offset, totalRecords: Int(numRecords as? Int64 ?? 0))
        results.rows = try executeRows(statement: str, params: paramsString)
    }
    
}

