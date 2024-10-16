//
//  StatusFilterView.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import SwiftUI

struct StatusFilterView: View {
    @State private var selectedTab: String?
    private var filterItems: [String] = []
    private var onTab: ((String) -> Void)?
    init(filterItems: [String], onTab: ((String) -> Void)? = nil) {
        self.filterItems = filterItems
        self.onTab = onTab
    }
    
    var body: some View {
        HStack {
            ForEach(filterItems, id: \.self) { status in
                
                    Text(status)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .foregroundColor(Color(.label))
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(selectedTab == status ? .black : .systemGray5), lineWidth: 2)
                        ).onTapGesture {
                            if selectedTab == status {
                                selectedTab = nil
                            } else {
                                selectedTab = status
                            }
                            onTab?(status)
                        }

            }
            Spacer()
        }
    }
}

#Preview {
    StatusFilterView(filterItems: ["Alive", "Dead", "unknown"])
}
