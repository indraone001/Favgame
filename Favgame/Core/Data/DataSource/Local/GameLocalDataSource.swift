//
//  GameLocalDataSource.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import RealmSwift
import Combine

protocol GameLocalDataSourceProtocol: AnyObject {
  func insertGameToFavorite(with gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
  func getFavoriteGame() -> AnyPublisher<[GameEntity], Error>
  func checkIsFavorite(with gameId: Int) -> AnyPublisher<Bool, Error>
  func deleteGameFromFavorite(with gameId: Int) -> AnyPublisher<Bool, Error>
}

class GameLocalDataSource: GameLocalDataSourceProtocol {
  
  private let realm: Realm
  
  required init(realm: Realm) {
    self.realm = realm
  }
  
  func insertGameToFavorite(with gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
    return Future <Bool, Error> { completion in
      do {
        try self.realm.write {
          self.realm.add(gameEntity)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  func getFavoriteGame() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      do {
        try self.realm.write({
          let gameList: Results<GameEntity> = {
            self.realm.objects(GameEntity.self)
              .sorted(byKeyPath: "name", ascending: true)
          }()
          completion(.success(gameList.toArray(ofType: GameEntity.self)))
        })
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  func checkIsFavorite(with gameId: Int) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          do {
              try self.realm.write {
              let gameEntity = self.realm.objects(GameEntity.self)
              let results = gameEntity.where {
                  $0.id == gameId
              }
              let data = results.toArray(ofType: GameEntity.self)
              if data.isEmpty {
                  completion(.success(false))
              } else {
                  completion(.success(true))
              }
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
      }.eraseToAnyPublisher()
  }
  
  func deleteGameFromFavorite(with gameId: Int) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          do {
              try self.realm.write {
              let gameEntity = self.realm.objects(GameEntity.self)
              let results = gameEntity.where {
                  $0.id == gameId
              }
              self.realm.delete(results)
              completion(.success(true))
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
      }.eraseToAnyPublisher()
  }
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
