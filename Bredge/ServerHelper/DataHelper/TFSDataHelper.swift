//
//  BEnum.swift
//  Bredge
//
//  Created by Sharda Prasad on 05/12/22.
//
import UIKit
//import Alamofire


class TFSDataHelper: NSObject {

    static let shared = TFSDataHelper()
    private override init(){

        super.init()
    }
    
    /****************** LIVE URL ******************/
//    static var baseUrl = ""
//    static var baseIMG = ""
    /*********************************************/
    

    /****************** LOCAL URL ******************/
    static var baseUrl = "http://bregeapptest.in/api/"
    static var baseUrl_One = "http://164.92.231.40/bredge/api/"
    
    static var baseIMG = ""
    /***********************************************/

    func postDataWith(request: [String: Any], serviceURL: String, completionHandler: @escaping (_ result: Bool,_ resultDict: [String:Any])->()) {
        
        /// Convert request to JSON data...
        guard let httpBody = try? JSONSerialization.data(withJSONObject: request, options: []) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        /// Create the url request...
        var request             = URLRequest(url: URL(string: serviceURL)!)
        request.httpMethod      = "POST"
        request.timeoutInterval = 15
        request.httpBody        = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("Error: URLSession.dataTask... error calling GET: -->>\n", error?.localizedDescription ?? "")
                completionHandler(true, [:])
                return
            }
            /// guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            let response = response as? HTTPURLResponse
            guard response?.statusCode == 200 else {
                                
                print("API_FAILURE ------>>>\n ErrorCode: \(response?.statusCode ?? 0) \n Error_Description: \(String(describing: error?.localizedDescription))")
                completionHandler(false, [:])
                return
            }
            
            guard let data = data else { print("Error: URLSession... Did not receive data")
                let dict = self.convertToDictionary(text: "")
                completionHandler(false,dict ?? [:])
                return
            }
            
            let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            let dict = self.convertToDictionary(text: datastring! as String)
            completionHandler(true, dict ?? [:])
            
        }.resume()
    }

    func getDataWith(serviceURL: String, completion: @escaping (_ result: Bool,_ resultDict: [String:Any])->()) {
        
      //  print("serviceTypeserviceTypeserviceTypeserviceType::::::\(serviceURL)")
        var request             = URLRequest(url: URL(string: serviceURL)!)
        request.httpMethod      = "GET"
        request.timeoutInterval = 15
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: URLSession.dataTask... error calling GET: -->>\n", error?.localizedDescription ?? "")
                completion(true, [:])
                return
            }
            ///guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            let response = response as? HTTPURLResponse
            guard response?.statusCode == 200 else {
                
                if response?.statusCode == 401 { print("Session expire") }
                else {
                }
                
                print("API_FAILURE ------>>>\n ErrorCode: \(response?.statusCode ?? 0) \n Error_Description: \(String(describing: error?.localizedDescription))")
                completion(false, [:])
                return
            }
            
            guard let data = data else { print("Error: URLSession... Did not receive data")
                let dict = self.convertToDictionary(text: "")
                completion(true,dict ?? [:])
                return
            }
            
            
            let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            let dict = self.convertToDictionary(text: datastring! as String)
            completion(true, dict ?? [:])
            
        }.resume()
       
    }

    //MARK:- POST DATA With Image
    func postAddTeamWithMemberWith(request: [String: Any], serviceURL: String, completion: @escaping (_ result: Bool,_ resultDict: [String:Any])->()) {
        
        print("postAddTeamWith::::::\(serviceURL):\(request)")
        
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 300
//        manager.upload(multipartFormData: { (MultipartFormData) in
//
//            if (serviceURL == "http://sportsbook.intigate.co.in:8081/team/addNewMember") {
//
//
//                for (key, value) in request {
//
//                    if (key != "memberImage") {
//                        print("pos:\(key)")
//                        MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName:"\(key)")
//                    }
//                }
//
//                for (key, value) in request {
//
//                    if (key == "memberImage") {
//
//                        let imgData11:UIImage? = value as? UIImage
//
//                        if let imag = imgData11 {
//
//                            let imgBool = self.imageIsNullOrNot(imageName: imag)
//
//                            if imgBool == true {
//
//                                let imageData:Data = imag.jpegData(compressionQuality: 0.75)!
//                                MultipartFormData.append(imageData, withName: "memberImage", fileName: "teamMimageNew232.jpeg", mimeType: "image/jpeg")
//                                print("pos11:\(key)")
//                            }
//                        }
//                        return
//                    }
//                }
//            }else {
//
//                for (key, value) in request {
//
//                    if (key != "Image") {
//                        MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName:"\(key)")
//                    }
//                }
//
//                for (key, value) in request {
//
//                    if (key == "Image" || key == "Attachment") {
//
//                        let imgData11:UIImage? = value as? UIImage
//
//                        if let imag = imgData11 {
//
//                            let imgBool = self.imageIsNullOrNot(imageName: imag)
//
//                            if imgBool == true {
//
//                                let imageData:Data = imag.jpegData(compressionQuality: 0.75)!
//                                MultipartFormData.append(imageData, withName: "memberImage", fileName: "imageNew232.jpeg", mimeType: "image/jpeg")
//                            }
//                        }
//                        return
//                    }
//                }
//            }
//        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: serviceURL, method: .post, headers: nil) { (result) in
//
//            switch result {
//            case .failure:
//
//                let userData = [:] as NSDictionary? as? [AnyHashable: Any] ?? [:]
//                completion(false,userData as NSDictionary)
//                break
//            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//
//                upload.responseJSON(completionHandler: { (response) in
//
//                    switch response.result {
//
//                    case .failure(let error):
//
//                        print("postAddTeamWith::", error)
//                        let userData = [:] as NSDictionary? as? [AnyHashable: Any] ?? [:]
//                        completion(false,userData as NSDictionary)
//                        break
//                    case .success( _):
//
//                        print("postAddTeamWithsuccesssuccess Succes, :: \(response) LLLLLLL \(response.value)")
//                        guard response.data != nil else { return }
//
//                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
//                        let dict = self.convertToDictionary(text: datastring! as String)
//                        completion(true,dict as? NSDictionary ?? [:])
//                        break
//                    }
//                })
//            }
//        }
    }

    // String convert to Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                let jsonDict =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: UInt(0)))
                return jsonDict as? [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


extension TFSDataHelper {
    
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
}
