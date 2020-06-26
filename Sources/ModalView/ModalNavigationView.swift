//
//  ModalNavigationView.swift
//  ModalNavigationView
//
//  Created by HereTrix on 26/19/20.
//

import SwiftUI

private final class ModalNavigationPipe : ObservableObject {
    struct ContentView: Identifiable {
        fileprivate typealias ID = String
        fileprivate let id = UUID().uuidString
        var view: AnyView
    }
    @Published var content: ContentView? = nil
}

public enum ModalPresentationStyle {
    case sheet
    case currentContext
}

public struct ModalNavigationView<Content> : View where Content : View  {
    @ObservedObject private var modalView = ModalNavigationPipe()
    
    private var content: Content
    private let presentationStyle: ModalPresentationStyle
    
    public init(presentationStyle: ModalPresentationStyle = .currentContext,
                @ViewBuilder content: () -> Content) {
        self.content = content()
        self.presentationStyle = presentationStyle
    }
    
    public var body: some View {
        
        switch presentationStyle {
        case .currentContext:
            return currentContextContent()
        case .sheet:
            return sheetContent()
        }
    }
    
    private func sheetContent() -> AnyView {
        let view = content
            .environmentObject(modalView)
            .sheet(item: $modalView.content, content: { $0.view })
        return AnyView(view)
    }
    
    private func currentContextContent() -> AnyView {
        if modalView.content == nil {
            return AnyView(content
                .environmentObject(modalView))
        } else {
            return AnyView(modalView.content!.view)
        }
    }
}

public struct ModalNavigationLink<Label, Destination> : View where Label : View, Destination : View  {
    public typealias Builder = (_ dismiss: @escaping() -> ()) -> Destination
    @EnvironmentObject private var modalView: ModalNavigationPipe
    
    private enum Provider {
        case view(AnyView)
        case builder(Builder)
    }
    
    private var destinationProvider: Provider
    private var label: Label
    private var completion: (()->Void)?
    
    // Default initializer
    public init(destination: Destination,
                completion: (()->Void)? = nil,
                @ViewBuilder label: () -> Label) {
        self.destinationProvider = .view(AnyView(destination))
        self.label = label()
        self.completion = completion
    }
    
    // Use this initializer when `dismiss` method is needed in the modal view
    public init(@ViewBuilder destination: @escaping Builder,
                             completion: (()->Void)? = nil,
                             @ViewBuilder label: () -> Label) {
        self.destinationProvider = .builder(destination)
        self.label = label()
        self.completion = completion
    }
    
    public var body: some View {
        Button(action: presentModalView){ label }
    }
    
    private func presentModalView() {
        modalView.content = ModalNavigationPipe.ContentView(view: {
            switch destinationProvider {
            case let .view(view):
                return view
            case let .builder(build):
                return AnyView(build { self.dismissModalView() })
            }
        }())
    }
    
    private func dismissModalView() {
        modalView.content = nil
        completion?()
    }
}

