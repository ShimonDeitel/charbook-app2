import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Burn] = []
    @Published var isPro: Bool = false

    static let freeLimit = 12

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("charbook_items.json")
    }()

    init() {
        load()
        if items.isEmpty {
            items = [
            Burn(title: "Project title 1", tipType: "Tip used 1", species: "Wood species 1", patternSource: "Pattern source 1", notes: "Progress notes 1"),
            Burn(title: "Project title 2", tipType: "Tip used 2", species: "Wood species 2", patternSource: "Pattern source 2", notes: "Progress notes 2"),
            Burn(title: "Project title 3", tipType: "Tip used 3", species: "Wood species 3", patternSource: "Pattern source 3", notes: "Progress notes 3")
            ]
            save()
        }
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Burn) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Burn) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Burn) {
        items.removeAll { $0.id == item.id }
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Burn].self, from: data) {
            items = decoded
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}
