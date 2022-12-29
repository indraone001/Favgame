//
//  GameEntity.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import RealmSwift

class GameEntity: Object {
  @Persisted var id: Int = 0
  @Persisted var name: String = ""
  @Persisted var released: String = ""
  @Persisted var backgroundImage: String = ""
  @Persisted var rating: Double = 0.0
  
  convenience init(
      id: Int,
      name: String,
      released: String,
      backgroundImage: String,
      rating: Double
  ) {
      self.init()
      self.id = id
      self.name = name
      self.released = released
      self.backgroundImage = backgroundImage
      self.rating = rating
  }
}
