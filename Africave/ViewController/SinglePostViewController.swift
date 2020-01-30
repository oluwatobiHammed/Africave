//
//  SinglePostViewController.swift
//  Africave
//
//  Created by user on 29/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import UIKit

class SinglePostViewController: UIViewController {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var hashtagTextField: UITextView!
    var hashTag: String = " "
    let hashTags: String = ""
    var selected: Int? = nil
    var textArray = [String]()
    var fontArray = [UIFont]()
    var colorArray = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Client.getSinglePost(completion: { (success, error) in
            
            self.fetchSinglePost(PostsModel.postlist)
            
            
            
        })
        hashtagTextField.isUserInteractionEnabled = true
               

    }
    

    @IBAction func gestureReconizer(_ sender: UITapGestureRecognizer) {
        
                    let homeViewController =  storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
                      view.window?.rootViewController = homeViewController
                      view.window?.makeKeyAndVisible()
            }
    func fetchSinglePost(_ post: [Post])   {
        //print(post[selected!].hashtags)
        for post in  post {
                  self.nameLabel.text = "User Name: \(post.User.username)"
                  print(post.User.username)
                  self.emailLabel.text = "User Email: \(post.User.email)"
                  let hashTags  =  post.hashtags
                  let tags =  hashTags.split(separator: ",")
            for tags in tags {
                
                hashtagTextField.text.append("#\(tags)") 
            }
                  


                  self.postImage.image = UIImage(named: "Placeholder")
                  let postsImage = post.image
                  if let crestPath = URL(string: postsImage) {
                                    DispatchQueue.global().async {
                                    let data = try? Data(contentsOf: crestPath)
                                    if let data = data {
                                    if  let image: UIImage = UIImage(data: data){
                                                               
                                    DispatchQueue.main.async {
                                            self.postImage.image = image
                                                                      
                                                                  }
                                                                  
                                                              }
                                                          }
                                                      }
                                                      }
              }
    }
  
    
}
