//
//  AddRoomView.swift
//  Proffer
//
//  Created by M.Magdy on 07/03/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct AddRoomView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var toast: FancyToast? = nil
    @State var projectId: Int?
    @State var isEdit : Bool = false
    @State var roomID: Int?
    @State var isBackTapped: Bool = false
    @StateObject var viewModel = AddProjectVM()
    @State private var roomType: RoomType = .dry
    @State private var selectedList: [Bool] = Array(repeating: false, count: 9)
    @State private var selectedWetList: [Bool] = Array(repeating: false, count: 6)
    @State private var selectedAdditions: [RealAdditionsData] =  [
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),
        RealAdditionsData(id:0),]
    
    @State private var selectedCeil: RealMaterialsData?
    @State private var selectedFloor: RealMaterialsData?
    @State private var selectedWall: RealMaterialsData?
    
    @State private var isDropDownOpen: Bool? = false
    @State private var selectedZoneName: String = ""
    @State private var selectedZoneId: Int = 0
//  @State var roomDetails: RealRoomDetailsData?
    @State private var roomLength: String = ""
    @State private var roomWidth: String = ""
    @State private var roomHeight: String = ""
    @State private var roomDescription: String = ""
    @State private var totalPrice: Double?


    @State private var selectedRoomImages :[UIImage] = []
    @State private var isShowingImagesSheet = false
    @State private var sourceType: UIImagePickerController.SourceType?
    @State private var isShowingImagesPicker = false
    @State private var goToSelectMaterial: Bool  = false 
    @State var materialType: RoomMaterialItems = .floor
    
    @State private var outletAddtions: [RealAdditionsData]?
    @State private var acSwitctAddtions: [RealAdditionsData]?
    @State private var telePointAddtions: [RealAdditionsData]?
    @State private var dataPointAddtions: [RealAdditionsData]?
    @State private var bathTubAddtions: [RealAdditionsData]?
    @State private var waterSinkAddtions: [RealAdditionsData]?
    @State private var toiletCapinetAddtions: [RealAdditionsData]?
    @State private var waterMixerAddtions: [RealAdditionsData]?
    @State private var waterHeaterAddtions: [RealAdditionsData]?

    @State var allRoomsBudget: Double?
    @State var toBudget: Double?
    @State var isBudgetValid: Bool?
    @State var outOfBudgetDifference: Double?
    
    var roomDetails : RealRoomDetailsData {
        return viewModel.roomDetails
    }
    
    var comingAdditionsData: [RealAdditionsData] {
        return viewModel.roomAdditions
    }
    
    
    private var addButtonTitle: String {
        let totalPriceString = String(format: "%.2f", totalPrice ?? 0) // Format the totalPrice as a string
        
        let outOfBudgetString = String(format: "%.2f", outOfBudgetDifference ?? 0) // Format the totalPrice as a string
        if isBudgetValid ?? false {
            return "Add ".localized() + "\(totalPriceString)" + " LE".localized() // Return the button title
        }
        else {
            return "\(outOfBudgetString)" + " LE".localized() // Return the button title

        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBarView(title: isEdit ? "Edit Room".localized():"Add Room".localized() ,isBackTapped: $isBackTapped,color: .black)
                    .padding(.top,15)
                    .onChange(of: isBackTapped) { _, _ in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                ScrollView(showsIndicators: false){
                    HStack {
                        Text("Room Details".localized())
                            .textModifier(.regular, 27, .black)
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    .padding(.top)
                    HStack {
                        Text("Enter The Required Data".localized())
                            .textModifier(.light, 14, Color(Asset.textGray.color))
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    
                    Rectangle()
                        .fill(Color(Asset.mainOrangeColor.color))
                        .frame(width: UIScreen.main.bounds.width - 40,height: 1)
                    
                    //MARK: - Zone selection
                    DropdownSearchTF(placeHolder:"RoomZone".localized(),
                                     isOpen: $isDropDownOpen,
                                     text: $selectedZoneName, title: "RoomZone".localized(),
                                     options: $viewModel.roomZonesNames,
                                     submitLabel: .done,titleSize: 17)
                    .onChange(of: selectedZoneName) { _, newValue in
                        if let selectedZone = viewModel.roomZones.first(where: { $0.name == selectedZoneName }){
                            selectedZoneId = selectedZone.id ?? 0
                            roomType = RoomType(rawValue: (selectedZone.type ?? 0)) ?? .dry
                        }
                    }
                    .padding(.top,10)
                    
                    //MARK: - RoomSize view
                    HStack {
                        Text("Room Dimensions(M)".localized())
                            .textModifier(.regular, 17, Color(Asset.blackTitles.color))
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    .padding(.top)
                    
                    HStack {
                        MainAppTF(text: $roomLength, title: "Length".localized(), placeHolder: "Length".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad,titleSize:14)
                            .padding(.trailing,-10)
                            .onChange(of: roomLength) { _, _ in
                                calculateTotalPrice()
                            }
                        MainAppTF(text: $roomWidth, title: "Width".localized(), placeHolder: "Width".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad,titleSize:14)
                            .padding(.leading,-10)
                            .onChange(of: roomWidth) { _, _ in
                                calculateTotalPrice()
                            }
                        MainAppTF(text: $roomHeight, title: "Height".localized(), placeHolder:  "Height".localized(), validationType: .noValidation, submitLabel: .done, keyboardType: .numberPad,titleSize:14)
                            .padding(.leading,-10)
                            .onChange(of: roomHeight) { _, _ in
                                calculateTotalPrice()
                            }
                        
                    }
                    .padding(.top,10)
                    
                    
                    //MARK: - Room materials add view
                    HStack {
                        Text("Room Materials".localized())
                            .textModifier(.regular, 17, Color(Asset.blackTitles.color))
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    .padding(.top)
                    HStack {
                        Button {
                            if (roomHeight == "" || roomWidth == "" || roomLength == "" ){
                                self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please add Room area".localized())
                            }
                            else {
                                materialType = .floor
                                goToSelectMaterial = true
                            }
                        } label: {
                            RoomMaterialButton(image: Asset.floor.name, name: "Floor".localized(),material: $selectedFloor)
                                .onChange(of: selectedFloor) { _, _ in
                                    calculateTotalPrice()
                                }
                        }
                        Button {
                            if (roomHeight == "" || roomWidth == "" || roomLength == "" ){
                                self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please add Room area".localized())
                            }
                            else {
                                materialType = .cell
                                goToSelectMaterial = true
                            }

                        } label: {
                            RoomMaterialButton(image: Asset.cell.name, name: "Cell".localized(),material: $selectedCeil)
                                .onChange(of: selectedCeil) { _, _ in
                                    calculateTotalPrice()
                                }
                        }
                        
                        Button {
                            if (roomHeight == "" || roomWidth == "" || roomLength == "" ){
                                self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please add Room area".localized())
                            }
                            else {
                                materialType = .wall
                                goToSelectMaterial = true
                            }

                        } label: {
                            RoomMaterialButton(image: Asset.walls.name, name: "Wall".localized(),material: $selectedWall)
                                .onChange(of: selectedWall) { _, _ in
                                    calculateTotalPrice()
                                }
                        }
                    }
                    .navigationDestination(isPresented: $goToSelectMaterial) {
                        MaterialNameView(materialType: materialType, width: Float(roomWidth.convertDigitsToEng), height: Float(roomHeight.convertDigitsToEng), length: Float(roomLength.convertDigitsToEng),selectedCeil: $selectedCeil, selectedFloor: $selectedFloor, selectedWall: $selectedWall)
                    }
                    //MARK: - Description
                    HStack {
                        Text("Room Description".localized())
                            .textModifier(.regular, 17, Color(Asset.blackTitles.color))
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    .padding(.top)
                    
                    ZStack(alignment: .topLeading) {
                        if roomDescription == "" {
                            Text("Tell us more details you would like to add to this room.".localized())
                                .foregroundColor(Color(Asset.lightGray.color))
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 15)
                        }
                        TextEditor(text: $roomDescription)
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                            .frame(height: 90)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 10)
                            .transparentScrolling()
                    }
                    .frame(width:UIScreen.main.bounds.width - 40,height: 103)
                    .background(Color( Asset.textFieldBGColor.color))
                    .cornerRadius(15)
                    .shadow(radius: 1)
                    .padding(.top,-10)
                    
                    
                    //MARK: - Additions View
                    HStack {
                        Text("Additions".localized())
                            .textModifier(.regular, 17, Color(Asset.blackTitles.color))
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    .padding(.top)
                    VStack {
                        
                        if roomType == .dry {
                            VStack {
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $outletAddtions ,
                                                            selectedAddition: $selectedAdditions[0],
                                                            isSelected: $selectedList[0],
                                                            additionItem: .outlets)
                                .onChange(of: selectedList[0]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 0)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $acSwitctAddtions,
                                                            selectedAddition: $selectedAdditions[1],
                                                            isSelected: $selectedList[1],
                                                            additionItem: .acSwitch)
                                .onChange(of: selectedList[1]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 1)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $telePointAddtions,
                                                            selectedAddition: $selectedAdditions[2],
                                                            isSelected: $selectedList[2],
                                                            additionItem: .telePoint)
                                .onChange(of: selectedList[2]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 2)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $dataPointAddtions,
                                                            selectedAddition: $selectedAdditions[3],
                                                            isSelected: $selectedList[3],
                                                            additionItem: .dataPoint)
                                .onChange(of: selectedList[3]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 3)
                                    }
                                }
                                
                            }
                            .onAppear{
                                viewModel.getAdditions(category: "1,2,3,4")

                            }
                        }
                        else {
                            VStack {
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $outletAddtions ,
                                                            selectedAddition: $selectedAdditions[0],
                                                            isSelected: $selectedList[0],
                                                            additionItem: .outlets)
                                .onChange(of: selectedList[0]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 0)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $bathTubAddtions ,
                                                            selectedAddition: $selectedAdditions[4],
                                                            isSelected: $selectedList[4],
                                                            additionItem: .bathTub)
                                .onChange(of: selectedList[4]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 4)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $waterSinkAddtions,
                                                            selectedAddition: $selectedAdditions[5],
                                                            isSelected: $selectedList[5],
                                                            additionItem: .waterSink)
                                .onChange(of: selectedList[5]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 5)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $toiletCapinetAddtions ,
                                                            selectedAddition: $selectedAdditions[6],
                                                            isSelected: $selectedList[6],
                                                            additionItem: .toiletCapinet)
                                .onChange(of: selectedList[6]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 6)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $waterMixerAddtions ,
                                                            selectedAddition: $selectedAdditions[7],
                                                            isSelected: $selectedList[7],
                                                            additionItem: .waterMixer)
                                .onChange(of: selectedList[7]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 7)
                                    }
                                }
                                ExpandableAdditionsEditView(isEdit: isEdit,
                                                            comingData: $waterHeaterAddtions ,
                                                            selectedAddition: $selectedAdditions[8],
                                                            isSelected: $selectedList[8],
                                                            additionItem: .waterHeater)
                                .onChange(of: selectedList[8]) { _,newValue in
                                    if newValue {
                                        collapseOthers(in: &selectedList, except: 8)
                                    }
                                }
                                
                            }
                            .onAppear{
                                viewModel.getAdditions(category: "1,5,6,7,8,9")
                            }
                        }
                    }
                    
                    //MARK: - Add room Images
                    HStack {
                        Text("Room Images".localized())
                            .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                            .foregroundStyle(.black)
                        Spacer()
                        
                    }
                    .padding([.leading, .trailing])
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                       
                        let validateIndex = (roomDetails.roomImages?.count ?? 0 ) + (selectedRoomImages.count)
                        if validateIndex < 9 {
                            Button {
                                isShowingImagesSheet = true
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(Asset.mainOrangeColor.color).opacity(0.1))
                                        .cornerRadius(10)
                                        .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                                                .foregroundColor(Color(Asset.lightGray.color))
                                        )
                                    VStack {
                                        Spacer()
                                        Image(systemName: "plus")
                                            .foregroundColor(Color(Asset.lightGray.color))
                                        Text("Image".localized())
                                            .font(.custom(AppFonts.shared.name(AppFontsTypes.light), size: 12))
                                            .foregroundColor(Color(Asset.textGray.color))
                                        Spacer()
                                    }
                                }
                                .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                            }
                            .actionSheet(isPresented: $isShowingImagesSheet) {
                                ActionSheet(title: Text("Choose the file type you want to upload".localized()), buttons: [
                                    .default(Text("Image".localized())) {
                                        sourceType = .photoLibrary
                                        isShowingImagesPicker = true
                                    },
                                    .default(Text("Camera".localized())) {
                                        sourceType = .camera
                                        isShowingImagesPicker = true
                                    },
                                    .cancel()
                                ])
                            }
                            .sheet(isPresented: $isShowingImagesPicker) {
                                ImagePickerMultiSelection(sourceType: .photoLibrary, isMultiSelection: true, selectedImages: $selectedRoomImages, selectionNumber: (9 - ((roomDetails.roomImages?.count ?? 0 + selectedRoomImages.count))))
                            }
                        }
                        ForEach(0 ..< (roomDetails.roomImages?.count ?? 0), id: \.self) { index in
                                ZStack {
                                WebImage(url: URL(string: roomDetails.roomImages?[index].url ?? ""))
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(15)

                                    VStack {
                                        HStack {
                                            Spacer()

                                            Button {
                                                viewModel.deleteImage(imageId: roomDetails.roomImages?[index].id ?? 0, roomId: roomDetails.id ?? 0 )
                                            } label: {
                                                Image(Asset.multiplyDelete.name)
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .scaledToFit()
                                                    .shadow(radius: 10)
                                            }
                                            .padding(.top,-7)
                                            .padding(.trailing,-7)
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                            }
                         
                        let startIndex = roomDetails.roomImages?.count ?? 0
                        let selectedImagesCount = selectedRoomImages.count
                        let endIndex = (startIndex + selectedImagesCount)
                        ForEach( startIndex ..< endIndex, id: \.self) { index in
                                ZStack {
                                    Image(uiImage: selectedRoomImages[index - (roomDetails.roomImages?.count ?? 0)])
                                        .resizable()
                                        .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(15)
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Button {
                                                //Delete image from array
                                                selectedRoomImages.remove(at: (index - (roomDetails.roomImages?.count ?? 0)))
                                            } label: {
                                                Image(Asset.multiplyDelete.name)
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .scaledToFit()
                                                    .shadow(radius: 10)
                                            }
                                            .padding(.top,-7)
                                            .padding(.trailing,-7)
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(width: (UIScreen.main.bounds.width - 50 ) / 3 ,height: (UIScreen.main.bounds.width - 50 ) / 3)
                            }
                    }
                    .padding([.leading,.trailing],10)
                    .padding(.bottom,50)
                }
                VStack {
                    Button {
                        if isBudgetValid ??  false{
                            viewModel.validateAddRoom(roomId: roomID ?? 0, projectId: projectId ?? 0 , isEdit: isEdit, selectedZoneId: selectedZoneId, length: roomLength, width: roomWidth, height: roomHeight, wallMaterial: selectedWall ??  RealMaterialsData(), ceilMaterial: selectedCeil ??  RealMaterialsData(), floorMaterial: selectedFloor ??  RealMaterialsData(), description: roomDescription, additions: selectedAdditions, roomImages: selectedRoomImages)
                        }
                        else  {
                            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "You are out of budget".localized())
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(addButtonTitle)
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 18))
                                .foregroundStyle(Color(.white))
                                .frame(height: 48)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(Color((isBudgetValid ?? false ) ? Asset.mainOrangeColor.name : Asset.secondBlueColor.name))
                        .frame(width: 220)
                        .cornerRadius(18)
                        .padding(.bottom)
                        .onChange(of: viewModel.isAddEditRoomFinished) { _, newValue in
                            if newValue == true {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }  

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
        .onChange(of: comingAdditionsData, { _, _ in
            outletAddtions = comingAdditionsData.filter { $0.category == 1 }
            acSwitctAddtions = comingAdditionsData.filter { $0.category == 2 }
            telePointAddtions = comingAdditionsData.filter { $0.category == 3 }
            dataPointAddtions = comingAdditionsData.filter { $0.category == 4 }
            bathTubAddtions = comingAdditionsData.filter { $0.category == 5 }
            waterSinkAddtions = comingAdditionsData.filter { $0.category == 6 }
            toiletCapinetAddtions = comingAdditionsData.filter { $0.category == 7 }
            waterMixerAddtions = comingAdditionsData.filter { $0.category == 8 }
            waterHeaterAddtions = comingAdditionsData.filter { $0.category == 9 }
        })
        .onChange(of: roomDetails, { _, _ in
            roomHeight = "\(roomDetails.height ?? 0)"
            roomWidth = "\(roomDetails.width ?? 0)"
            roomLength = "\(roomDetails.length ?? 0)"
            selectedCeil = roomDetails.materials?.first { $0.category == 1 }
            selectedFloor = roomDetails.materials?.first { $0.category == 2 }
            selectedWall = roomDetails.materials?.first { $0.category == 3 }
            selectedAdditions[0] = roomDetails.additions?.first { $0.category == 1} ?? RealAdditionsData()
            selectedAdditions[1] = roomDetails.additions?.first { $0.category == 2} ?? RealAdditionsData()
            selectedAdditions[2] = roomDetails.additions?.first { $0.category == 3} ?? RealAdditionsData()
            selectedAdditions[3] = roomDetails.additions?.first { $0.category == 4} ?? RealAdditionsData()
            selectedAdditions[4] = roomDetails.additions?.first { $0.category == 5} ?? RealAdditionsData()
            selectedAdditions[5] = roomDetails.additions?.first { $0.category == 6} ?? RealAdditionsData()
            selectedAdditions[6] = roomDetails.additions?.first { $0.category == 7} ?? RealAdditionsData()
            selectedAdditions[7] = roomDetails.additions?.first { $0.category == 8} ?? RealAdditionsData()
            selectedAdditions[8] = roomDetails.additions?.first { $0.category == 8} ?? RealAdditionsData()
            selectedZoneName = roomDetails.roomZone?.name ?? ""
            roomDescription = roomDetails.description ?? ""

        })
        .onChange(of: selectedAdditions, { _, _ in
            calculateTotalPrice()
        })
        .onAppear{
            
            calculateTotalPrice()
            viewModel.getRoomZones()
            if isEdit {
                viewModel.showRoomDetails(roomId: roomID ?? 0)
            }
            AppState.shared.swipeEnabled = true

        }
        .toastView(toast: $toast)
        .toastView(toast: $viewModel.toast)
        .navigationBarHidden(true)
        .background(Color(Asset.mainBGColor.color))
    }
    
    
    private func calculateTotalPrice (){
        var doubleLength: Double = 0
        var doubleWidth: Double = 0
        var doubleHeight: Double = 0

        if let double = Double(roomLength.convertDigitsToEng) {
            doubleLength = double
        }
        if let double = Double(roomWidth.convertDigitsToEng) {
            doubleWidth = double
        }
        if let double = Double(roomHeight.convertDigitsToEng) {
            doubleHeight = double
        }
        
        let wallArea = 2 * ( doubleLength + doubleWidth ) * (doubleHeight)
        let floorCeilArea = doubleLength * doubleWidth
        
        let wallPrice = wallArea * (selectedWall?.price ?? 0)
        let floorPrice = floorCeilArea * (selectedFloor?.price ?? 0)
        let ceilPrice = floorCeilArea * (selectedCeil?.price ?? 0)
        var totalAdiitionPrice: Double = 0.0
          
        for addition in selectedAdditions {
            if let price = addition.price, let quantity = addition.quantity {
                totalAdiitionPrice += price * Double(quantity)
            }
        }
        
        totalPrice = wallPrice + floorPrice + ceilPrice + totalAdiitionPrice
        if toBudget == 0 {
            isBudgetValid = true
        }
        else  {
            outOfBudgetDifference = (toBudget ?? 0) - ((allRoomsBudget ?? 0) + (totalPrice ?? 0))
            isBudgetValid = outOfBudgetDifference ?? 0 < 0 ? false : true
        }
    }
    
    
    private func collapseOthers(in list: inout [Bool], except index: Int) {
        for i in list.indices {
            if i != index {
                list[i] = false
            }
        }
    }
}



#Preview {
    AddRoomView( isEdit: false)
}


