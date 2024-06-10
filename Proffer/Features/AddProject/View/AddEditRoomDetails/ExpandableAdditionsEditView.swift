//
//  ExpandableAdditionsEditView.swift
//  Proffer
//
//  Created by M.Magdy on 07/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct ExpandableAdditionsEditView: View {
    @State var isEdit : Bool
    @Binding var comingData: [RealAdditionsData]?
    @Binding var selectedAddition: RealAdditionsData
    @Binding var isSelected: Bool

    @State  var quantity: String = ""
    @State  var totalPrice: Double = 0
    @State var isDropDownOpen : Bool? = false
    @State var additionStrings : [String] = []
    @State var selectedType: String = ""
    let additionItem: AdditionItems

    var body: some View {
        VStack {
            ZStack {
                if !isSelected {
                    VStack {
                        Color(Asset.mainBGColor.color)
                            .onTapGesture {
                                    withAnimation {
                                        self.isSelected.toggle()
                                    }
                            }
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(Asset.lightGray.color), lineWidth: 0.5)
                                    HStack(spacing: 20) {
                                        additionItem.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 51, height: 51)
                                        VStack(alignment: .leading) {
                                            Text(additionItem.title)
                                                .textModifier(.medium, 14, .black)
                                        }
                                        Spacer()
                                    }
                                    .padding(.leading)
                                }
                            }
                    }
                    .frame(height: 90)
                }
                else {
                    VStack {
                        Color(Asset.secondaryBGColor.color)
                            .frame(height: isDropDownOpen ?? false ? (comingData?.count ?? 0 < 5 ? CGFloat(170 + (30 * (comingData?.count ?? 0))) : 310 ) + 40 : 210)
                        // height is 170 + counts * 30 and the max is 310
                            .onTapGesture {
                                    withAnimation {
                                        self.isSelected.toggle()
                                }
                            }
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(Asset.mainOrangeColor.color), lineWidth: 0.5)
                                    HStack(spacing: 20) {
                                        additionItem.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 51, height: 51)
                                        VStack(alignment: .leading) {
                                                Text(additionItem.title)
                                                    .textModifier(.medium, 14, Color(Asset.mainOrangeColor.color))
                                                    .padding(.bottom,-30)
                                                    .padding(.leading,20)
                                            DropdownSearchTF(placeHolder:"Type".localized(), isOpen: $isDropDownOpen, text: $selectedType, title: "", options: $additionStrings , submitLabel: .next,height: 40,radius: 10)
                                                .onChange(of: selectedType) { _, newValue in
                                                    if let selected = comingData?.first(where: { $0.name == selectedType }) {
                                                        selectedAddition = selected
                                                    }
                                                }
                                            MainAppTF(text: $quantity , title: "".localized(), placeHolder: "Quantity".localized(), validationType: .noValidation, submitLabel: .done, keyboardType: .numberPad,height: 40,radius:10)
                                                .onChange(of: quantity) { oldValue, newValue in
                                                    totalPrice = (selectedAddition.price ?? 0) * (Double(quantity) ?? 0)
                                                    selectedAddition.quantity = Int(quantity.convertDigitsToEng) ?? 0
                                                }
                                            HStack {
                                                let totalValue = String(format:"%.1f",totalPrice)
                                                Text("Total Price:".localized() + totalValue + " LE".localized())
                                                    .textModifier(.regular, 11, Color(Asset.gray.color))
                                                    .padding(.top,-10)
                                                    .padding(.leading,20)
                                                Spacer()
                                                Button {
                                                    selectedType = ""
                                                    selectedAddition = RealAdditionsData()
                                                    quantity = ""
                                                    
                                                } label: {
                                                    Text("Clear".localized())
                                                        .textModifier(.medium, 14, Color(Asset.mainOrangeColor.color))
                                                        .padding(.trailing,20)
                                                        .padding(.bottom,10)
                                                        .underline()
                                                }
                                            }
                                        }
                                        .padding(.leading,-10)
                                    }
                                    .padding(.leading)
                                    .padding([.top,.bottom])
                                    
                                }
                                .frame(height: isDropDownOpen ?? false ? (comingData?.count ?? 0 < 5 ? CGFloat(170 + (30 * (comingData?.count ?? 0))) : 310): 170)                            }

                    }
                    .onAppear{
                        additionStrings = comingData?.compactMap { $0.name } ?? []
                    }

                }
            }
            .padding([.leading,.trailing])
            .padding([.bottom,.top],8)
        }
        .onChange(of: selectedAddition, { oldValue, newValue in
            selectedType = selectedAddition.name ?? ""
            let comingQuantity = selectedAddition.quantity ?? 0
            
            quantity = comingQuantity == 0 ? "" : String(comingQuantity)
            totalPrice = (selectedAddition.price ?? 0) * Double(selectedAddition.quantity ?? 0)
        })
        .animation(.easeIn, value: 0)
//        .onAppear{
//            if isEdit {
//                selectedType = selectedAddition.name ?? ""
//                quantity = String(selectedAddition.quantity ?? 0)
//                totalPrice = (selectedAddition.price ?? 0) * Double(selectedAddition.quantity ?? 0)
//            }
//        }
    }
    
}
