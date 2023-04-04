

import Foundation
class DataObject : Codable {
	let id : Int?
	let user_id : Int?
    let post_title : String?
	let event_name : String?
	let event_date : String?
	let start_time : String?
	let end_time : String?
	let entry_fee : String?
	let location : String?
	let event_type : String?
	let description : String?
	let created_at : String?
	let updated_at : String?
    let event_image : String?
    let first_name : String?
    let last_name : String?
    let profile_img : String?
    let published_as : String?
    let lat : String?
    let lon : String?
    let images : String?
    let user_token : String?
    let address : String?
    var likes : Int?
    let comments : Int?
    let image : String?
    let comment : String?
    let gender : String?
    var liked : Int?
    

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
        case post_title = "post_title"
		case event_name = "event_name"
		case event_date = "event_date"
		case start_time = "start_time"
		case end_time = "end_time"
		case entry_fee = "entry_fee"
		case location = "location"
		case event_type = "event_type"
		case description = "description"
		case created_at = "created_at"
		case updated_at = "updated_at"
        case event_image = "event_image"
        case first_name = "first_name"
        case last_name = "last_name"
        case profile_img = "profile_img"
        case published_as = "published_as"
        case lat = "lat"
        case lon = "lon"
        case images = "images"
        case user_token = "user_token"
        case address = "address"
        case likes = "likes"
        case  comments = "comments"
        case image = "image"
        case comment = "comment"
        case gender = "gender"
        case liked = "liked"
	}

	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		event_name = try values.decodeIfPresent(String.self, forKey: .event_name)
		event_date = try values.decodeIfPresent(String.self, forKey: .event_date)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		entry_fee = try values.decodeIfPresent(String.self, forKey: .entry_fee)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		event_type = try values.decodeIfPresent(String.self, forKey: .event_type)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        event_image = try values.decodeIfPresent(String.self, forKey: .event_image)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        profile_img = try values.decodeIfPresent(String.self, forKey: .profile_img)
        post_title = try values.decodeIfPresent(String.self, forKey: .post_title)
        published_as = try values.decodeIfPresent(String.self, forKey: .published_as)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        images = try values.decodeIfPresent(String.self, forKey: .images)
        user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        liked = try values.decodeIfPresent(Int.self, forKey: .liked)
        
	}

}
