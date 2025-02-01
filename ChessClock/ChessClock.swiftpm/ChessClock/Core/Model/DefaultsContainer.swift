import Foundation

struct DefaultsContainer {
    let defaults: UserDefaults
    let name: String

    init(name: String = "") {
        self.name = name

        defaults = name.isEmpty
            ? .standard
            : UserDefaults(suiteName: name)!
    }

    static var standard: Self {
        DefaultsContainer()
    }
}
