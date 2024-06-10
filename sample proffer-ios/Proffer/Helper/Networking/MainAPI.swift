//
//  MainAPI.swift
//  Proffer
//
//  Created by M.Magdy on 20/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation

import Foundation
protocol MainAPIProtocol {
    func createPassword(dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func deleteAccount(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    
    func getReviews(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func deleteMemory(id:Int,Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func changeEmail(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func editProfile(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)


}



class MainAPI: BaseAPI<MainNetwork>, MainAPIProtocol
{
 
    func createPassword(dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .createPassword(dic: dic), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
        
    }
    
   
    
    func deleteAccount(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .deleteAccount, responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    func deleteMemory(id: Int, Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target: .deleteMemory(id: id), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    
    
    func getReviews(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target: .getReviews, responseClass: GeneralModel.self) { result in
            Completion(result)
        }
    }
    
    func changeEmail(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .changeEmail(dic: dic), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }

    func editProfile(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void) {
        self.fetchData(target: .editProfile(dic: dic), responseClass: GeneralModel.self) { result in
            Completion(result)
        }
    }

}
