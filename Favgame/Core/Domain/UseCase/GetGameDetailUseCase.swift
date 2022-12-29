//
//  GetGameDetailUseCase.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import Combine

class GetGameDetailUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute(withGameId id: Int) -> AnyPublisher<GameDetail, Error> {
    return gameRepository.getGameDetail(withGameId: id)
  }
}
