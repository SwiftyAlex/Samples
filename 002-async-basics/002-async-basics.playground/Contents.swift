import UIKit
import PlaygroundSupport

// One
class AlbumGenerator {
    func getAlbumNames(albumsClosure: (([String]) -> ())) {
        albumsClosure(["Folklore", "Evermore", "Fearless (Taylor's Version)", "Red (Taylor's Version)"])
    }
}

let albumGenerator = AlbumGenerator()
albumGenerator.getAlbumNames { albums in
    print(albums)
}

// Two
class AsyncAlbumGenerator {
    func getAlbumNames() async -> [String] {
        Thread.sleep(forTimeInterval: 2)
        return ["Folklore", "Evermore", "Fearless (Taylor's Version)", "Red (Taylor's Version)"]
    }
}

async {
    let albumGenerator = AsyncAlbumGenerator()
    let albums = await albumGenerator.getAlbumNames()
    print(albums)
}

print("Fetching Taylor Swift's Albums")

// Three
class CancellationAwareAlbumGenerator {
    func getAlbumNames() async throws -> [String] {
        Thread.sleep(forTimeInterval: 2)
        try Task.checkCancellation()
        return ["Taylor Swift", "Fearless", "Speak Now", "Red", "1989", "Reputation", "Lover"]
    }
}

let albumTask = async {
    let albumGenerator = CancellationAwareAlbumGenerator()
    let albums = try await albumGenerator.getAlbumNames()
    print(albums)
}
print("Fetching Taylor Swift's Classic Albums")
albumTask.cancel()

// Four
class CancellationCheckingAlbumGenerator {
    func getAlbumNames() async throws -> [String] {
        Thread.sleep(forTimeInterval: 2)
        if Task.isCancelled {
            return []
        } else {
            return ["Taylor Swift", "Fearless", "Speak Now", "Red", "1989", "Reputation", "Lover"]
        }
    }
}

let secondAlbumTask = async {
    let albumGenerator = CancellationCheckingAlbumGenerator()
    let albums = try await albumGenerator.getAlbumNames()
    print(albums)
}
print("Fetching Taylor Swift's Classic Albums")
secondAlbumTask.cancel()



PlaygroundPage.current.needsIndefiniteExecution = true
