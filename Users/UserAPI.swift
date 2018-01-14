//
//  Harvest+User.swift
//  Harvest
//
//  Created by Samuel Bichsel on 03.12.17.
//

import Foundation
import Alamofire

extension Harvest {
    public func users() -> UserAPI {
        return UserAPI(api: self)
    }
}

public class UserAPI {
    let api: Harvest

    init(api: Harvest) {
        self.api = api
    }
}

extension UserAPI: HarvestAPI {
    var path: String {
        return "users"
    }

    func me(completion: @escaping (DataResponse<User>) -> Void) {
        self.get("me.json", completionHandler: completion)
    }

    func list(page:Int = 0, completion: @escaping (DataResponse<[User]>) -> Void) {
        get("", parameters:["page":page]) { (users:DataResponse<Page<User>>) in
                        completion(users.map({ page in
                return page.content
            }))
        }
    }


}
