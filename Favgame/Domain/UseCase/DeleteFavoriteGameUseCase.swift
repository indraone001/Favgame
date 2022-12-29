//
//  DeleteFavoriteGameUseCase.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import Combine

class DeleteFavoriteGameUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute(withGamid id: Int) -> AnyPublisher<Bool, Error> {
    return gameRepository.deleteFromFavorite(withGameId: id)
  }
  
}
