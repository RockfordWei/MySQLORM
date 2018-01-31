//
//  Cursor.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/19.
//
//

extension MySQLExecute {
    
    public struct Cursor {
        
        public var limit: Int = 50
        public var offset: Int = 0
        public var totalRecords: Int = 0
        
        public init() {
            
        }
        
        public init(limit: Int, offset: Int, totalRecords: Int = 0) {
            self.limit = limit
            self.offset = offset
            self.totalRecords = totalRecords
        }
        
    }
    
}




