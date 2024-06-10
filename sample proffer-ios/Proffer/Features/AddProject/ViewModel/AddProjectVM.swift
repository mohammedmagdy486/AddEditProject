//
//  AddProjectVM.swift
//  Proffer
//
//  Created by M.Magdy on 29/02/2024.
//  Copyright © 2024 Nura. All rights reserved.
//

import SwiftUI


final class AddProjectVM : ObservableObject {
    
    @Published var toast: FancyToast? = nil
    @Published private var _isLoading = false
    @Published private var _isFailed = false
    @Published private var _projects : [RealShowProjectsData] = []
    @Published private var _projectData : RealShowProjectByIdData?
    
    @Published private var _projectKinds : [RealProjectTypesData] = []
    @Published var projectKindsString: [String] = []
    @Published var isStep1Success: Bool = false
    @Published private var _projectRooms: RealShowProjectRoomsData?
    @Published private var _roomDetails: RealRoomDetailsData?
    
    @Published private var _roomZones: [RealRoomZonesData] = []
    @Published private var _roomZonesNames: [String] = []
    @Published private var _projectID: Int = 0
    @Published private var _roomMaterials: [RealMaterialsData] = []
    @Published private var _roomAdditions: [RealAdditionsData] = []
    @Published private var _isAddEditRoomFinished : Bool = false
    @Published var _isprojectPublished: Bool = false
    @Published private var _toBudget: Double = 0
    
    private var token = ""
    let api: RealProjectProtocol = RealProjectApi()
    
    private var _message: String = ""
    var isLoading: Bool {
        get { return _isLoading}
    }
    var message : String {
        get { return _message}
    }
    var projectKinds : [RealProjectTypesData] {
        get { return _projectKinds}
    }
    var isFailed: Bool {
        get { return _isFailed}
    }
    
    
    var projectRooms : RealShowProjectRoomsData {
        get {
            return _projectRooms ?? RealShowProjectRoomsData()
        }
    }
    var roomZones: [RealRoomZonesData] {
        get {return _roomZones }
    }
    var roomZonesNames: [String] {
        get {
            return  self._roomZones.map {$0.name ?? ""}
            //            return _roomZonesNames
        }
        set{}
    }
    var projectData: RealShowProjectByIdData {
        get{
            return _projectData ?? RealShowProjectByIdData()
        }
    }
    var roomDetails: RealRoomDetailsData {
        get{
            return _roomDetails ?? RealRoomDetailsData ()
        }
    }
    
    var projectID :Int{
        get {
            return _projectID
        }
    }
    var roomMaterials: [RealMaterialsData] {
        get {
            return _roomMaterials
        }
    }
    
    var roomAdditions: [RealAdditionsData] {
        get {
            return _roomAdditions
        }
    }
    
