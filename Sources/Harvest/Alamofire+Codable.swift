//
//  Alamofire+Codable.swift
//  Harvest
//
//  Created by Samuel Bichsel on 28.12.17.
//

import Foundation
import Alamofire

extension Request {
    public static func serializeResponseCodable<R: Decodable>(response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<R> {
        let dataResult = serializeResponseData(response: response, data: data, error: error)

        switch dataResult {
        case .failure(let e):
            return .failure(e)
        case .success(let d):
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let value = try decoder.decode(R.self, from: d)
                return .success(value)
            } catch {
                let afError = AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
                return .failure(afError)
            }
        }
    }
}

struct CodableDataResponseSerializer<Value: Decodable>: DataResponseSerializerProtocol {
    
    public typealias SerializedObject = Value

    /// A closure used by response handlers that takes a request, response, data and error and returns a result.
    public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Value>

    /// Initializes the `ResponseSerializer` instance with the given serialize response closure.
    ///
    /// - parameter serializeResponse: The closure used to serialize the response.
    ///
    /// - returns: The new generic response serializer instance.
    public init(serializeResponse: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<Value>) {
        self.serializeResponse = serializeResponse
    }
}

extension DataRequest {

    static func codableResponseSerializer<Value>() -> CodableDataResponseSerializer<Value> {
        return CodableDataResponseSerializer<Value> { _, response, data, error in
            return Request.serializeResponseCodable(response: response, data: data, error: error)
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter completionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    func responseCodable<R:Decodable>(
            queue: DispatchQueue? = nil,
            completionHandler: @escaping (DataResponse<R>) -> Void)
                    -> Self {
        let serializer: CodableDataResponseSerializer<R> = DataRequest.codableResponseSerializer()
        return response(
                queue: queue,
                responseSerializer: serializer,
                completionHandler: completionHandler
        )
    }
}
