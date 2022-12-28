//
//  GameLocalDataSource.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import RealmSwift

protocol GameLocalDataSourceProtocol: AnyObject {
  
}

class GameLocalDataSource: GameLocalDataSourceProtocol {
  private let realm: Realm
  
  required init(realm: Realm) {
    self.realm = realm
  }
}
