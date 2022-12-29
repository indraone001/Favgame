//
//  GameDetailMappe.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

final class GameDetailMapper {
  
  static func mapGameDetailResponsesToDomains(
    input gameDetailResponses: GameDetailResponse
  ) -> GameDetail {
    return GameDetail(
      id: gameDetailResponses.id,
      name: gameDetailResponses.name,
      released: gameDetailResponses.released,
      backgroundImage: gameDetailResponses.backgroundImage,
      rating: gameDetailResponses.rating,
      descriptionRaw: gameDetailResponses.descriptionRaw ?? "Uknown",
      parentPlatforms: mapParentPlatformResponseToDomains(input: gameDetailResponses.parentPlatforms!)
    )
  }
  
  static func mapParentPlatformResponseToDomains(
    input parentPlatformsResponse: [ParentPlatformResponse]
  ) -> [ParentPlatform] {
    return parentPlatformsResponse.map { result in
      return ParentPlatform(
        parentPlatform: mapPlatformResponseToDomains(input: result.platformResponse)
      )
    }
  }
  
  static func mapPlatformResponseToDomains(
    input platformsResponse: PlatformsResponse
  ) -> Platform {
    return Platform(
      id: platformsResponse.id,
      slug: platformsResponse.slug
    )
  }
  
}
