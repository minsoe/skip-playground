// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
//
//  SwiftUIView.swift
//  
//
//  Created by Min Soe Zan on 11/9/24.
//

import SwiftUI

struct MoviePosterView: View {
    
    let posterURLString: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: posterURLString)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
    }
}
