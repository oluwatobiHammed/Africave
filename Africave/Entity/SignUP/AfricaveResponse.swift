//
//  AfricaveResponse.swift
//  Africave
//
//  Created by user on 28/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation

struct AfricaveResponse: Codable {
    
        let msg: String
        
        enum CodingKeys: String, CodingKey {
            case msg
        }
    }

    extension AfricaveResponse: LocalizedError {
        var errorDescription: String? {
            return msg
        }
     
}
