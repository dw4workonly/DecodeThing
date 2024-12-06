//
//  DefintionDetailView.swift
//  DecodeThing
//
//  Created by Duncan Wallace on 12/2/24.
//

import SwiftUI

struct DefinitionDetailView: View {
    let definition: Definition
    @State private var isPlaying = false
    @State private var volume = 0.5
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Image(definition.coverImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: proxy.size.width)
                        .cornerRadius(10)
                        .padding()
                    Text(definition.title)
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis massa et eros volutpat posuere a vel nisl.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
                VStack {
                    Spacer()
                    WordControlView()
                        .background(Color.white)
                }
            }
            .navigationTitle(definition.title)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct DefinitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionDetailView(definition: Definition(title: "Chill Hits", coverImage: "chill"))
    }
}

