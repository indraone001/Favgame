//
//  GameResponse.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import Foundation

struct GameResponses: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [GameResponse]
}

struct GameResponse: Codable {
  let id: Int
  let name: String
  let released: String?
  let backgroundImage: String?
  let rating: Double?
  
  enum CodingKeys: String, CodingKey {
    case id, name, released
    case backgroundImage = "background_image"
    case rating
  }
}
