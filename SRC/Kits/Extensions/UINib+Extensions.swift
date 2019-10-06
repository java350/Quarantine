//
//  UINib+Extensions.swift
//  API_Users
//
//  Created by Lisogonych Volodymyr on 1/12/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit

extension UINib {
    
    static func nib(withClass cls: AnyClass) -> UINib {
        return self.nib(withClass: cls, bundle: nil)
    }
    
    static func nib(withClass cls: AnyClass, bundle: Bundle?) -> UINib {
        return UINib(nibName: String(describing: cls), bundle: bundle)
    }
}
