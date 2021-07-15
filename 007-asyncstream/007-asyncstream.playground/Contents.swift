import UIKit
import PlaygroundSupport

class AsyncAlbumFetcher {
    private var albums = ["Lover" ,"Folklore", "Evermore", "Fearless (Taylor's Version)", "Red (Taylor's Version)"]
    
    func fetchAlbums() async -> [String] {
        var albumsToReturn: [String] = []
        while !albums.isEmpty {
            Thread.sleep(forTimeInterval: 1.0)
            albumsToReturn.append(albums.popLast() ?? "")
        }
        return albumsToReturn
    }
}

let basicFetcher = AsyncAlbumFetcher()

// Un-Comment to run the basic fetcher.
//Task(priority: .userInitiated) {
//    let albums = await basicFetcher.fetchAlbums()
//    print("Basic Fetcher Got \(albums.count) albums!")
//}

class StreamingAlbumFetcher {
    private var albums = ["Lover" ,"Folklore", "Evermore", "Fearless (Taylor's Version)", "Red (Taylor's Version)"]
    
    func fetchAlbums() -> AsyncStream<String> {
        AsyncStream(String.self) { continuation in
            Task(priority: .background) {
                while !albums.isEmpty {
                    Thread.sleep(forTimeInterval: 1.0)
                    continuation.yield(albums.popLast() ?? "")
                }
                continuation.finish()
            }
        }
    }
}

let fetcher = StreamingAlbumFetcher()

print("Fetching albums")

Task(priority: .userInitiated) {
    var fetchedAlbums: [String] = []
    for await album in fetcher.fetchAlbums() {
        print(album)
        fetchedAlbums.append(album)
    }
    print("Stream Fetcher Got \(fetchedAlbums.count) albums!")
}
