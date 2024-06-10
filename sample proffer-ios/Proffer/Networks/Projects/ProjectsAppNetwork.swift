//
//  ProjectsAppNetwork.swift
//

//

import Foundation
import Alamofire

enum ProjectsNetwork
{
    case projects(skip: Int,status: String)
    case getProjectData(id:Int)
    case home
    case projectDetails(id: Int)
    case cancelProject(id : Int, reason:String)
    case completeProject(id : Int)
    case rateProject(id : Int,dic:[String:Any])
    case projectKinds
    case deleteRoom(id: Int)
    case getRooms(id:Int)
    case confirmRooms(id:Int)
    case getRoomZones
}

extension ProjectsNetwork: TargetType
{
    var baseURL: String {
        let source = Constants.shared.baseURL
        return source
    }
    
    var path: String {
        switch self {
        case let .projects(skip,status):
            return "clients/projects?skip=\(skip)&filter[status]=\(status)"
        case let .getProjectData(id):
            return "projects/\(id)"
        case  .home:
            return "home"
        case let .projectDetails(id):
            return "showProject/\(id)"
        case .cancelProject(id: let id,_):
            return "cancelProject/\(id)"
        case .completeProject(id: let id):
            return "completeProject/\(id)"
        case .rateProject(id: let id,_):
            return "rateProject/\(id)"
        case .projectKinds:
            return "project_kind"
        

        case .deleteRoom(id: let id):
            return "delete_room\(id)"
        case .getRooms(id: let id):
            return "project_rooms\(id)"
        case .confirmRooms(id: let id):
            return "confirm_rooms\(id)"
        case .getRoomZones:
            return "get_zones"
        }
    }
    
    var methods: HTTPMethod
    {
        switch self  {
        case .cancelProject, .completeProject, .rateProject:
            return .post

        case .deleteRoom:
            return .delete
        case .confirmRooms:
            return .post

        default:
            return .get
        }
    }
    
    var task: Task
    {
        switch self{

        case .rateProject(_, let dic):
            return .requestParameters(Parameters: dic, encoding: JSONEncoding.default)
        case .cancelProject(_, let reason):
            return .requestParameters(Parameters: ["reason":reason], encoding: JSONEncoding.default)

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

