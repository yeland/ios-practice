//
//  File.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/10.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

struct User: Codable {
  var profileImage: String
  var avatar: String
  var nick: String
  var username: String
  private enum CodingKeys: String, CodingKey {
    case profileImage = "profile-image"
    case avatar
    case nick
    case username
  }
}
