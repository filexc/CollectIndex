//
//  Collections.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/8/24.
//

import Foundation

class Collections: ObservableObject, Codable {
    @Published var collectionArray = [Collection]()

    func add(collection: Collection) {
        collectionArray.append(collection)
    }

    enum CodingKeys: CodingKey {
        case collectionArray
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        collectionArray = try container.decode(
            [Collection].self, forKey: .collectionArray)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(collectionArray, forKey: .collectionArray)
    }

    init() {
        loadSavedData()
    }

    public func loadSavedData() {
        let path = URL.documentsDirectory.appending(
            component: "collectionArray")
        guard let data = try? Data(contentsOf: path) else {
            print("could not read data from path")
            return
        }
        do {
            collectionArray = try JSONDecoder().decode(
                [Collection].self, from: data)
        } catch {
            print("could not decode data")
        }
    }

    public func saveData() {
        let path = URL.documentsDirectory.appending(
            component: "collectionArray")
        let data = try? JSONEncoder().encode(collectionArray)
        do {
            try data?.write(to: path)
        } catch {
            print("could not print data")
        }
    }
}
