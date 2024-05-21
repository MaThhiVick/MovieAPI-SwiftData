//
//  InformationMovie.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI

struct InformationMovie: View {
    let title: String
    let information: String

    init(title: String, information: String) {
        self.title = title
        self.information = information
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            line()
                .padding(.bottom, 4)
            HStack(alignment: .top, spacing: 4) {
                Text("\(title):")
                    .font(.subheadline)
                Text(information)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, 3)
            }
        }
    }

    @ViewBuilder
    func line() -> some View {
        Rectangle()
            .frame(height: 0.3)
            .foregroundStyle(.gray)
    }
}

#Preview {
    InformationMovie(title: "Harry Potter", information: "test tset test test test etst test test test test")
}
