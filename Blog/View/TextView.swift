//
//  TextView.swift
//  Blog
//
//  Created by Eduardo David De La Cruz Marrero on 4/10/21.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var height: CGFloat
    var fontSize: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return TextView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: fontSize)
        view.text = text
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        // For dynamic text height...
        func textViewDidChange(_ textView: UITextView) {
            
            let height = textView.contentSize.height
            self.parent.height = height
            
            // Upgrading text...
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            let height = textView.contentSize.height
            self.parent.height = height
        }
    }
}
