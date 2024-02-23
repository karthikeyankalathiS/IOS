import Foundation

struct TODO:Decodable{
    var id: Int
    var title: String
    var description: String
    var category: String
    var image: String
}
