//
//  UserLoginSignupViewModel.swift
//  Bredge
//
//  Created by rajeev arkvanshi
//

import Foundation

protocol LoginSignupViewModelProtocol: AnyObject {
    func updateUser(with status:String,message:String?)
    func signupResult(with message:String?, success:Bool)
    func otpVerifyResult(with message:String?, success:Bool)
    func updateProfileResult(with message:String?, success:Bool)
    func updateLoginResult(with message:String?, success:Bool)
    func updateIntrestList(with success:Bool, intrestList:[InterestList]?)
    func updateForgetPasswordResult(with message:String?, success:Bool, token:String?)
    func updateResendOtpResult(with message:String?, success:Bool, token:String)
    func updateSetNewpasswordResult(with message:String?, success:Bool)
    func updateUserProfileWithPostsDetail(detail : Profile?)
    func updateUserProfileWithUserDetail(detail : Profile?)
    func updateStoreUserIntrestResponse(success:Bool,message:String?)
    func updateUserListResponse(detail:[UserList]?)
    
}
extension LoginSignupViewModelProtocol {
    func updateUser(with status:String,message:String?){}
    func signupResult(with message:String?, success:Bool){}
    func otpVerifyResult(with message:String?, success:Bool){}
    func updateProfileResult(with message:String?, success:Bool){}
    func updateLoginResult(with message:String?, success:Bool){}
    func updateIntrestList(with success:Bool, intrestList:[InterestList]?){}
    func updateForgetPasswordResult(with message:String?, success:Bool, token:String?){}
    func updateResendOtpResult(with message:String?, success:Bool, token:String){}
    func updateSetNewpasswordResult(with message:String?, success:Bool){}
    func updateUserProfileWithPostsDetail(detail : Profile?){}
    func updateUserProfileWithUserDetail(detail : Profile?){}
    func updateStoreUserIntrestResponse(success:Bool,message:String?){}
    func updateUserListResponse(detail:[UserList]?){}
}

class UserLoginSignupViewModel {
    
    weak var delegate : LoginSignupViewModelProtocol?
    lazy var services: Networking<ApiTypes> = {
        let service = Networking<ApiTypes>()
        return service
    }()
    
    
    func execute(with api : ApiTypes){
        services.request(api) {[weak self] result in
           
            switch result{
                case .success(let respData)?:
                print(String(decoding: respData, as: UTF8.self))
                    self?.processResponse(with: respData, api: api)
                    break
            case .failure(let message, let code)?:
                print(message)
               
                self?.delegate?.updateUser(with: "error", message: message)
                 break
            
          case .none:
                break
            }
        }
    }
    
    private func processResponse(with data:Data, api:ApiTypes){
        
        switch api {
        case .LoginUser:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                if let t = signupResult.token {
                    UserDefaultHelper.token = String(t)
                }
                self.delegate?.updateLoginResult(with: signupResult.message, success: signupResult.success ?? false)
            }catch{}
             break
        case .SignUp:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                if let token = signupResult.token {
                    UserDefaultHelper.token = "\(token)"
                }
                if let status = signupResult.success, let error = signupResult.error, status == false{
                    self.delegate?.updateUser(with: "error", message: error.email?.first ?? "")
                }else{
                    self.delegate?.signupResult(with: signupResult.message, success: signupResult.success ?? false)
                }
            }catch{}
            break
        case .UpdateProfile:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                if let token = signupResult.token {
                    UserDefaultHelper.token = "\(token)"
                }
                self.delegate?.updateProfileResult(with: signupResult.message, success: signupResult.success ?? false)
            }catch{}
            break
        case .VerifyOtp:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                if let status = signupResult.success, let error = signupResult.error, status == false{
                    self.delegate?.updateUser(with: "error", message: error.email?.first ?? "")
                }else{
                    self.delegate?.otpVerifyResult(with: signupResult.message, success: signupResult.success ?? false)
                }
            }catch{}
            break
        case .All_Interest:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                if let status = signupResult.success, let error = signupResult.error, status == false{
                    self.delegate?.updateUser(with: "error", message: error.email?.first ?? "")
                }else{
                    self.delegate?.updateIntrestList(with: signupResult.success ?? false, intrestList: signupResult.interestList)
                }
            }catch{}
            break
        case .Forget_Password:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                self.delegate?.updateForgetPasswordResult(with: signupResult.message, success: signupResult.success ?? false, token: "\(signupResult.token ?? 0)")
            }catch{}
            break
        case .ResendOTP:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                self.delegate?.updateResendOtpResult(with: signupResult.message, success: signupResult.success ?? false, token: "\(signupResult.token ?? 0)")
            }catch{}
            break
        case .SetNew_Password:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                self.delegate?.updateSetNewpasswordResult(with: signupResult.message, success: signupResult.success ?? false)
            }catch{}
            //updateSetNewpasswordResult(with message:String?, success:Bool)
            break
        case .userProfile:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                self.delegate?.updateUserProfileWithUserDetail(detail: signupResult.profile)
            }catch{}
            break
        case .userProfileDetail:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                self.delegate?.updateUserProfileWithPostsDetail(detail: signupResult.profile)
            }catch{}
            break
        case .storeUserIntrest:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
              
                self.delegate?.updateStoreUserIntrestResponse(success: signupResult.success ?? false, message: signupResult.message)
            }catch{}
            break
        case .getAllUserList:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
                
                self.delegate?.updateUserListResponse(detail: signupResult.userList)
            }catch{}
            break
        default:
    
            break
        }
     }
}
