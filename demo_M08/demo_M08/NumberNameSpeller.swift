//
//  NumberNameSpeller.swift
//  demo_M08
//
//  Created by Xin Guo on 2019/11/20.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Foundation

struct NumberNameSpeller {
  static let numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
  
  static func numberName(of number: Int) -> String {
    if number <= 0 {
      return "please input positive number"
    }
    
    if number >= 1000000000000 {
      return "out of range"
    }
    
    return millionNumberName(number)
  }
  
  private static func millionNumberName(_ number: Int) -> String {
    if number < 1000000 {
      return thousandNumberName(number)
    } else if number % 1000000 == 0 {
      return "\(thousandNumberName(number / 1000000)) million"
    } else {
      return "\(thousandNumberName(number / 1000000)) million, \(thousandNumberName(number % 1000000))"
    }
  }
  
  private static func thousandNumberName(_ number: Int) -> String {
    if number < 1000 {
      return threeDigitsName(number)
    } else if number % 1000 == 0 {
      return "\(threeDigitsName(number / 1000)) thousand"
    } else {
      return "\(threeDigitsName(number / 1000)) thousand, \(threeDigitsName(number % 1000))"
    }
  }
  
  private static func threeDigitsName(_ number: Int) -> String {
    if number < 100 {
      return twoDigitsName(number)
    } else if number % 100 == 0 {
      return "\(numbers[number / 100 - 1]) hundred"
    } else {
      return "\(numbers[number / 100 - 1]) hundred and \(twoDigitsName(number % 100))"
    }
  }
  
  private static func twoDigitsName(_ number: Int) -> String {
    let twoDigits = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    if number < 20 {
      return numbers[number - 1]
    } else if number % 10 == 0 {
      return twoDigits[number / 10 - 2]
    } else {
      return "\(twoDigits[number / 10 - 2]) \(numbers[number % 10 - 1])"
    }
  }
}
