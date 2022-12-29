//
//  GameDetail.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

struct GameDetail {
  let id: Int
  let name: String
  let released: String
  let backgroundImage: String
  let rating: Double
  let descriptionRaw: String
  let parentPlatforms: [ParentPlatform]
}

struct ParentPlatform {
  let parentPlatform: Platform
}

struct Platform {
  let id: Int
  let slug: String
}
