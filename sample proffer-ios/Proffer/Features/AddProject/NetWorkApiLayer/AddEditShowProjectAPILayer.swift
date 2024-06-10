//
//  AddEditShowProjectAPILayer.swift
//  Proffer
//
//  Created by M.Magdy on 23/05/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation
protocol RealProjectProtocol {
    func getProjectTypes(Completion: @escaping (Result<RealProjectTypesModel?, NSError>) -> Void)
    func getRoomZones(Completion: @escaping (Result<RealRoomZonesModel?, NSError>) -> Void)
    
    func getMaterials(category:Int,Completion: @escaping (Result<RealMaterialsModel?, NSError>) -> Void)
    func getadditions(category:String,Completion: @escaping (Result<RealAdditionsModel?, NSError>) -> Void)
    func showProjectData(projectId:Int,Completion: @escaping (Result<RealShowProjectByIdModel?, NSError>) -> Void)
    func showProjectRooms(projectId:Int,Completion: @escaping (Result<RealShowProjectRoomsModel?, NSError>) -> Void)
    func showRoomDetails(roomId:Int,Completion: @escaping (Result<RealRoomDetailsModel?, NSError>) -> Void)
    func deleteRoomImage(imageId:Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func publishProject(projectId:Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)

}



class RealProjectApi: BaseAPI<RealProjectsNetwork>, RealProjectProtocol
{
    func getProjectTypes(Completion: @escaping (Result<RealProjectTypesModel?, NSError>) -> Void) {
        self.fetchData(target:.projectTypes, responseClass: RealProjectTypesModel.self) { (result) in
            Completion(result)
        }
    }
    
    
    func getRoomZones(Completion: @escaping (Result<RealRoomZonesModel?, NSError>) -> Void) {
        self.fetchData(target:.roomZones, responseClass: RealRoomZonesModel.self) { (result) in
            Completion(result)
        }
    }
    
    func getMaterials(category:Int,Completion: @escaping (Result<RealMaterialsModel?, NSError>) -> Void) {
        self.fetchData(target:.materials(category: category), responseClass: RealMaterialsModel.self) { (result) in
            Completion(result)
        }
    }
    
    func getadditions(category:String,Completion: @escaping (Result<RealAdditionsModel?, NSError>) -> Void) {
        self.fetchData(target:.additions(category: category), responseClass: RealAdditionsModel.self) { (result) in
            Completion(result)
        }
    }
    func showProjectData(projectId:Int,Completion: @escaping (Result<RealShowProjectByIdModel?, NSError>) -> Void) {
        self.fetchData(target:.showProjectData(id: projectId), responseClass: RealShowProjectByIdModel.self) { (result) in
            Completion(result)
        }
    }
    
    func showProjectRooms(projectId:Int,Completion: @escaping (Result<RealShowProjectRoomsModel?, NSError>) -> Void) {
        self.fetchData(target:.showProjectRooms(id: projectId), responseClass: RealShowProjectRoomsModel.self) { (result) in
            Completion(result)
        }
    }
    
    func showRoomDetails(roomId:Int,Completion: @escaping (Result<RealRoomDetailsModel?, NSError>) -> Void) {
        self.fetchData(target:.showRoomDetails(id: roomId), responseClass: RealRoomDetailsModel.self) { (result) in
            Completion(result)
        }
    }
    
    func deleteRoomImage(imageId:Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target:.deleteRoomImage(id: imageId), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    func publishProject(projectId: Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target:.publish(id: projectId), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
}
