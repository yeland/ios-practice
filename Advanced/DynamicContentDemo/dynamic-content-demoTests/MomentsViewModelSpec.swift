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
    let moment = Moment(
      content: "",
      images: [Image(url: ""), Image(url: "")],
      sender: Sender(username: "", nick: "", avatar: ""),
      comments: [Comment(content: "hello", sender: Sender(username: "", nick: "", avatar: ""))]
    )
    let momentWithoutSender = Moment(
      content: "",
      images: [],
      sender: nil,
      comments: []
    )
    let momentWithoutContent = Moment(
      content: nil,
      images: [Image(url: ""), Image(url: "")],
      sender: Sender(username: "", nick: "", avatar: ""),
      comments: []
    )
    let momentWithoutImage = Moment(
      content: "", images: nil,
      sender: Sender(username: "", nick: "", avatar: ""),
      comments: nil
    )
    let invalidMoment = Moment(
      content: nil, images: nil,
      sender: Sender(username: "", nick: "", avatar: ""),
      comments: []
    )
    
    let allMoments = [moment, moment, moment, moment, momentWithoutImage, moment, moment, momentWithoutSender, momentWithoutSender, moment, moment, momentWithoutContent, moment, invalidMoment, moment, moment, invalidMoment, moment]
    
    describe("getValidMoments") {
      context("should get all valid comments") {
        it("return valid comments") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          expect(momentViewModel.allValidMoments.count) == 14
        }
      }
    }
    
    describe("getInitialMoments") {
      context("should get initial moments") {
        it("return 5 moments when count of moments is more than 5") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          expect(momentViewModel.moments.count) == 5
          expect(momentViewModel.moments[4].images).to(beNil())
        }
        
        it("return all moments when count of moments is less than 5") {
          let momentViewModel = MomentsViewModel()
          let allMoments = [moment, moment, moment]
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          expect(momentViewModel.moments.count) == 3
        }
      }
    }
     
    describe("loadMore") {
      context("should load more moments") {
        it("load more 5 moments when remaining comments' count is more than 5") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          momentViewModel.loadMore()
          expect(momentViewModel.moments.count) == 10
        }
        
        it("load remaining comments when remaining comments' count is less than 5") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          momentViewModel.loadMore()
          expect(momentViewModel.moments.count) == 10
          momentViewModel.loadMore()
          expect(momentViewModel.moments.count) == 14
        }
      }
    }
    
    describe("isAllLoaded") {
      context("should check if all moments is loaded") {
        it("return if all moments is loaded") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          momentViewModel.loadMore()
          expect(momentViewModel.isAllLoaded()) == false
          momentViewModel.loadMore()
          expect(momentViewModel.isAllLoaded()) == true
        }
      }
    }
    
    describe("addComment") {
      context("should add comment to corresponding moment") {
        it("append comment when there are comments") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          momentViewModel.addComment(row: 0, comment: "world")
          let comments = momentViewModel.allValidMoments[0].comments
          expect(comments).notTo(beNil())
          if let comments = comments {
            expect(comments.count) == 2
            expect(comments[1].content) == "world"
          }
        }
        
        it("set comment when there is no comment") {
          let momentViewModel = MomentsViewModel()
          momentViewModel.getValidMoments(allMoments: allMoments)
          momentViewModel.getInitialMoments()
          momentViewModel.addComment(row: 4, comment: "world")
          let comments = momentViewModel.allValidMoments[4].comments
          expect(comments).notTo(beNil())
          if let comments = comments {
            expect(comments.count) == 1
            expect(comments[0].content) == "world"
          }
        }
      }
    }
  }
}
