//
//  CatItem.swift
//  CatShow
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import Foundation

struct CatItem: Decodable {
    let id: String
    let mimetype: String
    let size: Int
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case mimetype, size, tags
    }
}
