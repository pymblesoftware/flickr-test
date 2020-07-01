//
//  DeloietteTestTests.swift
//  DeloietteTestTests
//
//  Created by Regan Russell on 30/6/20.
//  Copyright © 2020 Regan Russell. All rights reserved.
//

import XCTest
@testable import DeloietteTest
import RxSwift
import RxCocoa


class DeloietteTestTests: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetch() throws {

        let expect = expectation(description: "Fetch Succeeds")
        let client = ApiClient.shared
                  do{
                    try client.getPhotoList().subscribe(
                      onNext: { result in
                       print(" done")
                       expect.fulfill()

                    },
                      onError: { error in
                         print(error.localizedDescription)
                      },
                      onCompleted: {
                         print("Completed event.")
                      }).disposed(by: disposeBag)
                    }
                    catch{
                       
                  }
        waitForExpectations(timeout: 3.0) { (_) -> Void in
        }

            
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
