//
//  Rule.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 19/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

class Rule {
    var rule: String?
    var result: String?
    var type: String?
    
    init(rule: String, result: String, type: String) {
        self.rule = rule
        self.result = result
        self.type = type
    }
}
