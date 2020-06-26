//
//  ContentView.swift
//  ModalNavigationViewExample
//
//  Created by HereTrix on 6/26/20.
//  Copyright © 2020 HereTrix. All rights reserved.
//

import SwiftUI
import ModalView

struct ContentView: View {
    
    @State var isPresenting = false
    
    var body: some View {
        VStack(spacing: 40) {
            
            ModalNavigationView(presentationStyle: .currentContext) {
                ModalNavigationLink(destination: { dismiss in
                    DetailsView(dismiss: dismiss)
                }) {
                    Text("Show over current context")
                }
            }
            .frame(width: 200, height: 200)
            
            ModalNavigationView(presentationStyle: .sheet) {
                ModalNavigationLink(destination: SheetDetails(),
                                    completion: {
                }) {
                    Text("Show as sheet context")
                }
            }
            
            Button(action: {
                self.isPresenting = true
            }) {
                Text("Modal with fullscreen")
                    .present(isPresented: $isPresenting,
                         style: .fullScreen) { FullscreenView() }
            }
        }
    }
}

struct SheetDetails: View {
    var body: some View {
        Text("This is sheet details")
    }
}

struct DetailsView: View {
    
    var dismiss: ()->Void
    
    var body: some View {
        Button(action: dismiss) {
            Text("This is details")
        }
    }
}

struct FullscreenView: View {
    var body: some View {
        Button(action: {
            self.dismissModalPresenter()
        }) {
            Text("Dismiss Fullscreen view")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
