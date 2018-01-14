//
//  Page.swift
//  Harvest
//
//  Created by Samuel Bichsel on 29.12.17.
//

import Foundation

struct PageLinks: Codable {
    let first: URL
    let next: URL?
    let previous: URL?
    let last: URL
}


protocol PageContent:Codable {
    static var key: String    { get }
}


struct Page<Content: PageContent> : Codable {
    let content: Array<Content>
    let totalPages: Int
    let totalEntries: Int
    let nextPage: Int?                  = nil
    let previousPage: Int?                   = nil
    let pageNumber: Int
    let links: PageLinks

    enum CodingKeys: String, CodingKey {
        case content
        case links
        case totalPages = "total_pages"
        case totalEntries = "total_entries"
        case nextPage = "next_page"
        case previousPage = "previous_page"
        case pageNumber = "page"
        var stringValue :String {
            switch self {
            case .content:
                return Content.key
            default:
                return self.rawValue
            }
        }
    }
}