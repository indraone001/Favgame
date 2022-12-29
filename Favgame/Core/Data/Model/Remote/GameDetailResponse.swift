//
//  GameDetailResponse.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

struct GameDetailResponse: Codable {
  let id: Int
  let name: String
  let released: String
  let backgroundImage: String
  let rating: Double
  let descriptionRaw: String?
  let parentPlatforms: [ParentPlatformResponse]?
  
  enum CodingKeys: String, CodingKey {
    case id, name, released
    case backgroundImage = "background_image"
    case rating
    case descriptionRaw = "description_raw"
    case parentPlatforms = "platforms"
  }
}

struct ParentPlatformResponse: Codable {
  let platformResponse: PlatformsResponse
  
  enum CodingKeys: String, CodingKey {
    case platformResponse = "platform"
  }
}

struct PlatformsResponse: Codable {
  let id: Int
  let slug: String
}
