//
//  AddProjectViewStep1.swift
//  Proffer
//
//  Created by M.Magdy on 27/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddProjectViewStep1: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = AddProjectVM()
    @State var isBackTapped: Bool = false
    
    @State var isEdit : Bool
    @State private var selectedProjectImage: UIImage?
    @State private var selectedProjectImageUrl: String?
    @State private var projectName: String = ""
    @State private var projectKind:String = ""
    @State private var projectKindID: Int = 0
    @State private var projectArea: String = ""
    @State private var isOpenBudget:Bool = false
    @State var isDropDownActive: Bool? = false
    @State private var showMap = false
    @State private var clientLocationCatched :String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var showLocationDeniedAlert = false
    @State private var clientLocation: String = ""
    @State private var fromBudget: String = ""
    @State private var toBudget: String = ""
    @State private var duration: String = ""
    @State private var startDateString: String = ""
    @State var startDate : Date?
    @FocusState private var focusedField: FormField?
    @State var isDropDownOpen : Bool? = false
    @State var isStep1Success: Bool = false
    @State var projectId: Int = 0
    var projectDetails: RealShowProjectByIdData {
        return viewModel.projectData
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    NavigationBarView(title: isEdit ? "Edit Project".localized():"Add Project".localized() ,isBackTapped: $isBackTapped,color: .black)
                        .padding(.top,15)
                        .onChange(of: isBackTapped) { _, _ in
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    ScrollView(showsIndicators: false){
                        HStack {
                            Text("Enter The Required Data".localized())
                                .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding([.leading,.trailing])
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
                            .frame(width: 133,height: 87)
                            .background(Color(.white).opacity(0.5))
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.init(Asset.mainOrangeColor.color), lineWidth: 1))
                            Spacer()
                            ZStack {
                                VStack {
                                    Image(Asset.checkMarkBlack.name)
                                    Text("Project Details".localized())
                                        .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 14))
                                        .foregroundStyle(Color(.blackTitles))
                                }
                            }
                            .frame(width: 133,height: 87)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.init(Asset.mainOrangeColor.color), lineWidth: 1))
                            Spacer()
                            
                        }
                        .padding([.leading,.trailing])
                        Divider()
                            .padding()
                        UploadFileView(selectedImage: $selectedProjectImage, imageURL: $selectedProjectImageUrl,title: "Project Image".localized(),isShowFromEdit: isEdit)
                            .frame(height: 127)
                            .padding([.leading,.trailing],20)
                            .padding([.top,.bottom],7)
                        
                        MainAppTF(text: $projectName, title: "Project Name".localized(), placeHolder: "Project Name".localized(), validationType: .name, submitLabel: .next, keyboardType: .default)
                            .focused($focusedField, equals: .projectName)
                            .padding(.top,10)
                        DropdownSearchTF( placeHolder:  "project Kind".localized(), isOpen: $isDropDownOpen, text: $projectKind, title: "project Kind".localized(), options: $viewModel.projectKindsString, submitLabel: .next,titleSize: 17)
                            .focused($focusedField, equals: .projectKind)
                            .padding(.bottom,20)
                        
                        MainAppTF(text: $projectArea, title: "Project Area(m²)".localized(), placeHolder: "Project Area".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad)
                            .focused($focusedField, equals: .projectArea)
                            .padding(.bottom,5)
                        
                        HStack(spacing:0) {
                            if clientLocationCatched != "" {
                                MainAppTF( text:$clientLocationCatched , title: "Location".localized(), placeHolder: "Location".localized(), validationType: .address,submitLabel: .next,
                                           keyboardType: .default)
                                .focused($focusedField, equals: .projectLocation)
                                
                            }else{
                                MainAppTF( text:$clientLocationCatched , title: "Location".localized(), placeHolder: "Location".localized(), validationType: .address,submitLabel: .next,
                                           keyboardType: .default)
                                .focused($focusedField, equals: .projectLocation)
                                
                            }
                            Button {
                                checkLocationAuthorization()
                            } label: {
                                Image(Asset.getLocationIcon.name)
                                    .resizable()
                                    .frame(width: 57, height: 57)
                                    .padding(.trailing)
                                //                            .padding(.top,10)
                            }
                        }
                        VStack(spacing: 0) {
                            HStack {
                                Text("Project Budget".localized())
                                    .font(.custom(AppFonts.shared.name(AppFontsTypes.regular), size: 17))
                                    .foregroundStyle(Color(Asset.blackTitles.name))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            HStack {
                                MainAppTF(text: $fromBudget, title: "", placeHolder: "From".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad)
                                    .padding(.trailing,!isOpenBudget ? -10 : 0)
                                    .focused($focusedField, equals: .fromBudget)
                                
                                if !isOpenBudget {
                                    MainAppTF(text: $toBudget, title: "", placeHolder: "To".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad)
                                        .padding(.leading,-10)
                                        .focused($focusedField, equals: .toBudget)
                                }
                            }
                            .padding(.top,-5)
                        }
                        HStack {
                            Button(action: {
                                // Toggle the state of the checkbox
                                self.isOpenBudget.toggle()
                            }) {
                                Image(systemName: isOpenBudget ? "checkmark.square" : "square")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .foregroundColor(isOpenBudget ? .blackTitles : .blackTitles)
                            Text("Open Budget".localized())
                                .textModifier(.regular, 14, .blackTitles)
                            Spacer()
                        }
                        .padding(.leading)
                        HStack{
                            ZStack {
                                MainAppTF(text: $duration, title: "Duration".localized(), placeHolder: "Duration".localized(), validationType: .noValidation, submitLabel: .next, keyboardType: .numberPad)
                                    .focused($focusedField, equals: .duration)
                                
                                HStack {
                                    Spacer()
                                    Text("Day".localized())
                                        .padding(.trailing,30)
                                }
                                .padding(.top,10)
                            }
                            
                            .padding(.trailing,-10)
                            DateTF(title: "Start date".localized(), image: Asset.calendarIcon.image, currentIsMinDate: true, submitLabel: .next, placeHolder: "Date".localized(), text: $startDateString, date: $startDate)
                                .padding(.leading,-10)
                                .focused($focusedField, equals: .startDate)
                                .padding(.top,-20)
                        }
                        .padding(.top,10)
                        Button {
                            viewModel.validateInputs(projectImage: selectedProjectImage ?? UIImage(),projectImageString:selectedProjectImageUrl ?? "", projectName: projectName, projectKind: projectKind, projectArea: projectArea, lat: latitude, long: longitude, address: clientLocationCatched, fromBudget: fromBudget, toBudget: toBudget, openBudget: isOpenBudget, duration: duration, startDateString: startDateString, isEdit: isEdit, projectId: projectId)
                        } label: {
                            MainButtonView(buttonTitle: "Step 2".localized(), buttonColor: .orange)
                        }
                        .onChange(of: viewModel.isStep1Success, { _, newValue in
                            if newValue {
                                projectId = viewModel.projectID
                            }
                        })
                        .navigationDestination(isPresented: $isStep1Success) {
                            
                            AddProjectViewStep2(isEdit: $isEdit,projectId: projectId, allRoomsBudget:projectDetails.totalBudget, toBudget: viewModel.toBudget)
                        }
                        
                        Spacer()
                    }
                }
                .onReceive(viewModel.$isStep1Success) { success in
                    success  ? isStep1Success = true : ()
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .keyboardResponsive()
                .onSubmit{
                    showNextTextField()
                }
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Button("Done".localized()){
                            hideKeyboard()
                        }
                        Spacer()
                        Button(action: {
                            showPerviousTextField()
                        }, label: {
                            Image(systemName: "chevron.up").foregroundColor(.blue)
                        })
                        
                        Button(action: {
                            showNextTextField()
                        }, label: {
                            Image(systemName: "chevron.down").foregroundColor(.blue)
                        })
                    }
                }
                
                .sheet(isPresented: $showMap) {
                    MapView(address: $clientLocationCatched, latitude: $latitude, longitude: $longitude)
                }
                .alert(isPresented: $showLocationDeniedAlert) {
                    Alert(
                        title: Text("Location Access Denied".localized()),
                        message: Text("To use this feature, please enable location access in Settings.".localized()),
                        primaryButton: .default(Text("Settings".localized()), action: openSettings),
                        secondaryButton: .cancel()
                    )
                }
                .onTapGesture {
                    isDropDownActive = false
                }
                .onChange(of: projectDetails, { oldValue, newValue in
                    selectedProjectImageUrl = projectDetails.projectImage ?? ""
                    projectName = projectDetails.name ?? ""
                    projectKind = projectDetails.projectType?.name ?? ""
                    projectId = projectDetails.id ?? 0
                    projectArea = "\(projectDetails.area ?? 0)"
                    projectKindID = projectDetails.projectType?.id ?? 0
                    isOpenBudget = projectDetails.isOpenBudget == 1 ? true : false
                    clientLocationCatched = projectDetails.location ?? ""
                    if let latString = projectDetails.lat, let lat = Double(latString) {
                        latitude = lat
                    }
                    if let longString = projectDetails.long, let long = Double(longString) {
                        longitude = long
                    }
                    clientLocation = projectDetails.location ?? ""
                    fromBudget = "\(projectDetails.fromBudget ?? 0)"
                    toBudget = "\(projectDetails.toBudget ?? 0)"
                    duration = "\(projectDetails.duration ?? 0)"
                    startDateString = projectDetails.startDate ?? ""
                })
                .onAppear{
                    viewModel.getProjectTypes()
                    if isEdit {
                        viewModel.getProjectData(projectId: projectId)
                        
                    }
                    AppState.shared.swipeEnabled = true
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
            .onTapGesture {
                hideKeyboard()
            }
            .toastView(toast: $viewModel.toast)
            .navigationBarHidden(true)
            .background(Color(Asset.mainBGColor.color))
        }
    }
    private func checkLocationAuthorization() {
        clientLocationCatched = ""
        clientLocation = ""
        let status = CLLocationManager().authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            showMap = true
        case .denied, .restricted:
            showLocationDeniedAlert = true
        case .notDetermined:
            requestLocationAuthorization()
        @unknown default:
            break
        }
    }
    
    private func requestLocationAuthorization() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    func showNextTextField(){
        switch focusedField {
        case .projectName:
            focusedField = .projectKind
        case .projectKind:
            focusedField = .projectArea
        case .projectArea:
            focusedField = .projectLocation
        case .projectLocation:
            focusedField = .fromBudget
        case .fromBudget:
            focusedField = isOpenBudget ?  .duration : .toBudget
        case .toBudget:
            focusedField = .duration
        case .duration:
            focusedField = .startDate
        default:
            focusedField = nil
        }
    }
    
    func showPerviousTextField(){
        switch focusedField {
        case .startDate:
            focusedField = .duration
        case .duration:
            focusedField = isOpenBudget ? .fromBudget : .toBudget
        case .toBudget:
            focusedField = .fromBudget
        case .fromBudget:
            focusedField = .projectLocation
        case .projectLocation:
            focusedField = .projectArea
        case .projectArea:
            focusedField = .projectKind
        case .projectKind:
            focusedField = .projectName
        default:
            focusedField = nil
        }
    }
    
    enum FormField {
        case projectName,projectKind, projectArea, projectLocation, fromBudget, toBudget, duration, startDate
    }
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    AddProjectViewStep1( isEdit: false)
}
