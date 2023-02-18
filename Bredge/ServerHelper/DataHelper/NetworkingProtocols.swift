//
//  NetworkingProtocols.swift
//  Bredge
//
//  Created by rajeev arkvanshi
//

import Foundation
import UIKit



// MARK: - Public protocols

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask { get }
    var baseURL: URL { get }
    var headers: HTTPHeaders? { get }
    
    
}
protocol HttpRequestHandlerProtocol: AnyObject {
    
    associatedtype EndPoint: EndPointType
    typealias NetworkRouterCompletion = (_ data: Result<String>?)->()
    func request(_ route: EndPoint,completion: @escaping NetworkRouterCompletion)
    
    func cancel()
}


protocol DownloadTask {
    
    var completionHandler: DownLoadResultType<Data>.Completion? { get set }
    var progressHandler: ((_ data: Data, _ progress: Double) -> Void)? { get set }
    
    func resumeTask()
    func suspendTask()
    func cancelTask()
}


// MARK: - Public Enums



 enum Result<T>{
    case success(Data)
    case failure(String, Int)
}
 enum DownLoadResultType<T> {
    
    public typealias Completion = (DownLoadResultType<T>) -> Void
    
    case success(T)
    case failure(Swift.Error)
    
}

 enum HTTPTask {
    case requestWithoutHeader
    case request(headers:HTTPHeaders?)
    case requestWithParameters(parameters:Parameter?,headers:HTTPHeaders?)
    case multipartWithParameters(parameters:Parameter?,headers:HTTPHeaders?, boundery:Boundary)
    
}

 let boundary = "Boundary-\(UUID().uuidString)"
 public var parameterDict : [String:Any]?
 public typealias Parameter =  [String:Any]
 public typealias HTTPHeaders = [String:String]
 public typealias Boundary = String
 

 public enum HTTPMethod: String {
     case post = "POST"
     case put = "PUT"
     case get = "GET"
     case delete = "DELETE"
     case patch = "PATCH"
     case profind = "PROPFIND"
 }


 

enum ApiTypes{
   
    case LoginUser(parameter:Parameter?)
    case SignUp(parameter:Parameter?)
    case ResendOTP(parameter:Parameter?)
    case VerifyOtp(parameter:Parameter?)
    case UpdateProfile(parameter:Parameter?)
    case All_Interest
    case Forget_Password(parameter:Parameter?)
    case SetNew_Password(parameter:Parameter?)
    
}

extension ApiTypes : EndPointType {
     
    
    var path: String {
        switch self {
        case .LoginUser:
            return "login"
        case .SignUp :
            return "register"
        case .ResendOTP:
            return "resendOTP"
        case .VerifyOtp:
             return "otpVerify"
        case .UpdateProfile:
            return "register2"
        case .All_Interest:
           return "all-interest"
        case .Forget_Password:
            return "forget-password"
        case .SetNew_Password:
            return "reset-password"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        
        case .All_Interest:
            return .get
        default:
            return .post
       
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .LoginUser, .SignUp, .VerifyOtp, .UpdateProfile, .Forget_Password, .ResendOTP, .SetNew_Password:
            return .multipartWithParameters(parameters: parameters, headers: headers, boundery: boundary)
        default:
            return .requestWithoutHeader
       
        }
    }
    
    var baseURL: URL {
        switch self {
        case .LoginUser, .SignUp, .VerifyOtp, .UpdateProfile, .All_Interest, .Forget_Password, .ResendOTP, .SetNew_Password:
            guard let url = URL(string: "http://bregeapptest.in/api/") else { fatalError("baseURL could not be configured.")}
            return url
        default:
            return URL(fileURLWithPath: "")
        
        }
       
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .LoginUser, .SignUp, .VerifyOtp, .UpdateProfile, .Forget_Password, .ResendOTP, .SetNew_Password:
            return ["Content-Type":"multipart/form-data; boundary=\(boundary)"]
        default :
            return ["":""]
        }
        
    }
    
    var parameters : Parameter? {
        switch self {
        case .LoginUser(parameter: let p), .SignUp(parameter: let p), .VerifyOtp(parameter: let p) , .UpdateProfile(parameter: let p), .Forget_Password(let p), .ResendOTP(let p), .SetNew_Password(let p):
            return p
        default:
            return ["":""]
            
        }
        //return parameterDict
    }
}





