//
//  ResultSet.swift
//  PerfectWorkspace
//
//  Created by 王传辉 on 2017/7/20.
//
//

extension MySQLExecute {
    
    public class ResultSet {
        
        public var rows: [Row] = []
        public var cursorData: Cursor = Cursor()
        public var fieldNames: [String] = []
        public var fieldInfo: [String: String] = [:]
        public var foundSetCount = 0
        public var insertedID = 0
        
    }
    
}
