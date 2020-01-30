//
//  HomeViewController.swift
//  Africave
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var selectedIndex = 0
    //var postArray =  PostsModel.postlist
     let singleObj = SinglePostViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Client.getPost(completion: { (post, error) in
            PostsModel.postlist = post
             self.postTableView.reloadData()
        })
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! SinglePostViewController
            //detailVC.selected =  postArray[]
            postTableView.reloadData()

            
        }
    }



}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsModel.postlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! HomeTableViewCell
        
        let post = PostsModel.postlist[indexPath.row]
  
        
        cell.post =  post
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            selectedIndex = indexPath.row
            performSegue(withIdentifier: "showDetail", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

