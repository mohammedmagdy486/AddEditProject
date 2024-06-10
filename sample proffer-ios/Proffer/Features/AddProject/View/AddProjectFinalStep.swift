//
//  AddProjectFinalStep.swift
//  Proffer
//
//  Created by M.Magdy on 18/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct AddProjectFinalStep: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = AddProjectVM()
    @State var isBackTapped: Bool = false
    @State var budgetPopUp: BidsPopUPs = .none
    @State var projectId :Int
    var project : RealShowProjectByIdData {
        return viewModel.projectData
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(title: "Project Details".localized() ,isBackTapped: $isBackTapped,color: .black)
                    .padding(.top,15)
                    .onChange(of: isBackTapped) { _, _ in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Project Name".localized())
                            .textModifier(.regular, 17, .black)
                        Spacer()
                        Image(Asset.calendar.name)
                            .resizable()
                            .scaledToFill()
                            .frame(width:14,height: 14)
                        
                        Text(project.createdAt ?? "")
                            .font(.custom(AppFonts.shared.name(.light), size: 12))
                            .foregroundColor(Color(Asset.textGray.color))
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                    }
                    
                        HStack{
                            Image(Asset.location.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width:10,height: 14)
                            
                            Text("\(project.location ?? "") ")
                            
                                .font(.custom(AppFonts.shared.name(.regular), size: 14))
                                .foregroundColor(Color(Asset.textGray.color))
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                            Spacer()
                        }
                    
                    
                    VStack {
                        BudgetView(bgColor: .white,
                                   title: "Total Budget".localized(),
                                   budget: 2000,
                                   budgetViewType: .total, bidsPopUP: $budgetPopUp)
                        
                    }
                    Divider()
                        .padding([.leading,.trailing],60)
                        .padding([.top,.bottom],20)
                    HStack(spacing:5){
                        
                        
                        VStack{
                            Image(Asset.currencySmall.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .padding(.top,5)
                            HStack{
                                Text(String(format:"%.1f",project.totalBudget ?? 0.0))
                                    .font(.custom(AppFonts.shared.name(.semiBold), size: 17))
                                    .foregroundColor(.black)
                                Text(" LE".localized())
                                    .font(.custom(AppFonts.shared.name(.regular), size: 12))
                                    .foregroundColor(.black)
                            }
                            Text("Price".localized())
                                .font(.custom(AppFonts.shared.name(.light), size: 12))
                                .foregroundColor(.black)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                                .padding(.bottom,5)

                        }
                        .frame(maxHeight: .infinity)
                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .frame(height: 80)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color(Asset.mainOrangeColor.color).opacity(0.27), radius: 5, x: 0, y: 4)
                        
                        VStack{
                            Image(Asset.homeNotFill.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .padding(.top,5)

                            HStack{
                                Text(String(project.area ?? 0))
                                    .font(.custom(AppFonts.shared.name(.semiBold), size: 17))
                                    .foregroundColor(.black)
                                Text("M".localized())
                                    .font(.custom(AppFonts.shared.name(.regular), size: 12))
                                    .foregroundColor(.black)
                                
                                
                            }
                            Text("Project Area".localized())
                                .font(.custom(AppFonts.shared.name(.light), size: 12))
                                .foregroundColor(.black)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                                .padding(.bottom,5)

                        }
                        .frame(maxHeight: .infinity)
                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .frame(height: 80)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color(Asset.mainOrangeColor.color).opacity(0.27), radius: 5, x: 0, y: 4)
                        
                        VStack{
                            Image(Asset.clock.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .padding(.top,5)
                            HStack{
                                Text(String(project.duration ?? 0))
                                    .font(.custom(AppFonts.shared.name(.semiBold), size: 17))
                                    .foregroundColor(.black)
                                Text("Day".localized())
                                    .font(.custom(AppFonts.shared.name(.regular), size: 12))
                                    .foregroundColor(.black)
                            }
                            Text("Duration".localized())
                                .font(.custom(AppFonts.shared.name(.light), size: 12))
                                .foregroundColor(.black)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                                .padding(.bottom,5)

                            
                        }
                        .frame(maxHeight: .infinity)
                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .frame(height: 80)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color(Asset.mainOrangeColor.color).opacity(0.27), radius: 5, x: 0, y: 4)
                  
                     }
                    VStack(spacing:9){
                        HStack {
                            Text("Project Budget".localized())
                                 .font(.custom(AppFonts.shared.name(.regular), size: 17))
                                 .foregroundColor(.black)
                                 .lineLimit(2)
                                 .minimumScaleFactor(0.7)
                            Spacer()
                        }.padding(.bottom,2)
                     HStack(spacing:20) {
                         Text("From:".localized())
                             .font(.custom(AppFonts.shared.name(.light), size: 14))
                             .foregroundColor(Color(Asset.textGray.color))
                             .lineLimit(2)
                             .minimumScaleFactor(0.7)
                         Text(String(project.fromBudget ?? 0)+" LE".localized())
                                 .font(.custom(AppFonts.shared.name(.light), size: 14))
                                 .foregroundColor(.black)
                                 .lineLimit(2)
                                 .minimumScaleFactor(0.7)
                         Spacer()
                         }
                        if project.toBudget != nil {
                            HStack(spacing:20) {
                                Text("To:".localized())
                                    .font(.custom(AppFonts.shared.name(.light), size: 14))
                                    .foregroundColor(Color(Asset.textGray.color))
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.7)
                                Text(String(project.toBudget ?? 0)+" LE".localized())
                                    .font(.custom(AppFonts.shared.name(.light), size: 14))
                                    .foregroundColor(.black)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.7)
                                Spacer()
                            }
                        }
                    }.padding(.top)
                 
                    Divider()
                     .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                     .padding([.leading,.trailing],20)
                    VStack{
                        HStack {
                            Text( "Rooms Numbers".localized())
                                 .font(.custom(AppFonts.shared.name(.regular), size: 17))
                                 .foregroundColor(.black)
                                 .lineLimit(2)
                                 .minimumScaleFactor(0.7)
                            Spacer()
                         }
                         HStack {
                             Text("\(project.roomNumbers ?? 0) "+"Rooms".localized())
                                  .font(.custom(AppFonts.shared.name(.light), size: 14))
                                  .foregroundColor(.black)
                                  .lineLimit(2)
                                  .minimumScaleFactor(0.7)
                             Spacer()
                          }
                    }
                    ScrollView(.vertical,showsIndicators: false){
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 9) {
                            ForEach(0..<(project.rooms?.count ?? 0) , id: \.self) { index in
                                NavigationLink(destination: RoomDetailsView(roomType: .dry)) {
                                    VStack(alignment: .center, spacing: 5) {
                                        
                                        Text(project.rooms?[index].roomZone ?? "")
                                            .font(.custom(AppFonts.shared.name(.regular), size: 17))
                                            .foregroundColor(.black)
                                            .padding(.top,5)

                                        Text("\(project.rooms?[index].length ?? 0) * \(project.rooms?[index].width ?? 0 ) * \(project.rooms?[index].height ?? 0 )" + "M".localized())
                                            .font(.custom(AppFonts.shared.name(.regular), size: 14))
                                            .foregroundColor(Color(Asset.textGray.color))
                                        Text(String(format:"%.1f",project.rooms?[index].roomPrice ?? 0.0)+" LE".localized())
                                            .font(.custom(AppFonts.shared.name(.regular), size: 14))
                                            .foregroundColor(.black)
                                            .padding(.bottom,5)
                                    }
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color(Asset.secondaryBGColor.color))
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.init(Asset.lightGray.color), lineWidth: 1))
                                    
                                }

                            }
                        }.padding(.bottom)
                    }
                    
                }
                .padding([.leading,.trailing])
                
                Spacer()
                
                HStack {
                    Button {
                        viewModel.publishProject(projectId: projectId)
                    } label: {
                        MainButtonView(buttonTitle: "Confirm".localized(), buttonColor: .orange)
                    }
                    
                    Button {
                        NavigationUtil.popToPreviousTwoViewControllers()
                        
                    } label: {
                        ZStack{
                            HStack{
                                Spacer()
                                Image(Asset.editPen.name)
                                Text("Edit".localized())
                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                    .foregroundColor(Color(Asset.mainOrangeColor.color))
                                    .underline()
                                Spacer()
                            }
                            
                        }
                        .frame(width: 100, height: 48)
                        .background(Color(.white).opacity(0.7))
                        .cornerRadius(22)
                        .overlay(RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.init( (Asset.mainOrangeColor.name)), lineWidth: 1))
                        
                    }
                }
                .padding(.bottom)
                
            }
            .onChange(of: viewModel.isprojectPublished) { _, newValue in
                if newValue {
                    NavigationUtil.popToRootView()
                }
            }
            if viewModel.isLoading {
                ProgressView("Loading...".localized())
                    .foregroundColor(.white)
                    .progressViewStyle(WithBackgroundProgressViewStyle())
            } else if viewModel.isFailed {
                ProgressView()
                    .hidden()
            }
        }
        .onAppear{
            viewModel.getProjectData(projectId: projectId)
            AppState.shared.swipeEnabled = true

        }
        .navigationBarHidden(true)
        .toastView(toast: $viewModel.toast)
        .background(Color(Asset.mainBGColor.color))
    }
}

#Preview {
    AddProjectFinalStep(projectId: 1)
}
