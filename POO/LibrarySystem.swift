//
//  LibrarySystem.swift
//  DominandoSwift
//
//  Created by Orlando Moraes Martins on 30/08/23.
//

import Foundation

class Book {
    
    //Caracteristicas
    let title: String
    let author: String
    let editora: String
    let volume: String
    let numberOfPages: Int
    var available: Bool = true

    init(name: String, author: String, editora: String, volume: String, numberOfPages: Int) {
        self.title = name
        self.author = author
        self.editora = editora
        self.volume = volume
        self.numberOfPages = numberOfPages
    }

}

class Library {
    var books: [String: Book] = [ : ]
    
    func addBooks( _ book: Book ) {
        books[book.title] = book
    }
    
    func lendBook ( title: String, to user: inout User) {
        if let book = books[title], user.activeUser, book.available, user.borrowedBooks.count <= 3 {
            book.available = false
            user.borrowedBooks.append(book)
        }
    }
}

struct User {
    let userID = UUID()
    let name: String
    var borrowedBooks: [Book] = []
    var activeUser: Bool = false
    
}


