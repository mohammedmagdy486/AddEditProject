//
//  BudgetView.swift
//  Proffer
//
//  Created by M.Magdy on 10/06/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI


struct BudgetView: View {
    let bgColor: Color
    let title: String
    let budget: Float
    let budgetViewType: BudgetViewType
    @Binding var bidsPopUP: BidsPopUPs
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(bgColor)
            .frame(height: 140)
            .shadow(color: .gray.opacity(0.5), radius: 5)
            .overlay {
                VStack(spacing: 10) {
                    HStack {
                        Text(title)
                            .textModifier(.semiBold, 14, .black)
                        Spacer()
                    }
                    
                    HStack(spacing: 15) {
                        Image(Asset.currency.name)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor( budgetViewType == .total ? Color(Asset.mainOrangeColor.color) : Color(Asset.blackTitles.color))
                            .frame(width: 30, height: 30)
                            
                        VStack(alignment: .leading) {
                            HStack {
                                Text(String(format: "%.1f", budget))
                                    .textModifier(.medium, 26,
                                                  budgetViewType == .total ? Color(Asset.mainOrangeColor.color) : Color(Asset.blackTitles.color))
                                
                                Text(" LE".localized())
                                    .textModifier(.regular, 17,
                                                  budgetViewType == .total ? Color(Asset.mainOrangeColor.color) : Color(Asset.blackTitles.color))
                            }
                            
                            
                            Text("Total price after calculating your requires".localized())
                                .textModifier(.regular, 12, .black)
                                .lineLimit(2)
                            if budgetViewType != .total {
                                Button(action: {
                                    bidsPopUP = budgetViewType == .contractor ? .contractor : .market
                                }, label: {
                                    Text("View Details".localized())
                                        .textModifier(.medium, 10, Color(Asset.blackTitles.color))
                                        .underline()
                                })
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
    }
}

enum BudgetViewType : Int {
    case total
    case contractor
    case client
}
//#Preview {
//    BudgetView(bgColor: .white, title: "Contractor Budget", budget: 2000, budgetViewType: .contractor, bidsPopUP: .constant(.contractor))
//}


enum BidsPopUPs {
    case contractor
    case market
    case accept
    case filter
    case none
}
