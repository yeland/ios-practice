//
//  Moment.swift
//  dynamic-content-demo
//
//  Created by Linxiao Wei on 2019/12/3.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

struct Moment: Codable {
  var content: String?
  var images: [Image]?
  var sender: Sender?
  var comments: [Comment]?
}

struct Image: Codable {
  var url: String
}

struct Sender: Codable {
  var username: String
  var nick: String
  var avatar: String
}

struct Comment: Codable {
  var content: String
  var sender: Sender
}
