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
            customImageView?.removeConstraint(aspectRatio)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImageWith(url: URL, completion: @escaping ImageTableViewCellCompletionHandler) {
        
        customImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
            
            if let width = image?.size.width, let height = image?.size.height {
                
                if let titleCenterYConstraint = try? self.customImageView?.getConstraintWith(id: "CustomImageAspectRationConstraint") {
                    titleCenterYConstraint?.isActive = false
                    
                    let newConstraint = NSLayoutConstraint(
                        item: self.customImageView,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: self.customImageView,
                        attribute: .width,
                        multiplier: (height / width),
                        constant: 1
                    )
                    
                    newConstraint.priority = UILayoutPriority(999)
                    newConstraint.identifier = "CustomImageAspectRationConstraint"
                    newConstraint.isActive = true
                }
            }
            
            completion(image, error, url)
        })
    }
}
