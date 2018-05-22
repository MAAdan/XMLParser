//
//  RSSEntitiesGenerator.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 22/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

class RSSEntitiesGenerator {
    
    var articles = [Article]()
    
    func generate(node: Node) {
        if let name = node.name, name == "item" {
            let article = generateArticleEntityWith(node: node)
            articles.append(article)
        }
        
        if let nodes = node.nodes {
            for n in nodes {
                generate(node: n)
            }
        }
    }
    
    func generateArticleEntityWith(node: Node) -> Article {
        
        var tmp = (title: "", link: "", author: "", date: "", image: "")
        
        if let nodes = node.nodes {
            for n in nodes {
                if let name = n.name {
                    switch name {
                    case "title":
                        tmp.title = n.content ?? ""
                    case "guid":
                        tmp.link = n.content ?? ""
                    case "dc:creator":
                        tmp.author = n.content ?? ""
                    case "pubDate":
                        tmp.date = n.content ?? ""
                    case "media:content":
                        if let attributes = n.attributes, let url = attributes["url"] {
                            tmp.image = url
                        }
                    default:
                        break
                    }
                }
            }
        }
        
        return Article(title: tmp.title, image: tmp.image, link: tmp.link, author: tmp.author, date: tmp.date)
    }
    
}
