

import Foundation
struct MainPostModel : Codable {
	let success : Bool?
	let token : String?
	let postList : PostList?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case token = "token"
		case postList = "PostList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		postList = try values.decodeIfPresent(PostList.self, forKey: .postList)
	}

}
