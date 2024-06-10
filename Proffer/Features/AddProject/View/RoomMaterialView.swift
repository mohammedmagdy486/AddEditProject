//Proffer
//RoomMaterialView.swift

//Created by: Kareem on 3/6/24                      
//Copyright (c) 2023 Kareem

import SwiftUI

struct RoomMaterialView: View {
    var roomMaterial: RoomMaterialItems
    var materialData: RoomMaterial
    var body: some View {
        VStack(alignment: .leading) {
            Text(roomMaterial.title)
                .textModifier(.regular, 14, Color(Asset.blackTitles.color))
            roomMaterial.image
                .resizable()
                .frame(width: 110, height: 95)
                .overlay {
                    VStack(spacing: 0) {
                        Spacer()
                        ZStack(alignment: .bottom) {
                            Image(Asset.roomDetailShadow.name)
                            
                            VStack(spacing: 0) {
                                Text(materialData.name ?? "material name")
                                Text("area")
                                Text("\(materialData.price ?? 00)")
                            }
                            .textModifier(.regular, 10, .white)
                        }
                    }
                }
        }
    }
}

#Preview {
    RoomMaterialView(roomMaterial: .cell, materialData: RoomMaterial(id: 0, name: "room", price: 100))
}


enum RoomMaterialItems {
    case floor
    case cell
    case wall
    
    var title: String {
        switch self {
        case .floor:
            return "Floor".localized()
        case .cell:
            return "Cell".localized()
        case .wall:
            return "Wall".localized()
        }
    }
    
    var image: Image {
        switch self {
        case .floor:
            return Image(Asset.floor.name)
        case .cell:
            return Image(Asset.cell.name)
        case .wall:
            return Image(Asset.walls.name)
        }
    }
}
