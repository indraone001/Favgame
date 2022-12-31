//
//  Injection.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//
import Swinject
import RealmSwift

final class Injection {
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
    
    container.register(GetGameDetailUseCase.self) { resolver in
      GetGameDetailUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    container.register(SearchGameUseCase.self) { resolver in
      SearchGameUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    container.register(GetFavoritesGameUseCase.self) { resolver in
      GetFavoritesGameUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    container.register(InsertFavoriteGameUseCase.self) { resolver in
      InsertFavoriteGameUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    container.register(CheckIsFavoriteUseCase.self) { resolver in
      CheckIsFavoriteUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    container.register(DeleteFavoriteGameUseCase.self) { resolver in
      DeleteFavoriteGameUseCase(
        gameRepository: resolver.resolve(GameRepository.self)!
      )
    }
    
    // MARK: - Presenter
    container.register(HomeViewController.self) { resolver in
      let controller = HomeViewController()
      controller.getListGameUseCase = resolver.resolve(GetListGameUseCase.self)
      return controller
    }
    
    container.register(DetailViewController.self) { resolver in
      let controller = DetailViewController()
      controller.getGameDetailUseCase = resolver.resolve(GetGameDetailUseCase.self)
      controller.insertFavoriteGameUseCase = resolver.resolve(InsertFavoriteGameUseCase.self)
      controller.checkIsFavoriteUseCase = resolver.resolve(CheckIsFavoriteUseCase.self)
      controller.deleteFavoriteGameUseCase = resolver.resolve(DeleteFavoriteGameUseCase.self)
      return controller
    }
    
    container.register(SearchViewController.self) { resolver in
      let controller = SearchViewController()
      controller.searchGameUseCase = resolver.resolve(SearchGameUseCase.self)
      return controller
    }
    
    container.register(FavoriteViewController.self) { resolver in
      let controller = FavoriteViewController()
      controller.getFavoriteGameUseCase = resolver.resolve(GetFavoritesGameUseCase.self)
      return controller
    }
    
    container.register(AboutViewController.self) { _ in
      let controller = AboutViewController()
      return controller
    }
    
    return container
  }()
}
