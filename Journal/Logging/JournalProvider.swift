//
//  JournalProvider.swift
//  Journal
//
//  Created by Andras Hollo on 2018. 09. 03..
//  Copyright © 2018. Andras Hollo. All rights reserved.
//

open class JournalProvider {
    
    public let journal: JournalProtocol = Journal()
    
    public static let shared = JournalProvider()
    
    private init() {}

}
