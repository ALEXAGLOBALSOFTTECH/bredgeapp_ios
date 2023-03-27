

import Foundation
struct CommentList : Codable {
	let current_page : Int?
	let dataObject : [DataObject]?
	let first_page_url : String?
	let from : Int?
	let last_page : Int?
	let last_page_url : String?
	let links : [Links]?
	let next_page_url : String?
	let path : String?
	let per_page : Int?
	let prev_page_url : String?
	let to : Int?
	let total : Int?
    

	enum CodingKeys: String, CodingKey {

		case current_page = "current_page"
		case dataObject = "data"
		case first_page_url = "first_page_url"
		case from = "from"
		case last_page = "last_page"
		case last_page_url = "last_page_url"
		case links = "links"
		case next_page_url = "next_page_url"
		case path = "path"
		case per_page = "per_page"
		case prev_page_url = "prev_page_url"
		case to = "to"
		case total = "total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
		dataObject = try values.decodeIfPresent([DataObject].self, forKey: .dataObject)
		first_page_url = try values.decodeIfPresent(String.self, forKey: .first_page_url)
		from = try values.decodeIfPresent(Int.self, forKey: .from)
		last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
		last_page_url = try values.decodeIfPresent(String.self, forKey: .last_page_url)
		links = try values.decodeIfPresent([Links].self, forKey: .links)
		next_page_url = try values.decodeIfPresent(String.self, forKey: .next_page_url)
		path = try values.decodeIfPresent(String.self, forKey: .path)
		per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
		prev_page_url = try values.decodeIfPresent(String.self, forKey: .prev_page_url)
		to = try values.decodeIfPresent(Int.self, forKey: .to)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}

}
