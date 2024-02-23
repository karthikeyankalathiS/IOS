struct Product: Decodable {
    var id: Int
    var title: String
    let price: Double
    var description: String
    var category: String
    var image: String
    var rating: Rating

    struct Rating: Decodable {
        let rate: Double
        let count: Int
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, price, description, category, image, rating
    }
}
