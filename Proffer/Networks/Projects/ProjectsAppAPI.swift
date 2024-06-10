//
// ProjectsAPIProtocol.swift
//
//

//

import Foundation
protocol ProjectsAPIProtocol {
    func projects(skip : Int,status: String,Completion: @escaping (Result<RealShowProjectsModel?, NSError>) -> Void)
    
    func cancelProject(id : Int, reason:String, Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func completeProject(id : Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func rateProject(id : Int,dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func projectKinds(Completion: @escaping (Result<ProjectKindsModel?, NSError>) -> Void)
    func deleteRoom(id:Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func getRooms(projectId:Int ,Completion: @escaping (Result<RoomDetailsModel?, NSError>) -> Void)
    func confirmRooms(projectId:Int ,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func getRoomZoons(Completion: @escaping (Result<RoomZonesModel?, NSError>) -> Void)
    

}



class ProjectsAPI: BaseAPI<ProjectsNetwork>, ProjectsAPIProtocol
{
   

    func projectKinds(Completion: @escaping (Result<ProjectKindsModel?, NSError>) -> Void) {
        self.fetchData(target:.projectKinds, responseClass: ProjectKindsModel.self) { (result) in
            Completion(result)
        }
    }
    func projects(skip : Int,status: String,Completion: @escaping (Result<RealShowProjectsModel?, NSError>) -> Void){
        self.fetchData(target:.projects(skip: skip, status: status), responseClass: RealShowProjectsModel.self) { (result) in
            Completion(result)
        }
    }
    
    func cancelProject(id : Int,reason:String,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target:.cancelProject(id: id,reason: reason), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }

    func completeProject(id : Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target:.completeProject(id: id), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }

    func rateProject(id : Int,dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target:.rateProject(id: id,dic: dic), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    func deleteRoom(id: Int, Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target:.deleteRoom(id: id), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    func getRooms(projectId: Int, Completion: @escaping (Result<RoomDetailsModel?, NSError>) -> Void) {
        self.fetchData(target:.getRooms(id: projectId), responseClass: RoomDetailsModel.self) { (result) in
            Completion(result)
        }
    }
    func confirmRooms(projectId: Int, Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target:.confirmRooms(id: projectId), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    func getRoomZoons(Completion: @escaping (Result<RoomZonesModel?, NSError>) -> Void) {
        self.fetchData(target:.getRoomZones, responseClass: RoomZonesModel.self) { (result) in
            Completion(result)
        }
    }

}
