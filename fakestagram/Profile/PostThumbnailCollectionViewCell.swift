//
//  PostThumbnailCellCollectionViewCell.swift
//  fakestagram
//
//  Created by Alan Vargas on 4.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostThumbnailCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "postThumbnailCell"
    @IBOutlet weak var imageView: UIImageView!
    
    var post: Post? {
        didSet { updateImageView() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateImageView() {
        guard let post = post else { return }
        post.load { [weak self] img in
            self?.imageView.image = img
        }
    }

}
