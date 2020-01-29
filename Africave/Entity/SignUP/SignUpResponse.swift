//
//  SignUpResponse.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation


struct SignUpResponse: Codable {
    let token: String
    let user: User
}
