

import Foundation
struct MainLikeModel : Codable {
	let success : Bool?
	let token : String?
	let likeList : LikeList?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case token = "token"
		case likeList = "LikeList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		likeList = try values.decodeIfPresent(LikeList.self, forKey: .likeList)
	}

}
