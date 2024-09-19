// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI
import MovieUI
import TMDBMovieApi


public struct ContentView: View {

    private let token: String
    
    public init(token: String) {
        self.token = token
    }
       
    public var body: some View {
        MovieUI(movieApi: TMDBMovieApiFactory.make(token: token))
    }
}



