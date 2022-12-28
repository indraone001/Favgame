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
    //MARK: - Data Source
    
    //MARK: - Repository
    
    //MARK: - Use Case

    //MARK: - Presenter
    container.register(HomeViewController.self) { resolver in
      let controller = HomeViewController()
      return controller
    }
    
    return container
  }()
}
