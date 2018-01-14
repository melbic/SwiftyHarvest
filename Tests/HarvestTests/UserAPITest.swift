import XCTest
@testable import Harvest

class UserAPITest: HarvestTestCase {

    func testURL() {
        let meURL = harvest.users().url(for: "me.json")
        XCTAssertEqual(meURL.absoluteString, "https://api.harvestapp.com/api/v2/users/me.json")
    }
    
    func testMe() {
        asyncAlamofireTest(method:self.harvest.users().me){ user in
            XCTAssertEqual(user.id, 1234567)
        }
    }

    func testAll() {
        asyncAlamofireTest(method:{completion in
             self.harvest.users().list(completion:completion)
        }, test:{ users in
            XCTAssertFalse(users.isEmpty, "Users list must have items")
        })
    }

    static var allTests = [
        ("testURL", testURL),
        ("testResponse", testMe),
        ("testAll", testAll),
    ]


}
