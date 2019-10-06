//
//  ParserEmail.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

class ParserEmail {
    
   // MARK: - Public methods
   static func parse() -> ResponceEmail {
        if let filepath = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: filepath)
                let responceEmails = try JSONDecoder().decode(ResponceEmail.self, from: data)
                
                return responceEmails
            } catch {
                print(error)
            }
        }
        
        return ResponceEmail(data: [], count: 0)
    }
}
