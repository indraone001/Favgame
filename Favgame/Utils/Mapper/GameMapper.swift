//
//  GameMapper.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

final class GameMapper {
  
  static func mapGameResponseToDomains(
    input gameResponses: [GameResponse]
  ) -> [Game] {
    return gameResponses.map { result in
      return Game(
        id: result.id,
        name: result.name,
        released: result.released ?? "Unkown",
        backgroundImage: result.backgroundImage ?? Constant.imageDefault,
        rating: result.rating ?? 0.0
      )
    }
  }
  
}
