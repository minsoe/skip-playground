// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
//
//  File.swift
//  
//
//  Created by Min Soe Zan on 11/9/24.
//

import SwiftUI
import OSLog
import TMDBMovieApi

public struct MovieUI: View {
    
    private let movieApi: TMDBMovieApi
    
    public init(movieApi: TMDBMovieApi) {
        self.movieApi = movieApi
    }
    
    public var body: some View {
        tabView
    }
    
    private var tabView: some View {
        TabView {
            MovieListView(type: .popular, api: movieApi)
                .tabItem {
                    Label("Popular", systemImage: "paperplane")
                }
                
            MovieListView(type: .top_rated, api: movieApi)
                .tabItem {
                    Label("Top Rated", systemImage: "star")
                }
        }
    }
}


let logger: Logger = Logger(subsystem: "com.zuhlke.app.cross.playground", category: "MovieUI")
