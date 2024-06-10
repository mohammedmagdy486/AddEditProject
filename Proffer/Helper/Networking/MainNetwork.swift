//
//  MainNetwork.swift
//  Proffer
//
//  Created by M.Magdy on 20/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation
import Alamofire

enum MainNetwork
{
    case createPassword(dic:[String: Any])
    case deleteAccount
    case getBids
    case getContractorProfile
    case getReviews
    case filterBids(dic:[String: Any])
    case deleteMemory(id:Int)
    case changeEmail(dic: [String: Any])
    case getProfile(firstLogin: Int)
    case editProfile(dic: [String: Any])
}

extension MainNetwork: TargetType
{
    var baseURL: String {
        let source = Constants.shared.baseURL
        return source
    }
    
    var path: String {
        switch self {
       
        case .deleteAccount:
            return "auth/delete-account"
        case .getBids:
            return ""
        case .filterBids:
            return ""
        case .getContractorProfile:
            return ""
        case .getReviews:
            return ""
        case .deleteMemory(let id):
            return "auth/delete-file/\(id)"
        case .createPassword:
            return "change-password"
        case .changeEmail:
            return"auth/change-email"
        case .getProfile(let firstLogin):
            let userType = GenericUserDefault.shared.getValue(Constants.shared.userType) as? Int
            let isFistLogin = GenericUserDefault.shared.getValue(Constants.shared.isFirstLogin) as? Bool

            if userType == 2 && isFistLogin ?? false {
                return "auth/profile?is_first_login=\(firstLogin)"
            } else {
                return "auth/profile"
            }
            
        case .editProfile:
            return "auth/edit-profile"
}
    }
    
    var methods: HTTPMethod
    {
        switch self  {
        case  .createPassword, .filterBids, .changeEmail, .editProfile:
            return .post
        case .deleteAccount,.deleteMemory:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task
    {
        switch self{
         
        case .createPassword(dic: let dic):
            return .requestParameters(Parameters: dic, encoding: JSONEncoding.default)
        case .filterBids(dic: let dic):
            return .requestParameters(Parameters: dic, encoding: JSONEncoding.default)
        case .changeEmail(let dic):
            return .requestParameters(Parameters: dic, encoding: JSONEncoding.default)
        case .editProfile(let dic):
            return .requestParameters(Parameters: dic, encoding: JSONEncoding.default)
        default:
           return .requestPlain
}
    }
    
    
    var headers: [String : String]? {
        switch self {
        default:
            return NetWorkHelper.shared.Headers()
        }
    }
}
