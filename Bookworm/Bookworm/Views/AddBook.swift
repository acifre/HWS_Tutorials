//
//  AddBook.swift
//  Bookworm
//
//  Created by Anthony Cifre on 5/24/23.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    @State private var date = Date.now
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var entryIsValid: Bool {
        if title.trimmingCharacters(in: .whitespaces).isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
        
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre of book", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    DatePicker("Date finished", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        
                        print(genre)
                        let newBook = Book(context: moc)
                        
                        newBook.id = UUID()
                        newBook.date = date
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        
                        try? moc.save()
                        
                        dismiss()
                        
                    }
                }
                .disabled(!entryIsValid)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
