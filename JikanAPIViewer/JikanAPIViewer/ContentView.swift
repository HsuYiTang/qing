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
            VStack{
                Text("JikanAPI")
                    .foregroundColor(Color(hex: 0xA69A25))
                    .fontWeight(.heavy)
                    .font(.system(size: 75))
                Text("Viewer")
                    //.font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hex: 0xA69A25))
                    .font(.system(size: 75))
                Spacer()
                NavigationLink(destination: TopAnimeView().environmentObject(viewModel), isActive: $isLinkActive) {
                    Button {
                        print("Click Button")
                        self.isLinkActive = true
                    } label: {
                        Text("Go")
                            .font(.title)
                    }.controlSize(.large)
                        .padding()
                        .buttonStyle(ButtonView())
                }
                Spacer()
                Text("the viewer of jikan API")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .fontWeight(.light)
            }.frame(maxWidth:.infinity)
            //.background(Color("ViewPage"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TopAnimeViewModel())
    }
}
