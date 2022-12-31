//
//  GameMapper.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

final class GameMapper {
  
  static func mapGameResponsesToDomains(
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
  
  static func mapGameEntityToDomains(
    input gameEntity: [GameEntity]
  ) -> [Game] {
    return gameEntity.map { result in
      return Game(
        id: result.id,
        name: result.name,
        released: result.released,
        backgroundImage: result.backgroundImage,
        rating: result.rating
      )
    }
  }
  
  static func mapGameModelToEntity(
    input game: Game
  ) -> GameEntity {
    return GameEntity(
      id: game.id,
      name: game.name,
      released: game.released,
      backgroundImage: game.backgroundImage,
      rating: game.rating
    )
  }
  
}
