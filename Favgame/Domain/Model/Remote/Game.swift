//
//  Game.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

struct GameList: Codable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [Game]
}

struct Game: Codable {
  let id: Int
  let name: String
  let released: String?
  let backgroundImage: String?
  let rating: Double?
}
