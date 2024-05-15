//
//  NetworkService.swift
//  SportsApp
//
//  Created by Apple on 12/05/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol{
    func fetchData<T: Decodable>(from endPoint: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService :  NetworkServiceProtocol{
    
    static let instance = NetworkService() // Singleton instance
    let BaseUrl = "https://apiv2.allsportsapi.com"
    let apiKey = "?APIkey=56c5d22f9e6836a9515a17ed6572c4c41869c799c8a631aac3d2e26bca1afcda"
       
       private init() {}
       
    func fetchData<T: Decodable>(from endPoint: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = BaseUrl + endPoint + apiKey
        print(url + "\n")
        if let url = URL(string: url) {
            AF.request(url, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}
