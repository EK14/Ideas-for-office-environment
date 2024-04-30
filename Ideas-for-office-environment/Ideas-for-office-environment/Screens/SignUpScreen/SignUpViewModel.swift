//
//  SignUpViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 07.04.2024.
//

import UIKit

class SignUpViewModel: CarousalViewContainerViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordRepeate: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var job: String = ""
    @Published var photo = UIImage(systemName: "camera")
    @Published var office: Int = .zero
    @Published var offices = [Office]()
    @Published var emailIsUsed = false
    @Published var emailFormatValid = true
    @Published var isLoading = false
    
    func signUp() {
        if let photo = photo {
            UploadImageAction().call(image: photo) { photoUrl in
                        SignUpAction(
                            parameters: SignUpRequest(
                                email: self.email,
                                password: self.password,
                                userInfo: UserDto(name: self.name,
                                                  surname: self.surname,
                                                  job: self.job,
                                                  photo: photoUrl,
                                                  office: self.office))).call() { response in
                                                      switch response {
                                                      case .success(let response):
                                                          Auth.shared.setCredentials(
                                                            accessToken: response.accessToken,
                                                            refreshToken: response.refreshToken
                                                          )
                                                      case .failure(_):
                                                          print("registration error")
                                                      }
                                                  }
            }
        }
    }
    
    func fetchOffices(completion: @escaping () -> ()) {
        isLoading = true
        FetchOfficesAction().call { [weak self] response in
            switch response {
            case .success(let data):
                self?.offices = data + data
            case .failure(_):
                print("Could not fetch offices")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
        
    func checkEmailValidation(completion: @escaping () -> Void) {
        checkEmailFormat()
        guard self.emailFormatValid else {
            self.emailIsUsed = false
            self.emailFormatValid = false
            completion()
            return
        }
        
        ValidationAction().call(email: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.emailIsUsed = false
                completion()
            case .failure(_):
                self?.emailIsUsed = true
                completion()
            }
        }
    }
    
    func checkEmailFormat() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        self.emailFormatValid = emailPred.evaluate(with: email) ? true: false
    }
}
