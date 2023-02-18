//
//  Networking.swift
//  Bredge
//
//  Created by rajeev arkvanshi 
//

import Foundation
import UIKit


protocol NEtworkingProgressProtocols:AnyObject {
    func updateProgressData(data:Data)
    func updateExpectedContentLength(length:Int64?)
    func updateTaskCompletionResult(status:Bool)
}

class Networking<EndPoint: EndPointType> : NSObject, HttpRequestHandlerProtocol, URLSessionDelegate, URLSessionDataDelegate{
    
    var task: URLSessionTask?
    weak var networkingProgressDelegate : NEtworkingProgressProtocols?
    func request(_ route: EndPoint,completion: @escaping NetworkRouterCompletion) {
                 
        var sharedSession = URLSession.shared
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil
        configuration.urlCache?.removeAllCachedResponses()
        sharedSession = URLSession(configuration: configuration,
                             delegate: self, delegateQueue: nil)
        
        do {
            let request = try NetworkingHelper.buildRequest(from: route)
            self.task = sharedSession.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error  {
                    completion(Result.failure(error.localizedDescription, error._code))
                }
                if let response = response as? HTTPURLResponse {
                    
                let networkResult = try? NetworkingHelper.handleNetworkResponse(response, _responseData: data, requestObject: request)
                     completion(networkResult)
                    
                 }
               })
             }catch {
                 
            }
            
            self.task?.resume()
      }
    
    func cancel() {
        self.task?.cancel()
    }
    
}


