//
//  DefinitionView.swift
//  DecoderThing
//
//  Created by Duncan Wallace on 12/2/24.
//

import SwiftUI

struct DefinitionView: View {
    let definition: Definition

    var body: some View {
        NavigationLink(destination: DefinitionDetailView(definition: definition)) {
        HStack {
          Image(definition.coverImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 70)
            .cornerRadius(5)
            .padding(.leading, 8)
            Text(definition.title)
            .font(.headline)
            .lineLimit(1)
          Spacer()
        }
        .padding(.vertical, 8)
      }
    }
  }

struct DefinitonView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionView(definition: Definition(title: "Definition", coverImage: "word"))
    }
}

