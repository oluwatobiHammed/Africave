//
//  TableViewCell.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var post: Post! {
        didSet {
            postImage.image = UIImage(named: "Placeholder")
            
                let postsImage = post.image
               if let crestPath = URL(string: postsImage) {
                                   DispatchQueue.global().async {
                                       let data = try? Data(contentsOf: crestPath)
                                       if let data = data {
                                        //print(data)
                                           if  let image: UIImage = UIImage(data: data){
                                            
                                               DispatchQueue.main.async {
                                                   self.postImage.image = image
                                                   self.setNeedsLayout()
                                               }
                                               
                                           }
                                       }
                                   }
                                   }
    

          
            
            titleLabel.text = post.title

        }
    }
  
}
