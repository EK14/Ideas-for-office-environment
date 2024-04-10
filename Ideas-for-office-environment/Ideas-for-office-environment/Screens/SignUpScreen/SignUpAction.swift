//
//  SignUpAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 08.04.2024.
//

import Foundation

struct SignUpAction: Encodable {
    
    var parameters: SignUpRequest
    
    func call(completion: @escaping (Result<SignInResponse, NetworkError>) -> Void) {
        
    }
}
