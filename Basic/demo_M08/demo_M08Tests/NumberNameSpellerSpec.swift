//
//  NumberNameSpellerSpec.swift
//  demo_M08Tests
//
//  Created by Linxiao Wei on 2019/11/22.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

//import Foundation
import Quick
import Nimble

@testable import demo_M08

class NumberNameSpellerSpec: QuickSpec {
  override func spec() {
    describe("numberName") {
      context("return corresponding name") {
        it("two digits") {
          expect(NumberNameSpeller.numberName(of: 99)) == "ninety nine"
        }
        
        it("three digits for whole hundred") {
          expect(NumberNameSpeller.numberName(of: 300)) == "three hundred"
        }
        
        it("three digits") {
          expect(NumberNameSpeller.numberName(of: 310)) == "three hundred and ten"
        }
        
        it("four digits for whole thousand") {
          expect(NumberNameSpeller.numberName(of: 1000)) == "one thousand"
        }

        it("six digits") {
          expect(NumberNameSpeller.numberName(of: 512607)) == "five hundred and twelve thousand, six hundred and seven"
        }
        
        it("million number for whole million") {
          expect(NumberNameSpeller.numberName(of: 43000000)) == "forty three million"
        }
        
        it("million number") {
          expect(NumberNameSpeller.numberName(of: 43112603)) == "forty three million, one hundred and twelve thousand, six hundred and three"
        }
      }
      
      context("return prompt message") {
        it("zero") {
          expect(NumberNameSpeller.numberName(of: 0)) == "please input positive number"
        }
        
        it("negative number") {
          expect(NumberNameSpeller.numberName(of: -7)) == "please input positive number"
        }
      }
      
      context("return out of range") {
        it("large number") {
          expect(NumberNameSpeller.numberName(of: 1321321321321)) == "out of range"
        }
      }
    }
  }
  
}
