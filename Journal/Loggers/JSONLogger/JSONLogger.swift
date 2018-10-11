//
//  JSONLogger.swift
//  Journal
//
//  Created by Andras Hollo on 2018. 09. 03..
//  Copyright © 2018. Andras Hollo. All rights reserved.
//

open class JSONLogger: Logger {
    
    private var contextStore: ContextStore?
    
    // MARK: - Lifecycle methods
    
    public init() {
        
    }
    
    // MARK: - Logger
    
    open func log(logEntry: LogEntry) {
        
    }
    
    open func setContextStore(_ contextStore: ContextStore) {
        self.contextStore = contextStore
    }
    
}
