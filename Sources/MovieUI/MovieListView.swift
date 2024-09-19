// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
//
//  MovieListView.swift
//
//
//  Created by Min Soe Zan on 11/9/24.
//

import SwiftUI
import TMDBMovieApi

struct MovieListingView: View {

    let movies: [TMDBMovie]
    let loading: Bool
    let onFetchMore: (TMDBMovie) -> Void
    let onSelect: (TMDBMovie) -> Void

    var body: some View {
        List {
            ForEach(movies, id: \.id) { movie in
                MovieCard(movie: movie)
                    .onAppear {
                        onFetchMore(movie)
                    }
                    .onTapGesture {
                        onSelect(movie)
                    }
            }
            if loading {
                ProgressView()
            }
        }
        .listStyle(.plain)
    }
}

struct MovieListView: View {

    @State private var path = NavigationPath()

    init(type: MovieType, api: TMDBMovieApi) {
        self.viewModel = MovieViewModel(movieType: type, movieApi: api)
    }

    @ObservedObject var viewModel: MovieViewModel

    public var body: some View {
        navigatingListView
    }

    private var listView: some View {
        MovieListingView(movies: viewModel.movies, loading: viewModel.loading) {
            movie in
            Task {
                await viewModel.fetchMoreIfLast(item: movie)
            }
        } onSelect: { movie in
            path.append(movie)
        }
        .refreshable {
            await viewModel.reload()
        }
        .alert("Error fetching Movies", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {
                viewModel.showError = false
            }
        }

    }

    private var navigatingListView: some View {
        NavigationStack(path: $path) {
            listView
                .navigationDestination(for: TMDBMovie.self) { movie in
                    VStack {
                        Text(movie.title)
                        MoviePosterView(posterURLString: movie.posterLink)
                    }
                }
        }
    }
}

@MainActor
class MovieViewModel: ObservableObject {

    let movieType: MovieType
    let movieApi: TMDBMovieApi

    @Published var movies: [TMDBMovie] = []
    @Published var loading = false
    @Published var showError = false
    private var tmdbMovies: TMDBMovies?

    init(movieType: MovieType, movieApi: TMDBMovieApi) {
        self.movieType = movieType
        self.movieApi = movieApi
        Task {
            await fetchPopular(page: 1)
        }
    }

    func fetchMoreIfLast(item: TMDBMovie) async {
        if movies.last == item, let tmdbMovies, !tmdbMovies.lastPage {
            await fetchPopular(page: tmdbMovies.page + 1)
        }
    }

    func reload() async {
        if let tmdbMovies {
            await fetchPopular(page: tmdbMovies.page)
        } else {
            await fetchPopular(page: 1)
        }

    }

    func fetchPopular(page: Int) async {
        showError = false
        loading = true
        do {
            let _tmdbMovies = try await movieApi.get(
                movieType: movieType, page: page)
            movies += _tmdbMovies.results
            tmdbMovies = _tmdbMovies
        } catch {
            logger.error("Error fetching page - \(page)")
            logger.error("\(error.localizedDescription)")
            showError = true
        }
        loading = false
    }
}

extension TMDBMovies {

    var lastPage: Bool {
        page == totalPages
    }
}

extension TMDBMovie {

    var posterLink: String {
        "https://image.tmdb.org/t/p/original/" + posterPath
    }
}
