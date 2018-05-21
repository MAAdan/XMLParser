//
//  XMLParser.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 19/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol XMLSimpleParserDelegate: class {
    func xmlParserDidFinishProcessingDocument(_ node: Node)
    func xmlParserDidFinishProcessingDocumentWithError(_ error: Error)
}

class XMLSimpleParser: XMLParser {
    
    weak var resultDelegate: XMLSimpleParserDelegate?
    
    private let textElements = ["strong", "a", "em", "i", "span"]
    private var root = Node()
    private var stack = [Node]()
    private var tmpContentStringStack = [""]
    private var tmpContentString = ""
    private var currentParsedElement: Node?
    private var result = Node()
    
    public var preserveTextEntities = false
    
    override init(data: Data) {
        super.init(data: data)
        delegate = self
    }
    
    private func createHtmlStringWith(element: String, attributeDict: [String : String]) -> String {
        
        let attributesString = attributeDict.reduce("") { (partialResult, value) -> String in
            let (k, v) = value
            return partialResult + "\(k)=\"\(v)\" "
        }
        
        return "<\(element) \(attributesString)>"
    }
}

extension XMLSimpleParser: XMLParserDelegate {
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        let nameLowerCase = elementName.lowercased()
        
        if preserveTextEntities && textElements.contains(nameLowerCase) {
            if let lastContentString = tmpContentStringStack.last {
                let newContentString = lastContentString + self.createHtmlStringWith(element: nameLowerCase, attributeDict: attributeDict)
                tmpContentStringStack[tmpContentStringStack.count-1] = newContentString
            }
        } else {
            if stack.count == 0 {
                root.name = nameLowerCase
                root.nodes = [Node]()
                root.attributes = attributeDict
                currentParsedElement = root
                
                stack.append(root)
            } else {
                let newNode = Node()
                newNode.name = nameLowerCase
                newNode.nodes = [Node]()
                newNode.attributes = attributeDict
                
                stack.append(newNode)
                currentParsedElement?.nodes?.append(newNode)
                
                currentParsedElement = newNode
            }
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        let nameLowerCase = elementName.lowercased()
        
        if preserveTextEntities && textElements.contains(nameLowerCase) {
            if let lastContentString = tmpContentStringStack.last {
                let newContentString = lastContentString + "</\(nameLowerCase)>"
                tmpContentStringStack[tmpContentStringStack.count-1] = newContentString
            }
        } else {
            if let lastContentString = tmpContentStringStack.last {
                currentParsedElement?.content = lastContentString.trimmingCharacters(in: .whitespacesAndNewlines)
                tmpContentStringStack.removeLast()
            }
            
            stack.removeLast()
            currentParsedElement = stack.last
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let lastContentString = tmpContentStringStack.last {
            let newContentString = lastContentString + string
            tmpContentStringStack[tmpContentStringStack.count-1] = newContentString
        } else {
            tmpContentStringStack.append(string)
        }
    }
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if  let string = String(data:CDATABlock, encoding:String.Encoding.utf8) {
            if let lastContentString = tmpContentStringStack.last {
                let newContentString = lastContentString + string
                tmpContentStringStack[tmpContentStringStack.count-1] = newContentString
            } else {
                tmpContentStringStack.append(string)
            }
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        resultDelegate?.xmlParserDidFinishProcessingDocumentWithError(parseError)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("Parser ended")
        
        stack.removeAll()
        resultDelegate?.xmlParserDidFinishProcessingDocument(root)
        
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        print("Parser started")
    }
}
