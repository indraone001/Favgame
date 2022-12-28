//
//  GameRemoteRepository.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//

import Combine

protocol GameRepositoryProtocol: AnyObject {
  func getGameList() -> AnyPublisher<[Game], Error>
}

class GameRepository: GameRepositoryProtocol {
  
  private let gameLocalDataSource: GameLocalDataSource
  private let gameRemoteDataSource: GameRemoteDataSource
  
  required init(
    gameLocalDataSource: GameLocalDataSource,
    gameRemoteDataSource: GameRemoteDataSource
  ) {
    self.gameLocalDataSource = gameLocalDataSource
    self.gameRemoteDataSource = gameRemoteDataSource
  }
  
  func getGameList() -> AnyPublisher<[Game], Error> {
    return gameRemoteDataSource.getListGame()
      .map { GameMapper.mapGameResponseToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
}
