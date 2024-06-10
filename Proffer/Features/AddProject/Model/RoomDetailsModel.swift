//
//  RoomDetailsModel.swift
//  Proffer
//
//  Created by M.Magdy on 04/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import Foundation
// MARK: - RoomDetailsModel
struct RoomDetailsModel:Codable{
    let status: Bool?
    let message: String?
    var roomDetailsData: [RoomDetailsData]?
}

struct RoomDetailsData : Codable {
    var id: Int?
    var zone: RoomZone?
    var type:Int?
    var length: Double?
    var width:Double?
    var height:Double?
    var roomMaterial: [RoomMaterial]?
    var description: String?
    var additions: Additions?
    var roomImages: [RoomImage]?
    var budget: Int?
    
}

struct RoomImage:Codable, Hashable{
    var id: Int?
    var image: String?
}
struct RoomZone : Codable {
    var id: Int?
    var name: String?
}
struct RoomMaterial: Codable {
    var id : Int?
    var name: String?
    var price: Int?
}
struct Additions:Codable {
    var id: Int?
    var name:String?
    var unitPrice:Double?
    var types: [AdditionsTypes]?
//    var selectedTypeId: Int?
//    var selectedTypeQuantity: Int?
//    var selectedTypeName: String?
}

struct AdditionsTypes : Codable {
    var id : Int?
    var name : String?
}
struct SelectedAdditions:Codable {
    var id: Int? 
    var selectedTypeId:Int?
    var selectedQuantity: Int?
    var selectedTypeName: String?
    var selectedTypePrice: Int?
}

//MARK: - RoomZonesModel
struct RoomZonesModel: Codable {
    let status: Bool?
    let message: String?
    var roomZonesData: [RoomZonesData]?
}
struct RoomZonesData:Codable {
    var id: Int?
    var type: Int?
    var name: String?
}
