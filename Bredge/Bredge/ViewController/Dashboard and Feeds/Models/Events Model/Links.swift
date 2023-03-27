

import Foundation
struct Links : Codable {
	let url : String?
	let label : String?
	let active : Bool?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case label = "label"
		case active = "active"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		active = try values.decodeIfPresent(Bool.self, forKey: .active)
	}

}
