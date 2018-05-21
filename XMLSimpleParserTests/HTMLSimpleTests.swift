//
//  HTMLSimpleTests.swift
//  XMLSimpleParserTests
//
//  Created by Miguel Angel Adan Roman on 21/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import XCTest

class HTMLSimpleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testThatHTMLStringHasAttributes() {
        let html = "<p>Hello <a href=\"http://www.a.com/text/text.html\" style=\"border: 1px solid red;\" alt=\"Logo\">world</a></p>"
        
        let simpleParser = XMLSimpleParser(data: html.data(using: .utf8)!)
        simpleParser.preserveTextEntities = true
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

extension HTMLSimpleTests: XMLSimpleParserDelegate {
    func xmlParserDidFinishProcessingDocument(_ node: Node) {
        let expectedResult = Node()
        expectedResult.name = "p"
        expectedResult.content = "Hello <a style=\"border: 1px solid red;\" alt=\"Logo\" href=\"http://www.a.com/text/text.html\" >world</a>"
        
        XCTAssertEqual(node.name, expectedResult.name)
        XCTAssertEqual(node.content, expectedResult.content)
    }
    
    func xmlParserDidFinishProcessingDocumentWithError(_ error: Error) {
    }
}

