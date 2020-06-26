//
//  ModalPresenter.swift
//  
//
//  Created by HereTrix on 6/26/20.
//

import SwiftUI
import UIKit
import Combine

public extension View {
    func present<Content: View>(isPresented: Binding<Bool>,
                 style: UIModalPresentationStyle,
                 @ViewBuilder content: @escaping () -> Content) -> some View {
        let presenter = ModalPresenter(isPresented: isPresented,
                                       style: style,
                                       modal: content,
                                       content: self)
        return AnyView(presenter)
    }
    
    func dismissModalPresenter(completion: (()->Void)? = nil) {
        rootController()?.dismiss(animated: true,
                                  completion: completion)
    }
}

fileprivate func rootController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes.compactMap {
        $0 as? UIWindowScene
    }

    guard !scenes.isEmpty else { return nil }
    for scene in scenes {
        guard let root = scene.windows.first?.rootViewController else {
            continue
        }
        return root
    }
    return nil
}

fileprivate struct ModalPresenter<Content: View, ModalContent: View>: View {
    @Binding var isPresented: Bool
    private var presentedController: UIHostingController<AnyView>
    var style: UIModalPresentationStyle
    var modal: () -> ModalContent
    var content: Content
    
    init(isPresented binding: Binding<Bool>,
                     style: UIModalPresentationStyle,
                     @ViewBuilder modal: @escaping () -> ModalContent,
                                  content: Content) {
        self._isPresented = binding
        self.style = style
        self.modal = modal
        self.content = content
        presentedController = UIHostingController(rootView: AnyView(EmptyView()))
    }

    var body: some View {
        if isPresented {
            present()
        }
        else {
            dismiss()
        }

        return content
    }

    func present() {
        guard let controller = rootController() else { return }

        presentedController.rootView = AnyView(modal())
        presentedController.modalPresentationStyle = style
        controller.present(presentedController, animated: true, completion: nil)
    }

    func dismiss() {
        presentedController.dismiss(animated: true, completion: nil)
    }
}
