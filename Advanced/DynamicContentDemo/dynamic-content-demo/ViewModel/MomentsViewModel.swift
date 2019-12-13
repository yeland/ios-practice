//
//  MomentsViewModel.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

class MomentsViewModel {
  var validMoments: [Moment] = []
  
  private let networkClient: NetworkClient = .init()
  private var moments: [Moment] = []
  private var step = 0
  var user: User = User(profileImage: "", avatar: "", nick: "", username: "")
  
  func getUser(completion: @escaping () -> Void) {
    guard let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith") else { return }
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
    guard let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          self?.moments = try JSONDecoder().decode([Moment].self, from: data)
          self?.getValidMoments()
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
  
  func getValidMoments() {
    validMoments = moments.filter({
      return $0.sender != nil && ($0.images != nil || $0.content != nil)
    })
  }
  
  func showMomentsByStep() -> [Moment] {
    var moments: [Moment] = []
    let calculatedCount = (step + 1) * 5
    let count = calculatedCount < validMoments.count ? calculatedCount : validMoments.count
    if validMoments.count > 0 {
      for index in 1...count {
        moments.append(validMoments[index - 1])
      }
    }
    return moments
  }
  
  func resetStep() {
    step = 0
  }
  
  func addStep() {
    step += 1
  }
  
  func isAllLoaded() -> Bool {
    return validMoments.count == showMomentsByStep().count && step != 0
  }
}
