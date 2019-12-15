//
//  MomentsViewModelSpec.swift
//  dynamic-content-demoTests
//
//  Created by Linxiao Wei on 2019/12/15.
//  Copyright © 2019 personal.emagrorrim. All rights reserved.
//

import Quick
import Nimble
@testable import dynamic_content_demo

class MomentsViewModelSpec: QuickSpec {
  override func spec() {
    let moment = Moment(content: "", images: [Image(url: ""), Image(url: "")], sender: Sender(username: "", nick: "", avatar: ""), comments: [])
    let momentWithoutSender = Moment(content: "", images: [], sender: nil, comments: [])
    let momentWithoutContent = Moment(content: nil, images: [Image(url: ""), Image(url: "")], sender: Sender(username: "", nick: "", avatar: ""), comments: [])
    let momentWithoutImage = Moment(content: "", images: nil, sender: Sender(username: "", nick: "", avatar: ""), comments: [])
    let invalidMoment = Moment(content: nil, images: nil, sender: Sender(username: "", nick: "", avatar: ""), comments: [])
    let allMoments = [moment, moment, moment, moment, momentWithoutImage, moment, moment, momentWithoutSender, momentWithoutSender, moment, moment, momentWithoutContent, moment, invalidMoment, moment, moment, invalidMoment, moment]
    
    describe("getValidMoments") {
      context("should get all valid comments") {
        it("return valid comments") {
          let momentviewModel = MomentsViewModel()
          momentviewModel.getValidMoments(allMoments: allMoments)
          expect(momentviewModel.allValidMoments.count) == 14
        }
      }
    }
    
    describe("getInitialMoments") {
      context("should get initial moments") {
        it("return 5 moments when count of moments is more than 5") {
          let momentviewModel = MomentsViewModel()
          momentviewModel.getValidMoments(allMoments: allMoments)
          momentviewModel.getInitialMoments()
          expect(momentviewModel.moments.count) == 5
          expect(momentviewModel.moments[4].images).to(beNil())
        }
        
        it("return all moments when count of moments is less than 5") {
          let momentviewModel = MomentsViewModel()
          let allMoments = [moment, moment, moment]
          momentviewModel.getValidMoments(allMoments: allMoments)
          momentviewModel.getInitialMoments()
          expect(momentviewModel.moments.count) == 3
        }
      }
    }
     
    describe("loadMore") {
      context("should load more moments") {
        it("load more 5 moments when remaining comments' count is more than 5") {
          let momentviewModel = MomentsViewModel()
          momentviewModel.getValidMoments(allMoments: allMoments)
          momentviewModel.getInitialMoments()
          momentviewModel.loadMore()
          expect(momentviewModel.moments.count) == 10
        }
        
        it("load remaining comments when remaining comments' count is less than 5") {
          let momentviewModel = MomentsViewModel()
          momentviewModel.getValidMoments(allMoments: allMoments)
          momentviewModel.getInitialMoments()
          momentviewModel.loadMore()
          expect(momentviewModel.moments.count) == 10
          momentviewModel.loadMore()
          expect(momentviewModel.moments.count) == 14
        }
      }
    }
    
    describe("isAllLoaded") {
      context("should check if all moments is loaded") {
        it("return if all moments is loaded") {
          let momentviewModel = MomentsViewModel()
          momentviewModel.getValidMoments(allMoments: allMoments)
          momentviewModel.getInitialMoments()
          momentviewModel.loadMore()
          expect(momentviewModel.isAllLoaded()) == false
          momentviewModel.loadMore()
          expect(momentviewModel.isAllLoaded()) == true
        }
      }
    }
  }
}
