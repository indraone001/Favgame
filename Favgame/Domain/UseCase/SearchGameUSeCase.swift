//
//  SearchGameUSeCase.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import Combine

class SearchGameUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func execute(with query: String) -> AnyPublisher<[Game], Error> {
    return gameRepository.searchGame(with: query)
  }
}
