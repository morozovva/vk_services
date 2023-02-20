//
//  ItemModel.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import Foundation

struct ItemResponse: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let name: String
    let description: String
    let icon_url: String
    let service_url: String
}
