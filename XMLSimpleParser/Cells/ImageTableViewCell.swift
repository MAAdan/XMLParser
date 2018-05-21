//
//  ImageTableViewCell.swift
//  XMLSimpleParser
//
//  Created by Miguel Angel Adan Roman on 20/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit
import Kingfisher

typealias ImageTableViewCellCompletionHandler = (_ image: UIImage?, _ error: Error?, _ imageUrl: URL?) -> Void

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var customImageView: UIImageView!
    
    var aspectRatio: NSLayoutConstraint?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let aspectRatio = aspectRatio {
            imageView?.removeConstraint(aspectRatio)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImageWith(urlString: String, completion: @escaping ImageTableViewCellCompletionHandler) {
        
        if let url = URL(string: urlString) {
            customImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                
            })
        } else {
            customImageView?.image = nil
        }
    }
}
