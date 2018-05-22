//
//  ArticleTableViewCell.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 22/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
