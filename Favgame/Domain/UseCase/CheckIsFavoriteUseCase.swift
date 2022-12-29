//
//  CheckIsFavoriteUseCase.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import Combine

class CheckIsFavoriteUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute(withGameId id: Int) -> AnyPublisher<Bool, Error> {
    return gameRepository.checkIsFavorite(withGameId: id)
  }
  
}
