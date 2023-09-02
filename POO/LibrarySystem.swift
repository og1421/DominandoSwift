//
//  LibrarySystem.swift
//  DominandoSwift
//
//  Created by Orlando Moraes Martins on 30/08/23.
//

import Foundation

class Book {
    
    //Caracteristicas
    let id = UUID()
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
    private var books: [String: Book] = [ : ]
    private let queue = DispatchQueue(label: "LibraryQueue", attributes: .concurrent)
    
    func addBooks( _ book: Book ) {
        books[book.title] = book
    }
    
    func lendBook ( title: String, to user: inout User) {
        
        queue.sync{
            if let book = self.books[title], user.activeUser, book.available, user.borrowedBooks.count <= 3 {
                book.available = false
                user.borrowedBooks.append(book)
                
                print("Foi emprestado o livro \(book.title) para o usuario \(user.name)")
            } else {
                print("Não é possivel fazer o emprestimo para \(user.name)")
            }
        }
    }
    
    func showAvailableBooks () {
        let availableBooks = books.values.filter { $0.available }
        
        if availableBooks.isEmpty {
            print("Todos os livros foram emprestados")
        } else {
            print("Os seguintes titulos estão disponíveis para emprestimo")
            for book in availableBooks {
                print("Titulo: \(book.title), Editora: \(book.editora), Volume: \(book.volume)")
            }
        }
    }
    
    func returnBook ( title: String, to user: inout User ) {
        guard let book = books[title] else {
            print ("Livro não faz parte da coleção da biblioteca")
            return
        }
        
        if let index = user.borrowedBooks.firstIndex(where: { $0.id == books[title]?.id}){
            book.available = true
            user.borrowedBooks.remove(at: index)
            print("Livro \(title) devolvido por \(user.name)")
        } else {
            print ("Não foi possivel fazer a devolução do livro \(title)")
        }
        
    }
}

struct User {
    let userID = UUID()
    let name: String
    var borrowedBooks: [Book] = []
    var activeUser: Bool = false
    
    func showBorrowedBooks() {
        if borrowedBooks.isEmpty {
            print("O usuário não tem livros emprestados")
        } else {
            print("O usuário possui os seguintes livros emprestados")
            
            for book in borrowedBooks {
                print("Titulo: \(book.title), Editora: \(book.editora), Volume: \(book.volume)")
            }
        }
    }
    
}


let biblioteca = Library()

let book1 = Book(name: "O Pequeno Principe", author: "Antoine de Saint-Exupery", editora: "Harper Colins", volume: "Vol 1", numberOfPages: 130)

let book2 = Book(name: "Macbeth", author: "William Shakespeare", editora: "Oakshot", volume: "Vol 1", numberOfPages: 500)

biblioteca.addBooks(book1)
biblioteca.addBooks(book2)

biblioteca.showAvailableBooks()

let userQueue = DispatchQueue(label: "userQueue", attributes: .concurrent)

userQueue.async {
    var aluno1 = User(name: "Orlando")
    aluno1.activeUser = true
    biblioteca.lendBook(title: "O Pequeno Principe", to: &aluno1)
}

userQueue.async {
    var aluno2 = User(name: "Carlos")
    aluno2.activeUser = true
    biblioteca.lendBook(title: "O Pequeno Principe", to: &aluno2)
}

userQueue.async {
    var aluno3 = User(name: "Gabriel")
    biblioteca.lendBook(title: "O Pequeno Principe", to: &aluno3)
}

biblioteca.showAvailableBooks()
