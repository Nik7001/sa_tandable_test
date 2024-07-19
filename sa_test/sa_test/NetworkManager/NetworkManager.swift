//
//  NetworkManager.swift
//  sa_test
//
//  Created by Admin on 19/07/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
    case userAlreadyExists
    case userNotFound
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://127.0.0.1:5001"
    
    private init() {}

    func register(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/register") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = User(email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(()))
                case 401:
                    completion(.failure(.userAlreadyExists))
                default:
                    completion(.failure(.requestFailed))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }

    func login(email: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/login") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = User(email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completion(.success("Login successful"))
                case 401:
                    completion(.failure(.userNotFound))
                default:
                    completion(.failure(.requestFailed))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }

    func startInspection(completion: @escaping (Result<Inspection, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/inspections/start") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let inspection = try JSONDecoder().decode(Inspection.self, from: data)
                    completion(.success(inspection))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }

    func submitInspection(_ inspection: Inspection, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/inspections/submit") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(inspection)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(()))
                case 500:
                    completion(.failure(.requestFailed))
                default:
                    completion(.failure(.requestFailed))
                }
            } else {
                completion(.failure(.requestFailed))
            }
        }.resume()
    }
}
