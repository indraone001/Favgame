//
//  addFavoriteGameUseCase.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import Combine

class InsertFavoriteGameUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute(with game: Game) -> AnyPublisher<Bool, Error> {
    return gameRepository.insertGameToFavorite(with: game)
  }
  
}
