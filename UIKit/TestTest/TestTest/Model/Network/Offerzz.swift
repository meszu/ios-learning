//
//  Offerzz.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 10..
//

import Foundation
import Moya

public enum Offerzz {
    case offers
}

extension Offerzz: TargetType {
  
  public var baseURL: URL {
    return URL(string: "https://api.jsonbin.io/v3/qs/63bd764001a72b59f2471ffc")!
  }

  public var path: String {
    return ""
  }

  public var method: Moya.Method {
    switch self {
    case .offers: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    return .requestPlain // TODO
  }

  public var headers: [String: String]? {
      return nil
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
