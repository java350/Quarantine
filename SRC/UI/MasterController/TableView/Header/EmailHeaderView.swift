//
//  EmailHeader.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class EmailHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    @IBOutlet weak var periodLabel: UILabel!
    
    
    // MARK: - Public methods
    func fill(with text: String) {
        periodLabel.text = text
    }
}
