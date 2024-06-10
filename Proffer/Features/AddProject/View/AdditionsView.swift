//Proffer
//AdditionsView.swift

//Created by: Kareem on 3/5/24                      
//Copyright (c) 2023 Kareem

import SwiftUI

struct AdditionsView: View {
    let additionItem: AdditionItems
    let amount: Int
    var body: some View {
        VStack {
            Color(Asset.mainBGColor.color)
                .overlay {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(Asset.mainOrangeColor.color), lineWidth: 1)
                        
                        HStack(spacing: 20) {
                            additionItem.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 51, height: 51)
                            VStack(alignment: .leading) {
                                Text(additionItem.title)
                                    .textModifier(.medium, 14, .black)
                                HStack(spacing: 20) {
                                    Text("Type:".localized())
                                        .foregroundStyle(.gray)
                                    
                                    Text("additionItem")
                                        .textModifier(.regular, 14, .black)
                                        .foregroundStyle(.black)
                                }
                                .font(.custom(AppFonts.shared.name(.regular), size: 14))
                                
                                HStack(spacing: 20){
                                    Text("Amount:".localized())
                                        .foregroundStyle(.gray)
                                    
                                    Text("\(amount)")
                                        .foregroundStyle(.black)
                                }
                                .font(.custom(AppFonts.shared.name(.regular), size: 14))
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        
                    }
                }
        }
        .frame(height: 90)
    }
}

#Preview {
    AdditionsView(additionItem: .outlets, amount: 4)
}

enum RoomType : Int {
    case wet = 1
    case dry = 2
    
    var addition: [AdditionItems] {
        switch self {
        case .wet:
            return [.outlets, .bathTub, .waterSink, .toiletCapinet, .waterMixer, .waterHeater]
        case .dry:
            return [.outlets, .acSwitch, .telePoint, .dataPoint]
        }
    }
}
enum AdditionItems : Int {
    case outlets = 1
    case acSwitch = 2
    case telePoint = 3
    case dataPoint = 4
    case bathTub = 5
    case waterSink = 6
    case toiletCapinet = 7
    case waterMixer = 8
    case waterHeater = 9
    
    var title: String {
        switch self {
        case .outlets:
            return "Outlets".localized()
        case .acSwitch:
            return "AC Switch".localized()
        case .telePoint:
            return "Tele Point".localized()
        case .dataPoint:
            return "Data Point".localized()
        case .bathTub:
            return "Bath Tub".localized()
        case .waterSink:
            return "Water Sink".localized()
        case .toiletCapinet:
            return "Toilet Cabinet".localized()
        case .waterMixer:
            return "Water Mixer".localized()
        case .waterHeater:
            return "Water Heater".localized()
        }
    }
    
    var image: Image {
        switch self {
        case .outlets:
            return Image(Asset.electricOutlet.name)
        case .acSwitch:
            return Image(Asset.thermostat.name)
        case .telePoint:
            return Image(Asset.routerDevice.name)
        case .dataPoint:
            return Image(Asset.dataPoint.name)
        case .bathTub:
            return Image(Asset.bathTub.name)
        case .waterSink:
            return Image(Asset.waterSink.name)
        case .toiletCapinet:
            return Image(Asset.toiletCapinet.name)
        case .waterMixer:
            return Image(Asset.waterMixer.name)
        case .waterHeater:
            return Image(Asset.waterHeater.name)
        }
    }
}
