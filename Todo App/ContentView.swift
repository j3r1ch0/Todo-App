//
//  ContentView.swift
//  Todo App
//
//  Created by Michael Myers on 11/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newTodo = ""
    @State private var allTodos: [TodoItem] = []

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add ToDo...", text: $newTodo).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        guard !self.newTodo.isEmpty else { return }
                        self.allTodos.append(TodoItem(todo: self.newTodo))
                        self.newTodo = ""
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.leading, 5)
                }.padding()
                
                List {
                    ForEach(allTodos) { TodoItem in
                        Text(TodoItem.todo)
                    }
                
            }
            .navigationBarTitle("Todos")
        }
    }
    }
    
    private func saveTodos() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: "todosKey")
      }
    private func loadTodos() {
       if let todosData = UserDefaults.standard.value(forKey: "todosKey") as? Data {
         if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
           self.allTodos = todosList
         }
       }
     }
    private func deleteTodo(at offsets: IndexSet) {
        self.allTodos.remove(atOffsets: offsets)
        saveTodos()
      }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TodoItem: Codable, Identifiable {
    var id = UUID()
    let todo: String
}

