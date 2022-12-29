//
//  APICall.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

struct API {
  static let baseUrl = "https://api.rawg.io"
  static let apiKey = "d1081332b72f464085735be4f4fecbe7"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Get: Endpoint {
    case game
    
    public var url: String {
      switch self {
      case .game: return "\(API.baseUrl)/api/games"
      }
    }
  }
}
