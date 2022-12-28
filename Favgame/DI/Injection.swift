//
//  Injection.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//
import Swinject
import RealmSwift

class Injection {
  let container: Container = {
    let container = Container()
    // MARK: - Data Source
    container.register(GameRemoteDataSource.self) { _ in
      GameRemoteDataSource()
    }
    
    container.register(GameLocalDataSource.self) { _ in
      GameLocalDataSource(realm: try! Realm())
    }
    
    // MARK: - Repository
    container.register(GameRepository.self) { resolver in
      GameRepository(
        gameLocalDataSource: resolver.resolve(GameLocalDataSource.self)!,
        gameRemoteDataSource: resolver.resolve(GameRemoteDataSource.self)!
      )
    }
    
    // MARK: - Use Case
    container.register(GetListGameUseCase.self) { resolver in
      GetListGameUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }

    // MARK: - Presenter
    container.register(HomeViewController.self) { resolver in
      let controller = HomeViewController()
      controller.getListGameUseCase = resolver.resolve(GetListGameUseCase.self)
      return controller
    }
    
    return container
  }()
}
