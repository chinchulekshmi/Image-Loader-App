//
//  APIManager.swift
//  ImageLoaderApp
//
//  Created by Toqsoft on 07/05/24.
//

import Foundation
enum DataError : Error{
    case invalidURL
    case invalidResponse
    case invalidData
    case network(Error?)
    case invalidStatusCode(Int)
}
class APIManager {
    
    //MARK: - Decode API json File
    func request<T:Decodable>(url:String) async throws-> T{
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200  else {
            throw DataError.invalidResponse
            
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
