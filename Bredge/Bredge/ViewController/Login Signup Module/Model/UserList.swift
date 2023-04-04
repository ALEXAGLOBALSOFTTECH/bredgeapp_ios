

import Foundation
struct UserList : Codable {
	let id : Int?
	let first_name : String?
	let last_name : String?
	let email : String?
	let gender : String?
	let image : String?
	let user_token : String?
	let followerCount : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case last_name = "last_name"
		case email = "email"
		case gender = "gender"
		case image = "image"
		case user_token = "user_token"
		case followerCount = "followerCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
		followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
	}

}
