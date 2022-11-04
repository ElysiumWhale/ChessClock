import Foundation

protocol IStorage<U> {
    associatedtype U: RawRepresentable where U.RawValue == String

    func save<T: Codable>(value: T, key: U)
    func retrieve<T: Codable>(key: U) -> T?
}

struct DefaultsStorage<U: RawRepresentable>: IStorage where U.RawValue == String {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let container: UserDefaults

    init(container: UserDefaults = .standard) {
        self.container = container
    }

    func save<T: Codable>(value: T, key: U) {
        guard let data = try? encoder.encode(value) else {
            return
        }

        container.set(data, forKey: key.rawValue)
    }

    func retrieve<T: Codable>(key: U) -> T? {
        guard let data = container.data(forKey: key.rawValue) else {
            return nil
        }

        return try? decoder.decode(T.self, from: data)
    }
}
