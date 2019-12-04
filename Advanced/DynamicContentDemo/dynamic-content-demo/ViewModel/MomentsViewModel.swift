//
//  MomentsViewModel.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

class MomentsViewModel {
  private let networkClient: NetworkClient = .init()
  var moments: [Moment] = []
  
  func getMoments(completion: @escaping ([Moment]?) -> Void) {
    guard let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          self?.moments = try JSONDecoder().decode([Moment].self, from: data)
          DispatchQueue.main.async {
            completion(self?.moments)
          }
        } catch let error {
          print(error.localizedDescription)
        }
      }
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
  
  var showMoments: [Moment] {
    return moments.filter({
      if $0.sender == nil {
        return false
      }
      if $0.images == nil && $0.content == nil {
        return false
      }
      return true
    })
  }
}
