//
//  PostTableViewCell.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var postAuthorProfileImage: UIImageView!
    @IBOutlet weak var postAuthorUsernameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    // MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post:Post) {
        ImageService.getImage(withURL: post.author.photoURL) { image in
            self.postAuthorProfileImage.image = image
        }
        postAuthorUsernameLabel.text = post.author.username
        postTextLabel.text = post.text
    }

}
