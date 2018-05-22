//
//  Node.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 19/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

class Node {
    var name: String?
    var attributes: [String:String]?
    var nodes: [Node]?
    var content: String?
}
