//
//  User.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation
struct User: Codable {
    let email: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case username
    }

}
