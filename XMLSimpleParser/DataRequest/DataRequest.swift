//
//  DataRequest.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 20/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

typealias RequestHandlerSuccess = (_ data: Data) -> Void
typealias RequestHandlerError = (_ error: Error) -> Void

class DataRequest {
    
    func request(fileName: String, success: RequestHandlerSuccess, error: RequestHandlerError) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "xml") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                success(data)
            } catch let catchedError {
                error(catchedError)
                print("parse error: \(catchedError.localizedDescription)")
            }
        } else {
            let userInfo: [String : Any] = [
                NSLocalizedDescriptionKey :  NSLocalizedString("Parse error", value: "Invalid filename/path.", comment: ""),
                NSLocalizedFailureReasonErrorKey : NSLocalizedString("Parse error", value: "Invalid filename/path.", comment: "")
            ]
            
            error(NSError(domain: "", code: 500, userInfo: userInfo))
        }
    }
}
