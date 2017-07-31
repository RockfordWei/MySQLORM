//
//  DataSourceJoin.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/19.
//
//

extension MySQLExecute {
    
    public enum JoinType {
        case inner, outer, left, right, straight, normal
    }
    
}


extension MySQLExecute {
    
    public struct DataSourceJoin {
        
        public var table: String = ""
        public var direction: JoinType
        public var onCondition: String = ""
        
        public init() {
            direction = .normal
        }
        
        public init(table: String, onCondition: String = "", direction: JoinType = .normal) {
            self.table = table
            self.onCondition = onCondition
            self.direction = direction
        }
        
    }
    
}
