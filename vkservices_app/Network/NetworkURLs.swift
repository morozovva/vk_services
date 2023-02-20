//
//  NetworkURLs.swift
//  vkservices_app
//
//  Created by xyz mac on 19.02.2023.
//

import Foundation

enum NetworkURLs: URLProtocol {
    case items

    var url: URL? {
        switch self {
        case .items:
            return URL(string: "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json")
        }
    }
}
