//
//  DBHelper.swift
//  UniGnoHesap
//
//  Created by Kaan Baysal on 18.10.2020.
//  Copyright © 2020 Kaan Baysal. All rights reserved.
//

import Foundation
import SQLite3


class DBHelper {
    
    var db :OpaquePointer?
    var path: String = "myDb.sqlite"
    init(){
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: false).appendingPathExtension(path)
    
        var db: OpaquePointer? = nil
        
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Error creating db")
            return nil
        }else
        {
            print("Database created \(path)")
        return db
        }
        
        
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXIST gno(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,result TEXT,list TEXT);"
        var statement: OpaquePointer? = nil
 
        if sqlite3_prepare_v2(self.db, query, -1, &statement,nil) == SQLITE_OK
        {
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Table success")
            
            }else{
                
                print("Table couldnt create")
                
            }
            
        }else{
            
            print("db failed")
            
            
        }
    }
    
    
    
    
}
