//
//  OptionsViewController.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 20/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

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
        if let id = segue.identifier {
            switch id {
            case "toParseViewControllerSegueId":
                if let vc = segue.destination as? ViewController, let option = sender as? String {
                    vc.selectedOption = option
                }
            default:
                if let vc = segue.destination as? HTMLPresenterViewController, let option = sender as? String {
                    vc.selectedOption = option
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option: String
        let segueId: String
        switch indexPath.row {
        case 0:
            option = "cd-catalog"
            segueId = "toParseViewControllerSegueId"
        case 2:
            option = "article"
            segueId = "toHTMLPresenterViewController"
        default:
            option = "article"
            segueId = "toParseViewControllerSegueId"
        }
        
        performSegue(withIdentifier: segueId, sender: option)
    }
}
