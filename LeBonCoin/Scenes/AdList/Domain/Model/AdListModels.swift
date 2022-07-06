//
//  AdListModels.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//  

// MARK: - Models

import Foundation

struct Category: Decodable {
    var id: Int
    var name: String
}

struct ImageURL: Decodable {
    var small: String?
    var thumb: String?
}


struct ClassifiedAd: Decodable {
    var id: Int
    var title: String
    var categoryId: Int
    var creationDate: Date?
    var description: String
    var isUrgent: Bool
    var imagesUrl: ImageURL
    var price: Float
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price
        case categoryId = "category_id"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case imagesUrl = "images_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        categoryId = try container.decode(Int.self, forKey: CodingKeys.categoryId)
        if let dateString = try? container.decode(String.self, forKey: CodingKeys.creationDate), let date = dateString.toDate {
            creationDate = date
        }
        description = try container.decode(String.self, forKey: CodingKeys.description)
        isUrgent = try container.decode(Bool.self, forKey: CodingKeys.isUrgent)
        imagesUrl = try container.decode(ImageURL.self, forKey: CodingKeys.imagesUrl)
        price = try container.decode(Float.self, forKey: CodingKeys.price)
    }
    
}

