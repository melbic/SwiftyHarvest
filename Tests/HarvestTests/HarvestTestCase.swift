//
// Created by Samuel Bichsel on 09.01.18.
//

import XCTest
@testable import Harvest


class HarvestTestCase: XCTestCase {
    var harvest: Harvest {
        get {
            let bundle = Bundle(for: HarvestTestCase.self)
            let mock = MockClient(bundle: bundle)
            
            return Harvest(client: mock).authenticateEnvVar()
        }

    }

    func asyncTest(test: @escaping (XCTestExpectation) -> Void) {
        let expectation = XCTestExpectation(description: "User result")
        test(expectation)
        wait(for: [expectation], timeout: 10.0)
    }

    func asyncAlamofireTest<R: Decodable>(method: @escaping (@escaping NetworkCompletion<R>) -> (), test: @escaping (R) -> Void) {
        asyncTest { expectation in
            method() { resp in
                defer {
                    expectation.fulfill()
                }
                guard case .success(_) = resp.result else {
                    XCTAssertTrue(false, "\(String(describing: resp.error))")
                    return
                }
                guard let result = try? resp.result.unwrap() else {
                    XCTAssertTrue(false, "Result of DataResponse was empty.")
                    return
                }
                test(result)
            }
        }
    }
   
}

