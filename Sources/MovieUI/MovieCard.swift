// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
//
//  File.swift
//  
//
//  Created by Min Soe Zan on 12/9/24.
//

import SwiftUI
import TMDBMovieApi
import SkippingFlow

struct MovieCard: View {
    
    let movie: TMDBMovie
    
    var body: some View {
        VStack(alignment: .leading) {
            MoviePosterView(posterURLString: movie.posterLink)
            Text(movie.title)
                .foregroundStyle(.primary)
            Text(movie.releaseDate)
                .foregroundStyle(.secondary)
                .padding(.bottom)
            Text(movie.overview)
                .foregroundStyle(.secondary)
                .padding(.bottom)
            SkippingHFlow(alignment: .top) {
                ForEach(movie.genreIDS, id: \.self) { genre in
                    Text(genre.title)
                        .padding(.horizontal, 5)
                        .foregroundStyle(.secondary)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}
