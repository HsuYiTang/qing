//
//  ContentView.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TopAnimeViewModel()
    @State var isLinkActive = false
    var body: some View {
        NavigationView{
            NavigationLink(destination: TopAnimeView().environmentObject(viewModel), isActive: $isLinkActive) {
                Button {
                    print("Click Button")
                    self.isLinkActive = true
                } label: {
                    Text("GO")
                        .font(.title)
                }.frame(minWidth: 0, maxWidth: 100)
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TopAnimeViewModel())
    }
}
