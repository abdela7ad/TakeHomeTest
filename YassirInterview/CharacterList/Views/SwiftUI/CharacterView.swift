//
//  CharacterView.swift
//  YassirInterview
//
//  Created by Abdelahad on 14/10/2024.
//

import SwiftUI

struct CharacterView: View {
    let character : Character
    var body : some View {
        HStack{
            CachedAsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .frame(width: 80, height: 80)
            }
            VStack(alignment: .leading) {
                Text(character.name).font(.headline)
                Text(character.species)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 2)
        )
    }
}

#Preview {
    CharacterView(character: Character(id: 1, name: "test", status: .alive, species: "", type: "", image: "", episode: [], url: "", created: "", location: Location(name: "MyLocation", url: nil), gender: "Male"))
}
