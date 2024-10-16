//
//  CharacterDetailsView.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    @Environment(\.dismiss) var dismiss
    private let character: Character
    init(character: Character) {
        self.character = character
    }
    
    var body: some View {
        VStack (spacing: 12){
            ZStack(alignment: .top) {
                headerImage
                HStack {
                    backButton
                    Spacer()
                }
                .padding([.leading], 16)
            }
            nameSpacies
                .padding(.top, -32)
            location
            Spacer()
        }
    }
    
    @ViewBuilder var headerImage: some View {
        CachedAsyncImage(url: URL(string: character.image)) { image in
            image
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .scaledToFit()
                .cornerRadius(32)
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
                .frame(width: 80, height: 80)
        }
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder var backButton: some View {
        Button(action: { dismiss() }, label: {
            Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                 })
        .foregroundStyle(.black)
        .padding()
        .background { Circle().fill(Color.white) }
    }
    
    @ViewBuilder var location: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(Strings.LocationLabel).font(.headline)
            Text(character.location.name)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    @ViewBuilder var nameSpacies: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(character.name).font(.title2).bold()
                HStack {
                    Text("\(character.species) •").font(.body).foregroundStyle(Color(.systemGray))
                    Text(character.gender).font(.body).foregroundStyle(Color(.systemGray2))
                }
            }
            
            Spacer()
            
            Text(character.status.rawValue)
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(Color(.black))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 16).fill(.cyan))
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CharacterDetailsView(character: Character(
        id: 1,
        name: "test",
        status: .alive,
        species: "",
        type: "",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [],
        url: "",
        created: "",
        location: Location(name: "MyLocation", url: nil),
        gender: "Male")
    )
}
