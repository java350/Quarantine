//
//  ResponceEmail.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

struct ResponceEmail: Decodable {
    let data: [Email]
    let count: Int
}
