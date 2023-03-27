//
//  DashboardAndFeedsViewModel.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 19/03/23.
//

import Foundation

protocol DashboardAndFeedsViewModelProtocol: AnyObject {
    func updateUser(with status:String,message:String?)
    func eventListResponse(with events:EventList?)
    func postListResponse(with events:PostList?)
    func postLikeListResponse(with events:LikeList?)
    func postCommentListResponse(with events:CommentList?)
    
    
}
extension DashboardAndFeedsViewModelProtocol {
    func updateUser(with status:String,message:String?){}
    func eventListResponse(with events:EventList?){}
    func postListResponse(with events:PostList?){}
    func postLikeListResponse(with events:LikeList?){}
    func postCommentListResponse(with events:CommentList?){}
    
}

class DashboardAndFeedsViewModel {
    
    weak var delegate : DashboardAndFeedsViewModelProtocol?
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
        case .createPost:
            do{
                let signupResult = try JSONDecoder().decode(BRSignupModel.self, from: data)
               // self.delegate?.updateLoginResult(with: signupResult.message, success: signupResult.success ?? false)
            }catch{}
             break
        case .allEvents, .myEvents:
            do{
                let eventList = try JSONDecoder().decode(MainEventsList.self, from: data)
                
                self.delegate?.eventListResponse(with: eventList.eventList)
                
            }catch(let error){ 
               print(error)
            }
            break
        case .postlist:
            do{
                let postList = try JSONDecoder().decode(MainPostModel.self, from: data)
                
                self.delegate?.postListResponse(with: postList.postList)
                
            }catch(let error){
               print(error)
            }
            break
        case .postLikeList:
            do{
                let likeList = try JSONDecoder().decode(MainLikeModel.self, from: data)
                
                self.delegate?.postLikeListResponse(with: likeList.likeList)
                
            }catch(let error){
               print(error)
            }
            break
            
        case .postCommentList:
            do{
                let likeList = try JSONDecoder().decode(MainCommentModel.self, from: data)
                
                self.delegate?.postCommentListResponse(with: likeList.commentList)
                
            }catch(let error){
               print(error)
            }
            break
        
        default:
    
            break
        }
     }
}

