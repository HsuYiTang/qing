import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TopAnimeViewModel()
    @State var isLinkActive = false
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("JikanAPI")
                    .foregroundColor(.indigo)
                    //.foregroundColor(Color(hex: 0xA69A25))
                    .fontWeight(.heavy)
                    .font(.system(size: 75))
                Text("Viewer")
                    .fontWeight(.heavy)
                    .foregroundColor(.indigo)
                    //.foregroundColor(Color(hex: 0xA69A25))
                    .font(.system(size: 75))
                Spacer()
                NavigationLink(destination: MainView().environmentObject(viewModel), isActive: $isLinkActive) {
                    Button {
                        self.isLinkActive = true
                    } label: {
                        Text("前往")
                            .font(.system(.title,design: .rounded))
                    }.controlSize(.large)
                        .padding()
                        .buttonStyle(ButtonView())
                }
                Spacer()
                Text("the viewer of jikan API")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .fontWeight(.light)
            }.frame(maxWidth:.infinity)
                .background(Image("back"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TopAnimeViewModel())
    }
}
