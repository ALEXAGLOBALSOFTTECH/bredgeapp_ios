

import Foundation
struct MainCommentModel : Codable {
	let success : Bool?
	let token : String?
	let commentList : CommentList?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case token = "token"
		case commentList = "CommentList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		token = try values.decodeIfPresent(String.self, forKey: .token)
        commentList = try values.decodeIfPresent(CommentList.self, forKey: .commentList)
	}

}
