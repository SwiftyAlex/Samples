//
//  DayEleven.swift
//  12 Days
//
//  Created by Alex Logan on 02/01/2023.
//

import SwiftUI

struct DayEleven: View {
    @Environment(\.songRepository) var songRepository

    var body: some View {
        List {
            Section {
                Text("What is the greatest song?")
            }
            Section {
                Text(songRepository.greatestSong)
            }
        }
    }
}


// This object can be just about whatever you'd like!
class SongRepository: ObservableObject {
    @Published var greatestSong: String

    internal init(greatestSong: String) {
        self.greatestSong = greatestSong
    }
}

// Define a key and provide a default value for it.
// If you're using optional values, this can just be nil.
struct SongRepositoryKey: EnvironmentKey {
    static let defaultValue = SongRepository(greatestSong: "All Too Well")
}

// Add the variable so we can access via keypath
extension EnvironmentValues {
    var songRepository: SongRepository {
        get { self[SongRepositoryKey.self] }
        set { self[SongRepositoryKey.self] = newValue }
    }
}

struct DayEleven_Previews: PreviewProvider {
    static var previews: some View {
        DayEleven()
            .environment(\.songRepository, SongRepository(greatestSong: "Anti-Hero"))
    }
}
