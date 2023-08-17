//
//  GameDetail.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import Foundation

struct GameDetail: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let playtime: Int?
    let publishers: [Publisher]?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description_raw"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case playtime = "playtime"
        case publishers = "publishers"
    }
}

struct Publisher: Codable {
    let id: Int?
    let name: String?
}
