import SwiftUI

struct HomeView: View {
    
    @State var showNextScreen = false
    
    var body: some View {
        
        if showNextScreen {
            PlanetsView()
                .transition(.opacity)
        } else {
            VStack{
                Button {
                    withAnimation {
                        showNextScreen = true
                    }
                } label: {
                    Text("Começar")
                }
                
            }
        }
    }
}
