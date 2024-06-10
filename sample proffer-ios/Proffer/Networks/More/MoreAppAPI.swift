//
// MoreAPIProtocol.swift
//
//

//

import Foundation
protocol MoreAPIProtocol {
   
    func changePassword(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func contactUs(dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func logOut(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
    func deleteAccount(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void)
   

}



class MoreAPI: BaseAPI<MoreNetwork>, MoreAPIProtocol
{
 
    func changePassword(dic: [String:Any], Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .changePassword(dic: dic), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    
    func contactUs(dic:[String:Any],Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .contactUs(dic: dic), responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }

    func logOut(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .logOut, responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    func deleteAccount(Completion: @escaping (Result<GeneralModel?, NSError>) -> Void){
        self.fetchData(target: .deleteAccount, responseClass: GeneralModel.self) { (result) in
            Completion(result)
        }
    }
    
    
    
   
    
    
 
   
    
}
