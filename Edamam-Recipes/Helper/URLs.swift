//
//  URLs.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import Foundation

let baseURL = "https://api.edamam.com/api/recipes/v2?app_id=9d40ce84&app_key=99612783a545e279eda9723c1620eded&type=public&q=chicken"

enum EndPoint {
    // MARK: Home endpoints
    case all
    case filterByHealth (String)
    
    var url: URL {
        return URL(string: self.urlValue) ?? URL(string: "")!
    }

    var urlValue: String {
        switch self {
            // MARK: Admin endpoints
        case .all:
            return baseURL
        case .filterByHealth(let health):
            return baseURL + "&health=\(health)"
        }
    }
}


