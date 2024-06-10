//
//  RealProjectsNetwork.swift
//  Proffer
//
//  Created by M.Magdy on 23/05/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation
import Alamofire

enum RealProjectsNetwork
{
    case projectTypes
    case roomZones
    case materials(category:Int)
    case additions(category:String)
    case showProjectData(id:Int)
    case showProjectRooms(id:Int)
    case showRoomDetails(id:Int)
    case deleteRoomImage(id:Int)
    case publish(id:Int)
}

extension RealProjectsNetwork: TargetType
{
    var baseURL: String {
        let source = Constants.shared.baseURL
        return source
    }
    
    var path: String {
        switch self {
        case .projectTypes:
            return "project-types"
        case .roomZones:
            return "room-zones"
        case let .materials(category):
            return "materials?filter[category]=\(category)"
        case let .additions(category):
            return "additions?filter[category]=\(category)"
        case let .showProjectData(id):
            return "clients/projects/\(id)"
        case let .showProjectRooms(projectId):
            return "clients/rooms/projects/\(projectId)"
        case let .showRoomDetails(id):
            return "clients/rooms/\(id)"
        case let .deleteRoomImage(id):
            return "clients/rooms/delete-file/\(id)"
        case let .publish(id):
            return "clients/projects/\(id)/publish"
        
        }
    }
    
    var methods: HTTPMethod
    {
        switch self  {
        case .publish:
            return .post

        case .deleteRoomImage:
            return .delete


        default:
            return .get
        }
    }
    
    var task: Task
    {
        switch self{
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

