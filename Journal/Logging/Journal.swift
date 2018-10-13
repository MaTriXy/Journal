//
//  Journal.swift
//  Journal
//
//  Created by Andras Hollo on 2018. 09. 03..
//  Copyright © 2018. Andras Hollo. All rights reserved.
//

public protocol JournalProtocol {
    func add(logger: Logger)
    func add(loggingContextProvider: LoggingContextProvider)
    func add(loggingDetailProvider: LoggingDetailProvider)
    func setContext(_ context: LoggingContext, toValue value: Encodable)
    func log(message:String, level: LogLevel, details: [String: AnyEncodable], error: Error?)
}

open class Journal: JournalProtocol {
    
    private let sessionID = UUID()
    
    private var loggers = [Logger]()
    private var loggingContextProviders = [LoggingContextProvider]()
    private var loggingDetailProviders = [LoggingDetailProvider]()
    private var contextStore = DefaultContextStore()
    
    // MARK: - Journal methods
    
    open func setContext(_ context: LoggingContext, toValue value: Encodable) {
        contextStore.setContext(context, toValue: value)
    }
    
    // MARK: - LoggingContextProvider
    
    open func add(loggingContextProvider: LoggingContextProvider) {
        loggingContextProviders.append(loggingContextProvider)
        loggingContextProvider.setContextStore(contextStore)
    }
    
    // MARK: - LoggingDetailsProvider
    
    open func add(loggingDetailProvider: LoggingDetailProvider) {
        loggingDetailProviders.append(loggingDetailProvider)
    }
    
    // MARK: - Loggers
    
    open func add(logger: Logger) {
        loggers.append(logger)
        logger.setContextStore(contextStore)
    }
    
    // MARK: - Logging
    
    open func log(message:String, level: LogLevel, details: [String: AnyEncodable], error: Error?) {
        var mutableDetails = details
        for loggingDetailProvider in loggingDetailProviders {
            mutableDetails.merge(loggingDetailProvider.provideDetails()) { (current, new) in
                internalLogVerbose("Current: \(current) new: \(new)")
                return current
                
            }
        }
        let logEntry = LogEntry(message: message, level: level, details: mutableDetails)
        for logger in loggers {
            logger.log(logEntry: logEntry)
        }
    }

}
