//
//  GameRemoteRepository.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//

import Combine

protocol GameRepositoryProtocol: AnyObject {
  func getGameList() -> AnyPublisher<[Game], Error>
  func getGameDetail(withGameId id: Int) -> AnyPublisher<GameDetail, Error>
  func searchGame(with query: String) -> AnyPublisher<[Game], Error>
  func insertGameToFavorite(with game: Game) -> AnyPublisher<Bool, Error>
  func getFavoritesGame() -> AnyPublisher<[Game], Error>
  func checkIsFavorite(withGameId id: Int) -> AnyPublisher<Bool, Error>
  func deleteFromFavorite(withGameId id: Int) -> AnyPublisher<Bool, Error>
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
      .map { GameMapper.mapGameResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getGameDetail(withGameId id: Int) -> AnyPublisher<GameDetail, Error> {
    return gameRemoteDataSource.getGameDetail(withGameId: id)
      .map { GameDetailMapper.mapGameDetailResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func searchGame(with query: String) -> AnyPublisher<[Game], Error> {
    return gameRemoteDataSource.searchGame(with: query)
      .map { GameMapper.mapGameResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func insertGameToFavorite(with game: Game) -> AnyPublisher<Bool, Error> {
    return gameLocalDataSource.insertGameToFavorite(with: GameMapper.mapGameModelToEntity(input: game))
      .eraseToAnyPublisher()
  }
  
  func getFavoritesGame() -> AnyPublisher<[Game], Error> {
    return gameLocalDataSource.getFavoriteGame()
      .map { GameMapper.mapGameEntityToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func checkIsFavorite(withGameId id: Int) -> AnyPublisher<Bool, Error> {
    return gameLocalDataSource.checkIsFavorite(with: id)
      .eraseToAnyPublisher()
  }
  
  func deleteFromFavorite(withGameId id: Int) -> AnyPublisher<Bool, Error> {
    return gameLocalDataSource.deleteGameFromFavorite(with: id)
      .eraseToAnyPublisher()
  }
}
