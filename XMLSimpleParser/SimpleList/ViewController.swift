//
//  ViewController.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 19/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OptionPresenterProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var resultNode: Node?
    var selectedOption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if resultNode == nil {
            if let fileName = selectedOption {
                let dataRequest = DataRequest()
                dataRequest.request(fileName: fileName, success: { (data) in
                    DispatchQueue.global().async {
                        let parser = XMLSimpleParser(data: data)
                        parser.resultDelegate = self
                        parser.parse()
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func set(selectedOption: String) {
        self.selectedOption = selectedOption
    }
}

extension ViewController: XMLSimpleParserDelegate {
    func xmlParserDidFinishProcessingDocument(_ node: Node) {
        resultNode = node
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
            
    }
    
    func xmlParserDidFinishProcessingDocumentWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultNode?.nodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        if  let node = resultNode?.nodes?[indexPath.row] {
            cell.accessoryType = node.nodes?.count ?? 0 > 0 ? .disclosureIndicator : .none
            if let content = node.content, content.count > 0 {
                cell.textLabel?.text = content
            } else {
                cell.textLabel?.text = node.name
            }
        } else {
            cell.textLabel?.text = "-"
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let node = resultNode?.nodes?[indexPath.row], let nodes = node.nodes, nodes.count > 0 {
            
            if  let st = storyboard,
                let viewController = st.instantiateViewController(withIdentifier: "ViewControllerId") as? ViewController {
                
                viewController.resultNode = node
                
                navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
