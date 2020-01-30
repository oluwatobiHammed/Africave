//
//  HashTagViewController.swift
//  Africave
//
//  Created by user on 30/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class HashTagViewController: UIViewController {
    @IBOutlet weak var hashtagTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          _ = Client.getPost(completion: { (post, error) in
               print(post.count)
                PostsModel.postlist = post
                self.hashtagTableView.reloadData()
           })
         
       }
    }
    



