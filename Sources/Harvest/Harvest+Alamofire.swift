//
//  Harvest+Alamofire.swift
//  Harvest
//
//  Created by Samuel Bichsel on 28.12.17.
//

import Foundation
import Alamofire

struct AlamofireClient: NetworkClient {
    
    let sessionManager: SessionManager

    init() {
        sessionManager = SessionManager.default
    }

    func get<R: Codable>(url: URL, parameters:Parameters?, headers: HTTPHeaders, completionHandler: @escaping Completion<R>) {
        sessionManager.request(url,
                        method: .get,
                        parameters:parameters,
                        headers: headers)
                .responseCodable { (r: DataResponse<R>) in
                    if let data = r.data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                    completionHandler(r)
                }
    }
}

extension Harvest {
    convenience init() {
        self.init(client: AlamofireClient())
    }
}
