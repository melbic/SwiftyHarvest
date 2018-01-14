//
//  Harvest+Network.swift
//  Harvest
//
//  Created by Samuel Bichsel on 28.12.17.
//

import Foundation
import Alamofire

struct MockClient: NetworkClient {

    let bundle: Bundle

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    func get<R>(url: URL, parameters: Parameters?, headers: HTTPHeaders, completionHandler: @escaping (DataResponse<R>) -> Void) where R : Decodable, R : Encodable {
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let filename = url.lastPathComponent.split(separator: ".")[0]
        let resourceURL = bundle.url(forResource: String(filename), withExtension: ".json")
        let data: Data = try! Data(contentsOf: resourceURL!)

        let result: Result<R> = Request.serializeResponseCodable(response: httpResponse, data: data, error: nil)

        let resp = DataResponse(request: nil, response: httpResponse, data: data, result: result)

        completionHandler(resp)
    }
}
