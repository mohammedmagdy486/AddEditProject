//
//  RoomDetailsView.swift
//  Proffer
//
//  Created by AMN on 28/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoomDetailsView: View {
    var room: RealRoomDetailsData?
    var roomType: RoomType
    @State var isBackTapped: Bool = false
    @StateObject var viewModel = AddProjectVM()
    var roomData: RealRoomDetailsData {
        return viewModel.roomDetails
    }
    var projectPhotos: [String]? = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(title: "Room Details".localized(), isBackTapped: $isBackTapped, color: .black)
                    .padding(.top, 15)
                    .onChange(of: isBackTapped) { _, _ in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    RoomDetailsInfoView(title: "Room Name".localized(),
                                                        roomData: room?.roomZone?.name ?? "room Zone")
                                    RoomDetailsInfoView(title: "Room Budget".localized(),
                                                        roomData: "\(room?.roomPrice ?? 0) " + "LE".localized())
                                    RoomDetailsInfoView(title: "Room Area".localized(),
                                                        roomData: "\(room?.length ?? 0) * \(room?.width ?? 0) * \(room?.height ?? 0)" + "m²".localized())
                                    Text("Description Room".localized())
                                        .textModifier(.regular, 17, .black)
                                    Text("More details you would like to add to this room.")
                                        .textModifier(.regular, 16, Color(Asset.blackTitles.color))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            
                            VStack {
                                HStack {
                                    Text("Room Material".localized())
                                        .textModifier(.medium, 17, Color(Asset.blackTitles.color))
                                    Spacer()
                                }
                                
                                HStack {
                                    RoomMaterialView(roomMaterial: .floor,
                                                     materialData: RoomMaterial(id: 0, name: "material", price: 20))
                                    
                                    RoomMaterialView(roomMaterial: .cell,
                                                     materialData: RoomMaterial(id: 0, name: "material", price: 10))
                                    
                                    RoomMaterialView(roomMaterial: .wall,
                                                     materialData: RoomMaterial(id: 0, name: "material", price: 15))
                                }
                            }
                            .padding(.top)
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text("Additions".localized())
                                        .textModifier(.medium, 17, Color(Asset.blackTitles.color))
                                    Spacer()
                                }
                                
                                VStack(spacing: 10) {
                                    AdditionsView(additionItem: .outlets, amount: 4)
                                    if roomType == .dry {
                                        AdditionsView(additionItem: .acSwitch, amount: 3)
                                        
                                        AdditionsView(additionItem: .telePoint, amount: 2)
                                        
                                        AdditionsView(additionItem: .dataPoint, amount: 4)
                                    } else {
                                        AdditionsView(additionItem: .bathTub, amount: 4)
                                        
                                        AdditionsView(additionItem: .waterSink, amount: 4)
                                        
                                        AdditionsView(additionItem: .toiletCapinet, amount: 1)
                                        
                                        AdditionsView(additionItem: .waterMixer, amount: 3)
                                        
                                        AdditionsView(additionItem: .waterHeater, amount: 4)
                                    }
                                }
                            }
                            .padding(.top)
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text("Room Images".localized())
                                        .textModifier(.medium, 17, Color(Asset.blackTitles.color))
                                    Spacer()
                                }

                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                                    ForEach(0..<5) { index in
                                        Image(Asset.workSample.name)
                                            .resizable()
                                            .frame(width: 110, height: 110)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                        
                        Button {
                            //Add Action
                        } label: {
                            MainButtonView(buttonTitle: "Add".localized(), buttonColor: .orange)
                        }
                        .padding(.top)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationBarHidden(true)
            .background(Color(Asset.mainBGColor.color))

        }
        .navigationBarHidden(true)
    }
}
#Preview {
    RoomDetailsView(roomType: .dry)
}


struct RoomDetailsInfoView: View {
    let title: String
    let roomData: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .textModifier(.medium, 20, .black)
            
            Text(roomData)
                .textModifier(.regular, 16, Color(Asset.blackTitles.color))
        }
    }
}




