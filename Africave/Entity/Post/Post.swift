//
//  Post.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let id: Int
    let title: String
    let image: String?
    let User: User
}
