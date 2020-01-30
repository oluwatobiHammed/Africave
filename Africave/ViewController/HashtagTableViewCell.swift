//
//  HashtagTableViewCell.swift
//  Africave
//
//  Created by user on 30/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class HashtagTableViewCell: UITableViewCell {

    @IBOutlet weak var hashtagImage: UIImageView!
    @IBOutlet weak var hashtagTitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
