//
//  HTMLEntitiesGenerator.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 20/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

enum HTMLEntityType {
    case text
    case image
}

struct HTMLEntity {
    var type: HTMLEntityType
    var content: String
    var attributes: [String: String]?
}

class HTMLEntitiesGenerator {
    
    var entities = [HTMLEntity]()
    
    init() {
    }
    
    func generateHtmlEntityWith(node: Node) {
        
        if let nodeName = node.name {
            switch nodeName {
            case "p":
                if let content = node.content {
                    entities.append(HTMLEntity(type: .text, content: content, attributes: node.attributes))
                }
                
            case "img":
                if let attrSrc = node.attributes?["src"] {
                    entities.append(HTMLEntity(type: .image, content: attrSrc, attributes: node.attributes))
                }
            default:
                break
            }
        }
        
        if let childNodes = node.nodes {
            for childNode in childNodes {
                generateHtmlEntityWith(node: childNode)
            }
        }
    }
}
