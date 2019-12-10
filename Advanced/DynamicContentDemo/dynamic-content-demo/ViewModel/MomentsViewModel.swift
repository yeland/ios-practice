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
  var user: User = User(profileImage: "", avatar: "", nick: "", username: "")
  
  func getUser(completion: @escaping (User?) -> Void) {
    guard let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith") else { return }
    networkClient.request(url: url) { [weak self] data, error in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          self?.user = try decoder.decode(User.self, from: data)
          DispatchQueue.main.async {
            completion(self?.user)
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
  
  func getMoments(completion: @escaping ([Moment]?) -> Void) {
    guard let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets") else { return }
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
