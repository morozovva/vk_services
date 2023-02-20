//
//  CustomError.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import Foundation

enum CustomError: LocalizedError {
    case invalidURL (url: String)
    case dataUnavailible (url: String)
    case nonDecodable (url: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Неверный URL \(url) 😐"
        case .dataUnavailible(let url):
            return "Не удалось получить данные  \(url) 🥺"
        case .nonDecodable(let url):
            return "Данные не удалось декодировать \(url) 🥵"
        }
    }
}
