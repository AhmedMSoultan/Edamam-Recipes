//
//  Recipe.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import Foundation

struct RecipesResponse : Codable {
    let from : Int?
    let to : Int?
    let count : Int?
    let hits : [Hits]?

    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
        case count = "count"
        case hits = "hits"
    }
}

struct Hits : Codable {
    let recipe : Recipe?
    
    enum CodingKeys: String, CodingKey {
        case recipe = "recipe"
    }
}


struct Recipe : Codable {
    let title : String?
    let image : String?
    let source : String?
    let url : String?
    let shareAs : String?
    let healthLabels : [String]?

    enum CodingKeys: String, CodingKey {
        case title = "label"
        case image = "image"
        case source = "source"
        case url = "url"
        case shareAs = "shareAs"
        case healthLabels = "healthLabels"
    }
}
