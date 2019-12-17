//
//  MomentsViewModel.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

class MomentsViewModel {
  var moments : [Moment] = []
  
  var allValidMoments: [Moment] = []
  private let networkClient: NetworkClient = .init()
  var user: User = User(profileImage: "", avatar: "", nick: "", username: "")
  
  func getUser(completion: @escaping () -> Void) {
    guard let url = URL(string: "https://emagrorrim.github.io/mock-api/user/jsmith.json") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          self?.user = try decoder.decode(User.self, from: data)
          DispatchQueue.main.async {
            completion()
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
  
  func getMoments(completion: @escaping () -> Void) {
    guard let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          let allMoments = try JSONDecoder().decode([Moment].self, from: data)
          self?.getValidMoments(allMoments: allMoments)
          self?.getInitialMoments()
          DispatchQueue.main.async {
            completion()
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
  
  func getValidMoments(allMoments: [Moment]) {
    allValidMoments = allMoments.filter({
      return $0.sender != nil && ($0.images != nil || $0.content != nil)
    })
  }
  
  func getInitialMoments() {
    moments.removeAll()
    if allValidMoments.count < 5 {
      moments += allValidMoments
    } else {
      moments += Array(allValidMoments[0..<5])
    }
  }
  
  func loadMore() {
    let countGap = allValidMoments.count - moments.count
    let indexStart = moments.count
    var indexEnd = 0
    if countGap < 5 {
      indexEnd = indexStart + countGap
    } else {
      indexEnd = indexStart + 5
    }
    moments += Array(allValidMoments[indexStart ..< indexEnd])
  }
  
  func isAllLoaded() -> Bool {
    return allValidMoments.count == moments.count
  }
}
