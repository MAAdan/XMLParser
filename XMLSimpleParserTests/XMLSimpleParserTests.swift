//
//  XMLSimpleParserTests.swift
//  XMLSimpleParserTests
//
//  Created by Miguel Angel Adan Roman on 19/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import XCTest
@testable import XMLSimpleParser

class XMLSimpleParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        
        super.tearDown()
    }
    
    func testThatEntityHasAttributes() {
        let html = "<img src=\"http://www.a.com/images/logo.png\" style=\"border: 1px solid red;\" alt=\"Logo\" />"
        
        let simpleParser = XMLSimpleParser(data: html.data(using: .utf8)!)
        simpleParser.resultDelegate = self
        simpleParser.parse()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension XMLSimpleParserTests: XMLSimpleParserDelegate {
    func xmlParserDidFinishProcessingDocument(_ node: Node) {
        let expectedResult = Node()
        expectedResult.name = "img"
        expectedResult.attributes = [
            "src": "http://www.a.com/images/logo.png",
            "style": "border: 1px solid red;",
            "alt": "Logo"
        ]
        
        XCTAssertEqual(node.name, expectedResult.name)
        
        XCTAssertNotNil(node.attributes, "Node attributes should not be nil")
        XCTAssertNotNil(expectedResult.attributes, "Expected attributes should not be nil")
        XCTAssertEqual(node.attributes?.count, expectedResult.attributes?.count, "Number of attributes should be equal")
        
        if let nodeAttributes = node.attributes, let expectedAttributes = expectedResult.attributes {
            XCTAssertEqual(nodeAttributes, expectedAttributes)
        }
    }
    
    func xmlParserDidFinishProcessingDocumentWithError(_ error: Error) {
    }
}
