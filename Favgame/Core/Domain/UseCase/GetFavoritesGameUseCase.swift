//
//  FavoriteGameUseCase.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import Combine

class GetFavoritesGameUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute() -> AnyPublisher<[Game], Error> {
    return gameRepository.getFavoritesGame()
  }
  
}
