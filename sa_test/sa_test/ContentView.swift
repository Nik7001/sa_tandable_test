//
//  ContentView.swift
//  sa_test
//
//  Created by Admin on 19/07/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var inspectionViewModel = InspectionViewModel()

    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                VStack {
                    Button("Start Inspection") {
                        inspectionViewModel.startInspection()
                    }
                    .padding()

                    if let inspection = inspectionViewModel.currentInspection {
                        Text("Inspection ID: \(inspection.id)")
                        // Display other inspection details...
                        Button("Submit Inspection") {
                            inspectionViewModel.submitInspection()
                        }
                        .padding()
                    }

                    if let error = inspectionViewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    }
                }
                .navigationBarTitle("Inspections")
            } else {
                VStack {
                    TextField("Email", text: $authViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    SecureField("Password", text: $authViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Register") {
                        authViewModel.register()
                    }
                    .padding()

                    Button("Login") {
                        authViewModel.login()
                    }
                    .padding()

                    if let error = authViewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    }
                }
                .navigationBarTitle("Login")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