    var isAddEditRoomFinished : Bool {
        return _isAddEditRoomFinished
    }
    var isprojectPublished: Bool {
        return _isprojectPublished
    }
    var toBudget: Double {
        return _toBudget
    }
    
    
    func validateInputs(projectImage: UIImage,projectImageString: String , projectName: String,projectKind: String,projectArea: String, lat : Double, long: Double, address: String,fromBudget: String, toBudget: String, openBudget:Bool,duration: String, startDateString: String,isEdit: Bool, projectId:Int) {
        if projectImage == UIImage() && projectImageString == "" {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please select project image".localized())
        }
        else if projectKind.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project kind".localized())
        }
        else if projectName.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project name".localized())
        }
        else if projectArea.isBlank  {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project area".localized())
        }
        else if address.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project address".localized())
        }
        else if lat == 0.0 {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please get project location from map".localized())
        }
        else if fromBudget.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project start budget".localized())
        }
        else if !openBudget {
            if toBudget.isBlank {
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter project start budget".localized())
            }
            else {
                var projectKindID : Int = 0
                if let selectedProjectKindId = projectKinds.first(where: { $0.name == projectKind }) {
                    projectKindID = selectedProjectKindId.id ?? 0
                }
                var projectImageSent = projectImage
                if isEdit && projectImage == UIImage() {
                    projectImageString.toUIImage(completion: { image in
                        if let image = image {
                            projectImageSent = image
                        } else {
                            print("Image conversion failed")
                        }
                    })
                }
                
                
                let param: [String : Any]  = [
                    
                    "name":projectName,
                    "project_type_id": projectKindID,
                    "area": Int(projectArea.convertDigitsToEng) ?? 0,
                    "lat": "\(lat)",
                    "long":  "\(long)",
                    "location": address,
                    "from_budget": Int(fromBudget.convertDigitsToEng) ?? 0,
                    "to_budget": openBudget ?  "" : Int(toBudget.convertDigitsToEng) ?? 0,
                    "is_open_budget" : openBudget ? 1 : 0 ,
                    "duration" : Int(duration.convertDigitsToEng) ?? 0.0,
                    "start_date": startDateString
                ]
                //  isStep1Success = true // for test only
                addProjectStep1(param: param,isEdit:isEdit, image: projectImageSent, projectId: projectId )
            }
            
        }
        else {
            var projectKindID : Int = 0
            if let selectedProjectKindId = projectKinds.first(where: { $0.name == projectKind }) {
                projectKindID = selectedProjectKindId.id ?? 0
            }
            var projectImageSent = projectImage
            if isEdit && projectImage == UIImage() {
                projectImageString.toUIImage(completion: { image in
                    if let image = image {
                        projectImageSent = image
                    } else {
                        print("Image conversion failed")
                    }
                })
            }
            
            
            
            let param: [String : Any]  = [
                
                "name":projectName,
                "project_type_id": projectKindID,
                "area": Int(projectArea.convertDigitsToEng) ?? 0,
                "lat": "\(lat)",
                "long":  "\(long)",
                "location": address,
                "from_budget": Int(fromBudget.convertDigitsToEng) ?? 0,
                "is_open_budget" : 1 ,
                "duration" : Int(duration.convertDigitsToEng) ?? 0,
                "start_date": startDateString
            ]
            //            isStep1Success = true // for test only
            addProjectStep1(param: param,isEdit:isEdit, image: projectImageSent, projectId: projectId )
        }
    }
    
    func  getProjectData(projectId:Int)  {
        self._isLoading = true
        api.showProjectData(projectId: projectId) { [weak self] (Result) in
            guard let self = self else {return}
            switch Result {
            case .success(let Result):
                self._isLoading = false
                self._isFailed = false
                guard   let result = Result else {return}
                self._projectData = result.data
                self._projectID = result.data?.id ?? 0

            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    
    func getProjectTypes(){
        self._isLoading = true
        api.getProjectTypes {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._projectKinds = response?.data ?? []
                self.projectKindsString = self._projectKinds.map { $0.name ?? ""}
                self._isLoading = false
                self._isFailed = false
                
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    
    private func  addProjectStep1(param:[String:Any],isEdit: Bool,image: UIImage,projectId:Int){
        var params:[String:Any] = param
        self._isLoading = true
        var path :String = "clients/projects"
        if isEdit {
            params.updateValue("PUT", forKey: "_method")
            path = "clients/projects/\(projectId)"
        }
        MultipartUploadImageWithModel.shared.uploadImage (path: path, pdfUrl: [:], parameterS: params, photos: ["project_image":image], responseClass: CreateProjectModel.self){
            [weak self] (Result) in
            guard let self = self else {return}
            switch Result {
            case .success(let Result):
                guard  let data = Result else {return}
                self._isLoading = false
                self._isFailed = false
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: data.message ?? "")
                if Result?.data?.id ?? 0 !=  0 {
                    self._projectID = Result?.data?.id ?? 0
                }
                
                self._toBudget = Result?.data?.isOpenBudget == "0" ? Result?.data?.toBudget ?? 0 : 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isStep1Success = true
                }
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
                
            }
        }
    }
    func deleteImage(imageId:Int,roomId: Int){
        self._isLoading = true
        api.deleteRoomImage(imageId: imageId) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: self._message)
                self.showRoomDetails(roomId: roomId)
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    func getRooms(projectId:Int){
        self._isLoading = true
        api.showProjectRooms(projectId: projectId) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._projectRooms = response?.data
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    func showRoomDetails(roomId:Int){
        self._isLoading = true
        api.showRoomDetails(roomId: roomId) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._roomDetails = response?.data
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    func getRoomZones(){
        self._isLoading = true
        api.getRoomZones {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._roomZones = response?.data ?? []
                self._roomZonesNames = self._roomZones.map {$0.name ?? ""}
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    func getMaterial(category: RoomMaterialItems,completion: @escaping () -> Void) {
        let category = category == .cell ? 1 : (category == .floor ? 2 : 3)
        self._isLoading = true
        api.getMaterials(category: category) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._roomMaterials = response?.data ?? []
                completion()
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    
    
    func getAdditions(category:String) {
        self._isLoading = true
        api.getadditions(category: category) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._roomAdditions = response?.data ?? []
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    
    
    
    //MARK: - Add room request and valiadation
    func validateAddRoom (roomId: Int, projectId: Int, isEdit: Bool,selectedZoneId: Int, length:String, width: String, height: String, wallMaterial: RealMaterialsData, ceilMaterial: RealMaterialsData, floorMaterial: RealMaterialsData, description: String, additions: [RealAdditionsData], roomImages: [UIImage]){
        
        if selectedZoneId == 0 {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please choose room zone".localized())
        }
        else if length.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter room length".localized())
            
        }
        else if width.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter room width".localized())
        }
        else if height.isBlank {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter room height".localized())
        }
       
        else if wallMaterial == RealMaterialsData() && floorMaterial == RealMaterialsData() && ceilMaterial == RealMaterialsData()  {
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please choose room material".localized())
        }
        else if description.isBlank{
            self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please enter room description".localized())
        }
        else {
            var isAdditionEmpty : Bool = true
            for addition in additions {
                if addition.id != 0 {
                    isAdditionEmpty = false
                    break
                }
            }
            if isAdditionEmpty {
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: "Please choose room additions".localized())
            }
            else {
                let materials: [RealMaterialsData] = [wallMaterial, ceilMaterial, floorMaterial]
                var param: [String: Any] = [
                    "project_id": projectId,
                    "room_zone_id": selectedZoneId,
                    "length": Double(length.convertDigitsToEng) ?? 0,
                    "width": Double(width.convertDigitsToEng) ?? 0,
                    "height": Double(height.convertDigitsToEng) ?? 0,
                    "description" : description,
                ]
                var materialIndex = 0
                for material in materials {
                    if material != RealMaterialsData() {
                        param.updateValue(material.id ?? 0, forKey: "materials[\(materialIndex)]")
                        materialIndex += 1
                    }
                }
                var additionsIndex = 0
                for  addition in additions {
                    if addition.id != 0 && addition.id != nil {
                            param.updateValue(addition.id ?? 0, forKey: "additions[\(additionsIndex)][id]")
                            param.updateValue(addition.quantity ?? 0, forKey: "additions[\(additionsIndex)][quantity]")
                            additionsIndex += 1
                        }
                }
                addEditRoom(param: param, isEdit: isEdit, images: roomImages, roomId: roomId)
            }
            
        }
        
    }
    
    
    
    private func  addEditRoom(param:[String:Any],isEdit: Bool,images: [UIImage],roomId:Int){
        var params:[String:Any] = param
        self._isLoading = true
        var path :String = "clients/rooms"
        if isEdit {
            params.updateValue("PUT", forKey: "_method")
            path = "clients/rooms/\(roomId)"
        }
        MultipartUploadImages.shared.uploadImage(path: path, parameterS: params, photos: [:], photosArray: ["room_images":images]) { status, message, error in
            
            if status == 1 {
                self._isLoading = false
                self._isFailed = false
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: isEdit ? "Updated successufully".localized() : "Room Added Successfully".localized())
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self._isAddEditRoomFinished = true
                }
            } else {
                self._message = message ?? ""
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
        
    }
    func publishProject(projectId:Int){
        self._isLoading = true
        api.publishProject(projectId: projectId ){(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: self._message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self._isprojectPublished = true
                }

            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }

    
}


