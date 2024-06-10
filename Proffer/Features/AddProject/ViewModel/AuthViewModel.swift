//
//  AuthViewModel.swift
//  Proffer
//
//  Created by M.Magdy on 10/06/2024.
//  Copyright © 2024 Nura. All rights reserved.
//


import Foundation
import UIKit


final class AuthViewModel : ObservableObject {
    
    @Published var toast: FancyToast? = nil
    @Published var _isForgetSuccess = false
    @Published var _isSendCodeSuccess = false
    @Published private var _isLoading = false
    @Published private var _isFailed = false
    @Published private var _needsVerification = false
    @Published private var _isSignUpSuccess = false
    @Published private var _isCheckCodeSuccess = false
    @Published private var _isVerifyCodeSuccess = false
    @Published private var _isCreatePasswordSuccess = false

    private var _message: String = ""

    private var token = ""
    let api: AuthAPIProtocol = AuthAPI()
    
    
    var isLoading: Bool {
        get { return _isLoading}
    }
    var message : String {
        get { return _message}
    }
    
    var isFailed: Bool {
        get { return _isFailed}
    }
    
    var needsVerification : Bool {
        get {return _needsVerification}
        set {}
    }
    
    
    var isSendCodeSuccess : Bool {
        get {return _isSendCodeSuccess}
        set {}
    }
    
    var isForgetSuccess : Bool {
        get {return _isForgetSuccess}
        set {}
    }
    
    var isSignUpSuccess: Bool {
        get {return _isSignUpSuccess}
        set {}
    }
   
    var isCheckCodeSuccess : Bool {
        get {return _isCheckCodeSuccess}
        set {}
    }
    
    var isVerifyCodeSuccess : Bool {
        get {return _isVerifyCodeSuccess}
        set {}
    }
    
    var isCreatePasswordSuccess : Bool {
        get {return _isCreatePasswordSuccess}
        set {}
    }
    
    
    
    func validateLogin(email: String, password: String) {
        if email.isBlank {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter Email".localized())
        } else if password.isBlank {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter Password".localized())
        } else {
            login(for: ["email": email,
                        "password": password])
        }
    }
    
    func validateForgetPasswordEmail(email: String) {
        if email.isBlank {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter Email".localized())
        } else {
            self.validateSendCode(email: email, usage: "forget_password")
//            self._isForgetSuccess = true
        }
    }
    
    func validateVerifyEmail(email: String, code: String, isForgetPassword: Bool) {
        if code.isBlank {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter the code".localized())
        } else if code.count != 4 {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter the 4 digit code".localized())
        } else {
            let verifyDic: [String: Any] = ["email": email,
                                           "code": code.convertDigitsToEng]
            if isForgetPassword {
                verifyCode(for: verifyDic)
            } else {
                verify(for: verifyDic)
            }
            
        }
    }
    
    func validateSendCode(email: String, usage: String) {
        
        sendCode(for: ["email": email,
                       "usage": usage])
    }
    
    func validateForgetPassword(email: String, code: String, password: String, confirmPassword: String) {
        if password.isBlank {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter your Password".localized())
        } else if !password.isValidPassword {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter valid Password at least 8 character".localized())
        } else if confirmPassword.isBlank {
                toast = FancyToast(type: .error, title: "Error".localized(), message: "Please Enter the Confirm Password".localized())
        } else if !confirmPassword.isPasswordConfirm(password: password, confirmPassword: confirmPassword) {
            toast = FancyToast(type: .error, title: "Error".localized(), message: "Password and Confirm Password don't Match".localized())
        } else {
            forgetPassword(for: ["code": code.convertDigitsToEng,
                                 "email": email,
                                 "new_password": password,
                                 "new_password_confirmation": confirmPassword])
        }
    }
    
    
    
    private func login(for dic: [String: Any]) {
        self._isLoading = true
        api.login(dic: dic) { result in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                
                guard let response = response else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    GenericUserDefault.shared.setValue(false, Constants.shared.isFirstLogin)

                    self.logIn(response:response)
                }
            case .failure(let error):
                self._needsVerification = GenericUserDefault.shared.getValue(Constants.shared.needsVerification) as? Bool ?? false
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                if !self._needsVerification {
                    self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
                }

            }
        }
    }


    private func verify(for dic: [String:Any]) {
        self._isLoading = true
        self._isCheckCodeSuccess = false
        api.verify(dic: dic) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._isCheckCodeSuccess = true
                guard let response = response else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self._isCheckCodeSuccess = true
                    GenericUserDefault.shared.setValue(true, Constants.shared.isFirstLogin)

                    self.logIn(response:response)

                }
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    func sendCode(for dic: [String:Any]) {
        self._isLoading = true
        api.sendCode(dic: dic) { result in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: self._message)
                self._isSendCodeSuccess = true
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
    
    private func verifyCode(for dic: [String:Any]) {
        self._isLoading = true
        api.verifyCode(dic: dic) { result in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._isVerifyCodeSuccess = true
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
        
    private func forgetPassword(for dic: [String:Any]) {
        self._isLoading = true
        api.forgetPassword(dic: dic) {(result)  in
            switch result {
            case .success(let response):
                self._message = response?.message ?? ""
                self._isLoading = false
                self._isFailed = false
                self._isForgetSuccess = true
                self.toast = FancyToast(type: .success, title: "Success".localized(), message: self._message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    GenericUserDefault.shared.setValue(true, Constants.shared.resetLanguage)
                    MOLH.reset()
                }
            case .failure(let error):
                self._message = "\(error.userInfo[NSLocalizedDescriptionKey] ?? "")"
                self._isLoading = false
                self._isFailed = true
                self.toast = FancyToast(type: .error, title: "Error".localized(), message: self._message)
            }
        }
    }
   
    func logIn(response:LoginModel) {
        GenericUserDefault.shared.setValue(true, Constants.shared.resetLanguage)
        
        GenericUserDefault.shared.setValue(response.token, Constants.shared.token)
        GenericUserDefault.shared.setValue(response.data?.accountType ?? 1, Constants.shared.userType)
        GenericUserDefault.shared.setValue(response.data?.email ?? "", Constants.shared.email)
        GenericUserDefault.shared.setValue(response.data?.profileImage ?? "", Constants.shared.profileImageURL)
        GenericUserDefault.shared.setValue(response.data?.name ?? "", Constants.shared.userName)
        MOLH.reset()
    }
    
    func registered() {
        GenericUserDefault.shared.setValue(true, Constants.shared.resetLanguage)
        GenericUserDefault.shared.setValue(true, Constants.shared.registerFinish)
        MOLH.reset()
    }

    
}

