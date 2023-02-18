

import Foundation
struct ErrorModel : Codable {
	let email : [String]?
    let otp : [String]?

	enum CodingKeys: String, CodingKey {

		case email = "email"
        case otp = "otp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		email = try values.decodeIfPresent([String].self, forKey: .email)
        otp = try values.decodeIfPresent([String].self, forKey: .otp)
	}

}
