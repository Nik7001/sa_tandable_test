//
//  ViewModels.swift
//  sa_test
//
//  Created by Admin on 19/07/24.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false

    func register() {
        NetworkManager.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.errorMessage = nil
                    self.isAuthenticated = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func login() {
        NetworkManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.errorMessage = nil
                    self.isAuthenticated = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

class InspectionViewModel: ObservableObject {
    @Published var currentInspection: Inspection?
    @Published var errorMessage: String? = nil

    func startInspection() {
        NetworkManager.shared.startInspection { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let inspection):
                    self.currentInspection = inspection
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func submitInspection() {
        guard let inspection = currentInspection else { return }
        NetworkManager.shared.submitInspection(inspection) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.errorMessage = nil
                    self.currentInspection = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
