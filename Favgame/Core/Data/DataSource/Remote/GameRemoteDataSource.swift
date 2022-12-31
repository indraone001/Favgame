//
//  GameRemoteDataSource.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import Alamofire
import Combine

protocol GameRemoteDataSourceProtocol: AnyObject {
  
  func getListGame() -> AnyPublisher<[GameResponse], Error>
  func getGameDetail(withGameId id: Int) -> AnyPublisher<GameDetailResponse, Error>
  func searchGame(with query: String) -> AnyPublisher<[GameResponse], Error>
  
}

final class GameRemoteDataSource: GameRemoteDataSourceProtocol {
  
  func getListGame() -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: "\(Endpoints.Get.game.url)?key=\(API.apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameResponses.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getGameDetail(withGameId id: Int) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      if let url = URL(string: "\(Endpoints.Get.game.url)/\(id)?key=\(API.apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func searchGame(with query: String) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: "\(Endpoints.Get.game.url)?search=\(query)&key=\(API.apiKey)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameResponses.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
}
