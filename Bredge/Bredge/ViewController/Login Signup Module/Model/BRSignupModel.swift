

import Foundation
struct BRSignupModel : Codable {
	let success : Bool?
	let token : Int?
	let message : String?
    let error : ErrorModel?
    let interestList : [InterestList]?
    let profile : Profile?
    let userList : [UserList]?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case token = "token"
		case message = "message"
        case error = "error"
        case interestList = "interestList"
        case profile = "profile"
        case userList = "userList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
        if let str = try? values.decodeIfPresent(String.self, forKey: .token){
            token = Int(str)
        }else{
            token = try values.decodeIfPresent(Int.self, forKey: .token)
        }
		message = try values.decodeIfPresent(String.self, forKey: .message)
        error = try values.decodeIfPresent(ErrorModel.self, forKey: .error)
        interestList = try values.decodeIfPresent([InterestList].self, forKey: .interestList)
        profile = try values.decodeIfPresent(Profile.self, forKey: .profile)
        userList = try values.decodeIfPresent([UserList].self, forKey: .userList)
	}

}
