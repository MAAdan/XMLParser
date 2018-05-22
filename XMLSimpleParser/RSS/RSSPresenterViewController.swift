//
//  RSSPresenterViewController.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 22/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class RSSPresenterViewController: UITableViewController, OptionPresenterProtocol {
    
    var selectedOption: String?
    var result: [Article]?
    var downloadedImages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if let fileName = selectedOption {
            let dataRequest = DataRequest()
            dataRequest.request(fileName: fileName, success: { (data) in
                DispatchQueue.global().async {
                    let parser = XMLSimpleParser(data: data)
                    parser.preserveTextEntities = true
                    parser.resultDelegate = self
                    parser.parse()
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func set(selectedOption: String) {
        self.selectedOption = selectedOption
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellId", for: indexPath) as! ArticleTableViewCell
        
        if let article = result?[indexPath.row] {
            cell.articleTitle.text = article.title
            if let url = URL(string: article.image), article.image.count > 0 {
                cell.articleImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                        
                    if !self.downloadedImages.contains(article.image) {
                        self.downloadedImages.append(article.image)
                    }
                })
            } else {
                cell.articleImage.image = nil
            }
        }
        
        return cell
    }
}

extension RSSPresenterViewController: XMLSimpleParserDelegate {
    func xmlParserDidFinishProcessingDocument(_ node: Node) {
        DispatchQueue.global().async {
            let generator = RSSEntitiesGenerator()
            generator.generate(node: node)
            self.result = generator.articles
            
            print(self.result ?? [])
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    func xmlParserDidFinishProcessingDocumentWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}
