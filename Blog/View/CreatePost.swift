//
//  CreatePost.swift
//  Blog
//
//  Created by Eduardo David De La Cruz Marrero on 4/10/21.
//

import SwiftUI

struct CreatePost: View {
    
    @EnvironmentObject var blogData: BlogViewModel
    
    // Post properties
    @State var postTitle = ""
    @State var authorName = ""
    @State var postContent: [PostContent] = []
    
    var body: some View {
        
        // Since we need Nav Buttons...
        // So including NavBar...
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        TextField("Post Title", text: $postTitle)
                            .font(.title2)
                        Divider()
                    }
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Author:")
                            .font(.caption.bold())
                        TextField("iJustine", text: $authorName)
                        Divider()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
                    // Iterating post content
                    ForEach($postContent) { $content in
                        VStack {
                            
                            // Image URL...
                            if content.type == .Image {
                                if content.showImage && content.value != "" {
                                    WebImage(url: content.value)
                                    // if tap change url...
                                        .onTapGesture {
                                            withAnimation {
                                                content.showImage = false
                                            }
                                        }
                                } else {
                                    // Textfield for URL...
                                    TextField("Image URL", text: $content.value, onCommit: {
                                        withAnimation {
                                            content.showImage = true
                                        }
                                        // To show image when pressed return...
                                    })
                                }
                            } else {
                                // Custom text editor from UIKit
                                TextView(text: $content.value, height: $content.height, fontSize: getFontSize(type: content.type))
                                // Aprox height based on font for first display...
                                    .frame(height: content.height == 0 ? getFontSize(type: content.type) * 2 : content.height)
                                    .background(
                                        Text(content.type.rawValue)
                                            .font(.system(size: getFontSize(type: content.type)))
                                            .foregroundColor(.gray)
                                            .opacity(content.value == "" ? 0.7 : 0)
                                            .padding(.leading, 5)
                                        , alignment: .leading
                                    )
                            }
                        }
                    }
                    
                    // Menu button to insert post content
                    Menu {
                        // Iterating cases...
                        ForEach(PostType.allCases, id: \.rawValue) { type in
                            Button(type.rawValue) {

                                // Appending new post content...
                                withAnimation {
                                    postContent.append(PostContent(value: "", type: type))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            })
            // Changing post title Dynamically
            .navigationTitle(postTitle == "" ? "Post Title" : postTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        blogData.createPost.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        
                    }
                }
            }
        }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Dynamic height...

func getFontSize(type: PostType) -> CGFloat {
    // Your own
    switch type {
    case .Header:
        return 24
    case .SubHeading:
        return 22
    case .Paragraph, .Image:
        return 18
    }
}

// Async Image...

struct WebImage: View {
    
    var  url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phrase in
            if let image = phrase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                    .cornerRadius(15)
            } else {
                if let _ = phrase.error {
                    Text("Failed to load image 😫")
                } else {
                    ProgressView()
                }
            }
        }
        .frame(height: 250)
    }
}
