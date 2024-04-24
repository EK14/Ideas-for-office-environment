//
//  Auth.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.04.2024.
//

import SwiftUI
import SwiftKeychainWrapper
import Combine

class Auth: ObservableObject {
    
    struct Credentials {
        var accessToken: String?
        var refreshToken: String?
    }
    
    enum KeychainKey: String {
        case accessToken
        case refreshToken
    }
    
    static let shared: Auth = Auth()
    private let keychain: KeychainWrapper = KeychainWrapper.standard
    
    let loggedIn = CurrentValueSubject<Bool, Never>(false)
    
    private init() {
        withAnimation {
            loggedIn.send(hasAccessToken())
        }
    }
    
    func getCredentials() -> Credentials {
        print(keychain.string(forKey: KeychainKey.accessToken.rawValue))
        return Credentials(
            accessToken: keychain.string(forKey: KeychainKey.accessToken.rawValue),
            refreshToken: keychain.string(forKey: KeychainKey.refreshToken.rawValue)
        )
    }
    
    func setCredentials(accessToken: String, refreshToken: String) {
        keychain.set(accessToken, forKey: KeychainKey.accessToken.rawValue)
        keychain.set(refreshToken, forKey: KeychainKey.refreshToken.rawValue)
        
        withAnimation {
            loggedIn.send(true)
        }
    }
    
    func saveUsernameInfo(name: String, surname: String, job: String) {
        UserDefaults.standard.setValue(name, forKey: "name")
        UserDefaults.standard.setValue(surname, forKey: "surname")
        UserDefaults.standard.setValue(job, forKey: "job")
    }
    
//    func getUsernameInfo() {
//        UserDefaults.standard.get
//    }
    
    func hasAccessToken() -> Bool {
        return getCredentials().accessToken != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().accessToken
    }

    func getRefreshToken() -> String? {
        return getCredentials().refreshToken
    }

    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.accessToken.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.refreshToken.rawValue)
        
        withAnimation {
            loggedIn.send(false)
        }
    }
    
}
