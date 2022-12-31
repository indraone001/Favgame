//
//  APICall.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io"
  
  static var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }
    if (value.starts(with: "_")) {
      fatalError("Register for a rawg.io and get an API key at https://rawg.io/apidocs")
    }
    return value
  }
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
