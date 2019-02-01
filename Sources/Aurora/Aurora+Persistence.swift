import Foundation

extension Aurora {
    public static func from(file: String) -> Aurora? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            if let data = try? Data(contentsOf: fileURL), let aurora = try? JSONDecoder().decode(Aurora.self, from: data) {
                return aurora
            }
        }
        return nil
    }

    public func save(file: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            if let encoded = try? encoder.encode(self) {
                print("Aurora: Saving to file", file)
                print(String(bytes: encoded, encoding: .utf8) ?? "No data")
                try? encoded.write(to: fileURL)
            }
        }
    }
}
