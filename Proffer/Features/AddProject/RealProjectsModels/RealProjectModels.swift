//
//  RealProjectModel.swift
//  Proffer
//
//  Created by M.Magdy on 23/05/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation

// MARK: - GeneralModel

struct GeneralModel: Codable {
    let status: Bool?
    let message: String?
}


struct ProjectKindsModel:Codable{
    let status: Bool
    let message: String
    let data: [AllProjectKinds]
}



// MARK: - AllProjectKinds
struct AllProjectKinds: Codable {
    let id : Int
    let name: String
}

// MARK: - RealProjectTypesModel
struct RealProjectTypesModel: Codable {
    let status: Bool?
    let message: String?
    let data: [RealProjectTypesData]?
}

// MARK: - RealProjectTypesData
struct RealProjectTypesData: Codable {
    let id: Int?
    let name: String?
}


// MARK: - RealRoomZonesModel
struct RealRoomZonesModel: Codable {
    let status: Bool?
    let message: String?
    let data: [RealRoomZonesData]?
}

// MARK: - RealRoomZonesData
struct RealRoomZonesData: Codable {
    let id: Int?
    let name: String?
    let type: Int?
}


// MARK: - RealMaterialsModel
struct RealMaterialsModel: Codable {
    let status: Bool?
    let message: String?
    let data: [RealMaterialsData]?
    let count: Int?
}

// MARK: - RealMaterialsData
struct RealMaterialsData: Codable, Equatable, Identifiable {
    var id: Int?
    var name: String?
    var materialImage: String?
    var price: Double?
    var category: Int?
}

// MARK: - RealAdditionsModel
struct RealAdditionsModel: Codable {
    var status: Bool?
    var message: String?
    var data: [RealAdditionsData]?
    var count: Int?
}

// MARK: - RealAdditionsData
struct RealAdditionsData: Codable, Equatable {
    var id: Int?
    var name: String?
    var price: Double?
    var category: Int?
    var quantity: Int?
}


// MARK: - RealShowProjectsModel
struct RealShowProjectsModel: Codable {
    var status: Bool?
    var message: String?
    var data: [RealShowProjectsData]?
    var count: Int?
}



// MARK: - RealShowProjectsData
struct RealShowProjectsData: Codable {
    var id: Int?
    var name: String?
    var status: Int?
    var area: Double?
    var totalBudget: Double?
    var projectImage: String?
    var createdAt: String?
    var contractorName:String?
    var contractorPhoto:String?
    
}


// MARK: - RealShowProjectByIDModel
struct RealShowProjectByIdModel: Codable {
    var status: Bool?
    var message: String?
    var data: RealShowProjectByIdData?
}

// MARK: - RealShowProjectByIdData
struct RealShowProjectByIdData: Codable,Equatable {
    var id: Int?
    var name: String?
    var status: Int?
    var area: Int?
    var totalBudget: Double?
    var projectImage: String?
    var createdAt, location, lat, long: String?
    var fromBudget: Int?
    var toBudget: Int?
    var isOpenBudget: Int?
    var duration: Int?
    var startDate: String?
    var roomNumbers: Int?
    var projectType: ProjectType?
    var rooms: [Room]?
    var contractorName:String?
    var contractorPhoto:String?
    var contractorPhone:String?
    var clientPhone:String?
}

// MARK: - ProjectType
struct ProjectType: Codable,Equatable {
    var id: Int?
    var name: String?
}

// MARK: - Room
struct Room: Codable, Equatable {
    var id: Int?
    var width, height, length: Double?
    var roomPrice: Double?
    var roomZone: String?

}

// MARK: - RealShowProjectRoomsModel
struct RealShowProjectRoomsModel: Codable {
    var status: Bool?
    var message: String?
    var data: RealShowProjectRoomsData?
}

// MARK: - DataClass
struct RealShowProjectRoomsData: Codable {
    var rooms: [RealProjectRoomData]?
    var totalBudget: Double?

 
}

// MARK: - Room
struct RealProjectRoomData: Codable {
    var id:Int?
    var length: Double?
    var width, height: Double?
    var roomPrice: Double?
    var roomZone: String?
    
}




// MARK: - RealRoomDetailsModel
struct RealRoomDetailsModel: Codable {
    var status: Bool?
    var message: String?
    var data: RealRoomDetailsData?
}

// MARK: - RealRoomDetailsData
struct RealRoomDetailsData: Codable, Equatable {
    var id : Int?
    var length, width, height: Double?
    var roomPrice: Int?
    var description: String?
    var roomImages: [RealRoomImage]?
    var materials : [RealMaterialsData]?
    var additions: [RealAdditionsData]?
    var roomZone: RealRoomZone?

}


// MARK: - RealRoomImage
struct RealRoomImage: Codable, Equatable {
    var id: Int?
    var url: String?
}

// MARK: - RealRoomZone
struct RealRoomZone: Codable , Equatable {
    var id, type: Int?
    var name: String?
}



// MARK: - CreateProjectModel
struct CreateProjectModel: Codable {
    var status: Bool?
    var message: String?
    var data: CreateProjectData?
}

// MARK: - CreateProjectData
struct CreateProjectData: Codable {
    var name: String?
    var area: Int?
    var location, lat, long: String?
    var fromBudget: Int?
    var toBudget: Double?
    var isOpenBudget, duration: String?
    var startDate: String?
    var projectTypeID: String?
    var userID: Int?
    var updatedAt, createdAt: String?
    var id: Int?

}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}


// MARK: - LoginModel
struct LoginModel: Codable {
    let status: Bool?
    let message: String?
    let data: LoginData?
    let token: String?
}

// MARK: - LoginData
struct LoginData: Codable {
    let accountType: Int?
    let name, email, profileImage: String?
    let firstLogin: Int?
}
