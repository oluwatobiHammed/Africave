//
//  SignInRequest.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation

struct SignInRequest: Codable {
    
    let email: String
    let password: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case email
        case password
       
    }
    
}
