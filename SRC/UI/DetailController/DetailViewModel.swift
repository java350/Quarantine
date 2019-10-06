//
//  DetailViewModel.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation

class DetailViewModel: ViewModel {
    
    // MARK: - Properties
    var title: String? = "Detail"
    var email: Email?
    
    
    // MARK: - Initializations
    init(email: Email?) {
        self.email = email
    }

    
    // MARK: - Public methods
    func updateEmail(_ email: Email?) {
        self.email = email
    }
}
