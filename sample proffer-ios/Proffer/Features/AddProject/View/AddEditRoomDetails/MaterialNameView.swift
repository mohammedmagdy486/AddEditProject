//Proffer
//MaterialNameView.swift

//Created by: Mohammed Magdy on 3/11/24


import SwiftUI
import SDWebImageSwiftUI

struct MaterialNameView: View {
    @StateObject var viewModel = AddProjectVM()
    @State var isBackTapped: Bool = false
    @State private var selectedMaterialID: Int?
    @State var materialType: RoomMaterialItems = .floor
    @State var width: Float?
    @State var height: Float?
    @State var length: Float?
    @State var unitPrice: Float?
    @State var area: Float?
    @State var totalPrice: Double?
    @Binding var selectedCeil: RealMaterialsData?
    @Binding var selectedFloor: RealMaterialsData?
    @Binding var selectedWall: RealMaterialsData?
    @State var materials: [RealMaterialsData]?
    @State var previouslySelectedMaterial: RealMaterialsData?
    
    private var addButtonTitle: String {
        let totalPriceString = String(format: "%.1f", totalPrice ?? 0)
        return "Add ".localized() + " \(totalPriceString)"
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(title: "Material Name".localized(), isBackTapped: $isBackTapped, color: .black)
                    .padding(.top, 15)
                    .onChange(of: isBackTapped) { _, _ in
                        self.presentationMode.wrappedValue.dismiss()
                        switch materialType {
                        case .floor:
                            selectedFloor = previouslySelectedMaterial
                        case .cell:
                            selectedCeil = previouslySelectedMaterial
                        case .wall:
                            selectedWall = previouslySelectedMaterial
                        }
                    }
                Text("Select Your Favorites Material".localized())
                    .textModifier(.regular, 17, Color(Asset.textGray.color))
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(materials ?? []) { material in
                                MaterialView(material: material, isSelected: material.id == selectedMaterialID) {
                                    selectedMaterialID = material.id
                                    totalPrice = (Double(material.price ?? 0)) * Double(area ?? 0)
                                    switch materialType {
                                    case .floor:
                                        selectedFloor = material
                                    case .cell:
                                        selectedCeil = material
                                    case .wall:
                                        selectedWall = material
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text(addButtonTitle)
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 18))
                            .foregroundStyle(Color(.white))
                            .frame(height: 48)
                        Spacer()
                    }
                    .frame(height: 48)
                    .background(Color(Asset.mainOrangeColor.name))
                    .frame(width: 220)
                    .cornerRadius(18)
                })
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
            viewModel.getMaterial(category: materialType) {
                materials = viewModel.roomMaterials
            }
            switch materialType {
            case .cell:
                previouslySelectedMaterial = selectedCeil
                area = (length ?? 0) * (width ?? 0)
            case .floor:
                previouslySelectedMaterial = selectedFloor
                area = (length ?? 0) * (width ?? 0)
            case .wall:
                previouslySelectedMaterial = selectedWall
                area = 2 * ((length ?? 0) + (width ?? 0)) * (height ?? 0)
            }
        }
        .navigationBarHidden(true)
        .background(Color(Asset.mainBGColor.color))
    }
}

struct MaterialView: View {
    var material: RealMaterialsData
    var isSelected: Bool
    var selectAction: () -> Void
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: material.materialImage ?? ""))
                .resizable()
                .frame(width: 147, height: 147)
                .overlay(
                    VStack(spacing: 80) {
                        Spacer()
                        ZStack(alignment: .bottom) {
                            Image(Asset.roomDetailShadow.name)
                                .resizable()
                            VStack(spacing: 0) {
                                Spacer()
                                Text(material.name ?? "")
                                    .padding(5)
                                Text(String(format: "%.1f", material.price ?? 0))
                                    .padding(5)
                            }
                            .textModifier(.regular, 13, .white)
                        }
                    }
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(Asset.mainOrangeColor.color), lineWidth: isSelected ? 3 : 0)
                )
                .onTapGesture {
                    selectAction()
                }
        }
        .onAppear {
            AppState.shared.swipeEnabled = true
        }
    }
}

