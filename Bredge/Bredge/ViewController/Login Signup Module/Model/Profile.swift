

import Foundation
struct Profile : Codable {
	let id : Int?
	let first_name : String?
	let last_name : String?
	let email : String?
	let contact : String?
	let dob : String?
	let country_code : String?
	let address : String?
	let role : String?
	let image : String?
	let bio : String?
	let gender : String?
	let marital_status : String?
	let height : String?
	let height_unit : String?
	let facebook : String?
	let linkedin : String?
	let instagram : String?
	let twitter : String?
	let pinterest : String?
	let created_at : String?
	let lat : String?
	let lon : String?
    let followerCount : Int?
    let followeringCount : Int?
    let postCount : Int?
    let posts : Posts?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case last_name = "last_name"
		case email = "email"
		case contact = "contact"
		case dob = "dob"
		case country_code = "country_code"
		case address = "address"
		case role = "role"
		case image = "image"
		case bio = "bio"
		case gender = "gender"
		case marital_status = "marital_status"
		case height = "height"
		case height_unit = "height_unit"
		case facebook = "facebook"
		case linkedin = "linkedin"
		case instagram = "instagram"
		case twitter = "twitter"
		case pinterest = "pinterest"
		case created_at = "created_at"
		case lat = "lat"
		case lon = "lon"
        case followerCount = "followerCount"
        case followeringCount = "followeringCount"
        case postCount = "postCount"
        case posts = "posts"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		contact = try values.decodeIfPresent(String.self, forKey: .contact)
		dob = try values.decodeIfPresent(String.self, forKey: .dob)
		country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		role = try values.decodeIfPresent(String.self, forKey: .role)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		bio = try values.decodeIfPresent(String.self, forKey: .bio)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		marital_status = try values.decodeIfPresent(String.self, forKey: .marital_status)
		height = try values.decodeIfPresent(String.self, forKey: .height)
		height_unit = try values.decodeIfPresent(String.self, forKey: .height_unit)
		facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
		linkedin = try values.decodeIfPresent(String.self, forKey: .linkedin)
		instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
		twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
		pinterest = try values.decodeIfPresent(String.self, forKey: .pinterest)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		lon = try values.decodeIfPresent(String.self, forKey: .lon)
        followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
        followeringCount = try values.decodeIfPresent(Int.self, forKey: .followeringCount)
        postCount = try values.decodeIfPresent(Int.self, forKey: .postCount)
        posts = try values.decodeIfPresent(Posts.self, forKey: .posts)
	}

}
