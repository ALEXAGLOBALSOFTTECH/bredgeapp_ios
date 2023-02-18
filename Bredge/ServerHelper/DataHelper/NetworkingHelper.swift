//
//  NetworkingHelper.swift
//  Bredge
//
//  Created by rajeev arkvanshi
//

import Foundation

class NetworkingHelper {
    
  
    static func buildRequest(from route: EndPointType) throws -> URLRequest {
    
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 300.0)
        request.httpShouldHandleCookies = false
        request.httpMethod = route.httpMethod.rawValue
        print(request.url!)
        do {
            switch route.task {
            case .requestWithoutHeader:
                break
            case .request(let headers):
               try addAdditionalHeaders(headers, request: &request)
            case .requestWithParameters(let parameters, let headers):
                try addAdditionalHeaders(headers, request: &request)
                try jsonEncoding(parameters, request: &request)
            case .multipartWithParameters(let parameters, let headers, let boundry):
                try addAdditionalHeaders(headers, request: &request)
                try multipartRequest(parameters, boundry: boundry, request: &request)
            }
            
        }catch let error{
            
        }
       return request
    }
    
   static  func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) throws {
        guard let headers = additionalHeaders else { return}
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
   static  func jsonEncoding(_ parameters: Parameter?, request: inout URLRequest) throws{
       guard let prams = parameters else { return }
       let jsonData = try? JSONSerialization.data(withJSONObject: prams)
       request.httpBody = jsonData
       
   }
    static func multipartRequest(_ parameters: Parameter?, boundry:Boundary, request: inout URLRequest) throws{
        guard let prams = parameters else { return }
        var body = ""
        
        prams.keys.forEach { key in
            body += "--\(boundry)\r\n"
            body += "Content-Disposition:form-data; name=\"\(key)\""
            if let val = prams[key] as? String {
                body += "\r\n\r\n\(val)\r\n"
            }
         }
        body += "--\(boundry)--\r\n";
        request.httpBody = body.data(using: .utf8)
        
    }
    
  


    
    static func handleNetworkResponse(_ response: HTTPURLResponse, _responseData:Data?, requestObject:URLRequest?) throws -> Result<String>{
          
        switch response.statusCode {
        case 200...299:
            guard let responseObject = _responseData else {
             return .failure("Something went wrong", response.statusCode)
            }
            return .success(responseObject)
            
        
        case 400, 401:
            guard let responseObject = _responseData else {
             return .failure("Something went wrong", response.statusCode)
            }
            return .success(responseObject)
        default:
            return .failure("Session expire", response.statusCode)
            
        }
    }
   
   

}

