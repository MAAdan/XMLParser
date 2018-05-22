//
//  OptionsViewController.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 20/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

protocol OptionPresenterProtocol {
    var selectedOption: String? { get set }
    func set(selectedOption: String)
}

class OptionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OptionPresenterProtocol,
            let option = sender as? String {
            
            destination.set(selectedOption: option)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option: String
        let segueId: String
        switch indexPath.row {
        case 0:
            option = "cd-catalog"
            segueId = "toParseViewControllerSegueId"
        case 1:
            option = "article"
            segueId = "toParseViewControllerSegueId"
        case 2:
            option = "article"
            segueId = "toHTMLPresenterViewController"
        case 3:
            option = "nyt-rss"
            segueId = "toRssViewController"
        default:
            option = "article"
            segueId = "toParseViewControllerSegueId"
        }
        
        performSegue(withIdentifier: segueId, sender: option)
    }
}
