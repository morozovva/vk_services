//
//  NetworkManager.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import Foundation

final class NetworkManager {
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getData<T: Decodable>(by url: URLProtocol, type: T.Type) async throws -> T {
        guard let url = url.url else { throw CustomError.invalidURL(url: String(describing: url)) }
        
        let request = URLRequest(url: url)
        
        guard let (data, _) = try? await urlSession.data(for: request) else { throw CustomError.dataUnavailible(url: url.absoluteString) }
        
        guard let result = try? jsonDecoder.decode(T.self, from: data) else { throw CustomError.nonDecodable(url: url.absoluteString) }
        
        return result
    }
}
