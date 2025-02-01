import SwiftUI

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case components
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        guard let components = cgColor?.components else {
            throw EncodingError.invalidValue("", .init(
                codingPath: [CodingKeys.components],
                debugDescription: ""
            ))
        }

        try container.encode(components, forKey: .components)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let components = try container.decode([CGFloat].self, forKey: .components)
        guard let cgColor = CGColor(
            colorSpace: .init(name: CGColorSpace.sRGB)!,
            components: components
        ) else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: [CodingKeys.components],
                debugDescription: ""
            ))
        }

        self.init(cgColor: cgColor)
    }
}
