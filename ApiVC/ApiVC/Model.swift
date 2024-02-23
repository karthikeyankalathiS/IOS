//
//  Model.swift
//  ApiVC
//
//  Created by karthik on 08/02/24.
//

import Foundation

struct TODO:Decodable{
    var id: Int
    var title: String
    var description: String
    var category: String
    var image: String
}
