//
//  CommonModel.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 29/03/23.
//

import Foundation
struct CommonModel : Codable {
    let success : Bool?
    let message : String?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        
    }

}

