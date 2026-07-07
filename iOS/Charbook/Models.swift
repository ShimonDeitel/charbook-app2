import Foundation

struct Burn: Identifiable, Codable, Equatable {
    let id: UUID
    var dateCreated: Date
    var title: String
    var tipType: String
    var species: String
    var patternSource: String
    var notes: String

    init(id: UUID = UUID(), dateCreated: Date = Date(), title: String = "", tipType: String = "", species: String = "", patternSource: String = "", notes: String = "") {
        self.id = id
        self.dateCreated = dateCreated
        self.title = title
        self.tipType = tipType
        self.species = species
        self.patternSource = patternSource
        self.notes = notes
    }
}
