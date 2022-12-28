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
}

class GameRemoteDataSource: GameRemoteDataSourceProtocol {
  
  func getListGame() -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: "\(Endpoints.Get.game.url)") {
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
