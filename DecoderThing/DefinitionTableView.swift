//
//  DefinitionTableView.swift
//  DecoderThing
//
//  Created by Duncan Wallace on 12/2/24.
//

import SwiftUI

struct DefinitionTableView: View {
    @State private var definitions = [
        Definition(title: "hedera", coverImage: "dlt"),
        Definition(title: "multiversex", coverImage: "dlt"),
        Definition(title: "solana", coverImage: "dlt"),
        Definition(title: "litecoin", coverImage: "dlt"),
        Definition(title: "saucerswap", coverImage: "defi"),
        Definition(title: "xexchange", coverImage: "defi"),
        Definition(title: "uniswap", coverImage: "defi"),
        Definition(title: "litecoin", coverImage: "dlt")
    ]

    var body: some View {
      List {
        ForEach(definitions) { definition in
            DefinitionView(definition: definition)
        }
        .onDelete { indexSet in
            definitions.remove(atOffsets: indexSet)
        }
        .onMove { indices, newOffset in
            definitions.move(fromOffsets: indices, toOffset: newOffset)
        }
      }
      .navigationTitle("Definitions")
      .navigationBarItems(trailing: EditButton())
    }
  }

struct DefinitionTableView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionTableView()
    }
}
