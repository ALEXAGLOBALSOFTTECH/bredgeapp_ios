

import Foundation
struct MainEventsList : Codable {
	let success : Bool?
	let eventList : EventList?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case eventList = "EventList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
        if let ev = try? values.decodeIfPresent(EventList.self, forKey: .eventList){
            eventList = ev
        }else{
            eventList = nil
        }
		
	}

}
