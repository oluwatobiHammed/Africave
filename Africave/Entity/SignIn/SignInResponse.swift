//
//  SignInResponse.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation


struct SignInResponse: Codable {
    let token: String
    let user: User
}
