import Foundation
import Alamofire

public typealias NetworkCompletion<R:Decodable> = (DataResponse<R>) -> Void

public protocol NetworkClient {
    typealias Completion<R:Decodable> = NetworkCompletion<R>

    func get<R: Codable>(url: URL, parameters:Parameters?, headers: HTTPHeaders, completionHandler: @escaping Completion<R>)
}

open class Harvest {
    fileprivate let baseURL: URL = URL(string: "https://api.harvestapp.com/api/v2/")!
    fileprivate var headers: HTTPHeaders = [:]
    let client: NetworkClient
    
    public init(client: NetworkClient) {
        self.client = client
    }

    func authenticate(accountID: Int, token: String) -> Self {
        headers["Harvest-Account-ID"] = "\(accountID)"
        headers["Authorization"] = "Bearer " + token
        return self
    }
    
    func authenticateEnvVar() -> Self {
        let accountIDVar = ProcessInfo.processInfo.environment["HARVEST_ACCOUNT_ID"]
        let tokenVar = ProcessInfo.processInfo.environment["HARVEST_TOKEN"]
        guard accountIDVar != nil, let accountID = Int(accountIDVar!), let token = tokenVar else {
            fatalError("Harvest Environment Variables are not set correctly")
        
        }
        return authenticate(accountID: accountID, token: token)
    }
}

protocol HarvestAPI {
    var api: Harvest { get }
    var path: String { get }
}

extension HarvestAPI {

    func url(for endpoint: String) -> URL {
        return self.api.baseURL.appendingPathComponent(path).appendingPathComponent(endpoint)
    }

    func get<R: Codable>(_ endpoint: String, parameters: Parameters? = nil, completionHandler: @escaping (DataResponse<R>) -> Void) {
        let url = self.url(for: endpoint)
        api.client.get(url: url, parameters:parameters,headers:self.api.headers, completionHandler: completionHandler)
    }
}


