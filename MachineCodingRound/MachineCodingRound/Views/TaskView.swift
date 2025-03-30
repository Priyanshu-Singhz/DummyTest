//
//  TaskView.swift
//  MachineCodingRound
//
//  Created by Priyanshu Singh on 29/03/25.
//

import SwiftUI

struct TaskView: View {
    @State private var textfield = ""
    @State private var tasks: [Tasks] = []
    
    let myUserdefault = UserDefaults.standard
    
    // Load tasks when view appears
    var body: some View {
        VStack{
            HStack{
                TextField("Enter your tasks here", text: $textfield)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    guard !textfield.isEmpty else { return }
                    
                    // Add new task
                    tasks.append(Tasks(task: textfield, description: ""))
                    
                    // Save to UserDefaults
                    saveTasks()
                    
                    // Clear textfield
                    textfield = ""
                    
                } label: {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            List {
                ForEach(tasks) { task in
                    HStack{
                        VStack(alignment: .leading){
                            Text(task.task)
                                .font(.headline)
                            if let description = task.description, !description.isEmpty {
                                Text(description)
                                    .font(.caption)
                            }
                        }
                        Spacer()
                        Button {
                            // Delete task
                            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                tasks.remove(at: index)
                                saveTasks()
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            loadTasks()
        }
    }
    
    // Function to save tasks to UserDefaults
    private func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            myUserdefault.set(encodedData, forKey: "myTasks")
        } catch {
            print("Error encoding tasks: \(error.localizedDescription)")
        }
    }
    
    // Function to load tasks from UserDefaults
    private func loadTasks() {
        do {
            if let data = myUserdefault.data(forKey: "myTasks") {
                tasks = try JSONDecoder().decode([Tasks].self, from: data)
            }
        } catch {
            print("Error decoding tasks: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TaskView()
}

