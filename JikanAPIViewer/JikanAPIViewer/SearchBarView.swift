import SwiftUI

struct SearchBar: View {
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    @State private var isEditing = false
    var body: some View {
        HStack {
            TextField("輸入要搜尋的動畫名稱", text: $animeSearchViewModel.name)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)

                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                animeSearchViewModel.name = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                HStack {
                    Button {
                        animeSearchViewModel.searchAnime(name: animeSearchViewModel.name)
                        animeSearchViewModel.cache = animeSearchViewModel.name
                    } label: {
                        Text("Search")
                    }.buttonStyle(ButtonView())
                    Button(action: {
                        self.isEditing = false
                        animeSearchViewModel.name = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .buttonStyle(ButtonView())
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
        }
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
