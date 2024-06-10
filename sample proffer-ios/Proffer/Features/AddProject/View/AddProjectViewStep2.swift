//
//  AddProjectViewStep2.swift
//  Proffer
//
//  Created by M.Magdy on 04/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI

struct AddProjectViewStep2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isEdit: Bool
    @State var isBackTapped: Bool = false
    @State var projectId: Int?
    @StateObject var viewModel = AddProjectVM()
    @State var isGoingToAddRoom: Bool = false
    @State var isGoingToFinalStep: Bool = false
    @State var isGoingToEditRoom: Bool = false
    @State var selectedRoomId: Int?
    
    @State var allRoomsBudget: Double?
    @State var toBudget: Double?
    
    var rooms: RealShowProjectRoomsData {
        return viewModel.projectRooms
    }

    var totalPrice: Double {
        return viewModel.projectRooms.totalBudget ?? 0
    }
    
    private var addButtonTitle: String {
        let totalPriceString = String(format: "%.2f", totalPrice)
        return "Save ".localized() + "\(totalPriceString)" + " LE".localized()
    }

    var projectDetails: RealShowProjectByIdData {
        return viewModel.projectData
    }

    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(title: isEdit ?  "Edit Project".localized() : "Add Project".localized(), isBackTapped: $isBackTapped, color: .black)
                    .padding(.top, 15)
                    .onChange(of: isBackTapped) { _, _ in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Enter The Required Data".localized())
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        ZStack {
                            VStack {
                                Image(Asset.checkMarkOrange.name)
                                Text("Project Info".localized())
                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                    .foregroundStyle(Color(Asset.mainOrangeColor.color))
                            }
                        }
                        .frame(width: 133, height: 87)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.init(Asset.mainOrangeColor.color), lineWidth: 1))
                        Spacer()
                        ZStack {
                            VStack {
                                Image(Asset.checkMarkOrangeFill.name)
                                Text("Project Details".localized())
                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                    .foregroundStyle(Color(Asset.mainOrangeColor.color))
                            }
                        }
                        .frame(width: 133, height: 87)
                        .background(Color(.white).opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.init(Asset.mainOrangeColor.color), lineWidth: 1))
                        Spacer()
                    }
                    Divider()
                        .padding()
                    Button {
                        isGoingToAddRoom = true
                    } label: {
                        ZStack {
                            HStack {
                                Spacer()
                                Text("+ New Room".localized())
                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                                    .foregroundStyle(Color(Asset.mainOrangeColor.color))
                                Spacer()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 57)
                        .background(Color(.white).opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.init(Asset.mainOrangeColor.color), lineWidth: 1))
                    }
                    .padding(.bottom)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(0..<((rooms.rooms?.count ?? 0)), id: \.self) { index in
                            ZStack {
//                                Rectangle()
//                                    .fill(Color(Asset.mainOrangeColor.color).opacity(0.1))
//                                    .cornerRadius(15)
//                                    .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 140)
//
                                
                                VStack {
                                    Spacer()
                                    Text("\(rooms.rooms?[index].roomZone ?? "")".localized())
                                        .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                                        .foregroundColor(.black)
                                        .padding(.top,5)

                                    Text("\(rooms.rooms?[index].length ?? 0)*\(rooms.rooms?[index].width ?? 0)*\(rooms.rooms?[index].height ?? 0) M²".localized())
                                        .font(.custom(AppFonts.shared.name(AppFontsTypes.light), size: 14))
                                        .foregroundColor(Color(Asset.gray.color))
                                    Text("\(rooms.rooms?[index].roomPrice ?? 0) LE".localized())
                                        .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                        .foregroundColor(.black)
                                    
                                    Button {
                                        selectedRoomId = rooms.rooms?[index].id
                                        isGoingToEditRoom = true
                                    } label: {
                                        ZStack {
                                            HStack {
                                                Spacer()
                                                Image(Asset.editPen.name)
                                                Text("Edit".localized())
                                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                                    .foregroundColor(Color(Asset.mainOrangeColor.color))
                                                    .underline()
                                                Spacer()
                                            }
                                        }
                                        .frame(width: 70, height: 30)
                                        .background(Color(.white).opacity(0.7))
                                        .cornerRadius(10)
                                    }
                                    .padding(.bottom)
                                }
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                                .frame(maxHeight: .infinity)
                                .background(Color(Asset.mainOrangeColor.color).opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                                        .foregroundColor(Color(Asset.lightGray.color))
                                )
                              
                            }
                            .frame(maxHeight: .infinity)

                        }
                    }
                }
                Spacer()
                VStack {
                    Button {
                        isGoingToFinalStep = true
                    } label: {
                        HStack {
                            Spacer()
                            Text(addButtonTitle)
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 18))
                                .foregroundStyle(Color(.white))
                                .frame(height: 48)
//                                .padding(.bottom)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(Color(Asset.mainOrangeColor.name))
                        .frame(width: 220)
                        .cornerRadius(18)
                    }
                }
            }
            .padding([.leading, .trailing])
            .navigationDestination(isPresented: $isGoingToAddRoom) {
                AddRoomView(projectId: projectId,allRoomsBudget: allRoomsBudget,toBudget: toBudget)
            }
            .navigationDestination(isPresented: $isGoingToEditRoom) {
                AddRoomView(projectId:projectId, isEdit: true, roomID: selectedRoomId,allRoomsBudget: allRoomsBudget,toBudget: toBudget)
            }
            .navigationDestination(isPresented: $isGoingToFinalStep) {
                AddProjectFinalStep(projectId: projectId ?? 0)
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
        .onAppear {
            viewModel.getRooms(projectId: projectId ?? 0)
            AppState.shared.swipeEnabled = true
            isEdit = true
        }
        .toastView(toast: $viewModel.toast)
        .navigationBarHidden(true)
        .background(Color(Asset.mainBGColor.color))
    }
}

//#Preview {
//    AddProjectViewStep2(isEdit: false)
//}
