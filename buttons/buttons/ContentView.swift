//
//  ContentView.swift
//  buttons
//
//  Created by Girish Verma on 2023-11-17.
//

import SwiftUI


struct CircleView: View {
    var row: Int
    var column: Int
    var isActivated: Bool
    var isFailed: Bool
    var matrix: Array<Array<Int>>
    var action: () -> Void

    var body: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(isActivated ? Color.green : isFailed ? Color.red : Color.white)
            .overlay(
                Circle()
                    .stroke(matrix[row][column] == 1 ? Color.black : Color.white, lineWidth: 2)
            )
            .onTapGesture(perform: action)
    }
}

struct ContentView: View {
    
    @State var matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5);
    @State private var matrixStates: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 5)

    @State var level: Int = 2;
    
    
    func isLegal(a: Int,b: Int) -> Bool{
        if a <= 4 && b <= 4 && a >= 0 && b >= 0 {
            return true
        }
            
        return false
    }
       
    
    func BFS(matrix: inout Array<Array<Int>>, levelParam: Int){
        
        var level = levelParam
        
        var opened = Array<Array<Int>>()
        var closed = Array<Array<Int>>()
        if level % 2 != 0{
            
            matrix[2][2] = 1;
            opened.append([2, 2])
            level -= 1
        } else {
            opened.append([2, 2])
        }
        
        print(opened)
        
        
        while opened.count > 0 && level > 0 {
            print(level)
            
            var node:Array<Int> = opened.removeFirst()
            closed.append(node)
            
            let row_actions: Array<Array<Int>> = [
                [node[0] - 1, node[1]]
            ]
            
            let col_actions: Array<Array<Int>> = [
                [node[0], node[1] - 1]
            ]
    
            
            for row_action in row_actions {
                if isLegal(a: row_action[0], b: row_action[1]) && !closed.contains([row_action[0], row_action[1]]) && level > 0{
                    if matrix[row_action[0]][row_action[1]] == 0 {
                        matrix[row_action[0]][row_action[1]] = 1
                        level -= 1
                    }
                    opened.append([row_action[0], row_action[1]])
                    
                    let opposite_row = 4 - row_action[0]
                    if isLegal(a: opposite_row, b: row_action[1]) && !closed.contains([opposite_row, row_action[1]]) && level > 0{
                        if matrix[opposite_row][row_action[1]] == 0 {
                            matrix[opposite_row][row_action[1]] = 1
                            level -= 1
                        }
                        opened.append([opposite_row, row_action[1]])
                    }
                }
                        
            }
            
            for col_action in col_actions {
                if isLegal(a: col_action[0], b: col_action[1]) && !closed.contains([col_action[0], col_action[1]]) && level > 0{
                    if matrix[col_action[0]][col_action[1]] == 0 {
                        matrix[col_action[0]][col_action[1]] = 1
                        level -= 1
                    }
                    opened.append([col_action[0], col_action[1]])
                    
                    let opposite_col = 4 - col_action[1]
                    
                    if isLegal(a: col_action[0], b: opposite_col) && !closed.contains([col_action[0], opposite_col]) && level > 0{
                        if matrix[col_action[0]][opposite_col] == 0 {
                            matrix[col_action[0]][opposite_col] = 1
                            level -= 1
                        }
                        opened.append([col_action[0], opposite_col])
                    }
                }
            }
        }
        
        print(matrix)
            
        
        
        
    }
    
    @State var win = false
    @State private var timer: Timer?
   
    var body: some View {
        HStack{
            VStack{
                ForEach((2...25).reversed(), id: \.self) { index in
                    
                    let opacity_: Double = index == level ? 1.0 : 0.2
                    
                    
                    HStack{
                        Text(index == level ? String(level) : "")
                        Rectangle()
                            .frame(width: 5, height: 10)
                            .foregroundColor(Color.black.opacity(opacity_))
                            .cornerRadius(5)
                            
                    }
                    
                      
                }
            }
            .padding(.horizontal, 0)
            .edgesIgnoringSafeArea(.horizontal)
            
            VStack(alignment: .leading) {
                ForEach(0..<5, id: \.self) { row in
                    HStack { // Adjust spacing as needed
                        ForEach(0..<5, id: \.self) { column in
                            
                            
                            
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(matrixStates[row][column] ? Color.green : matrixStates[row][column] == NULL ? Color.red : Color.white)
                                .overlay(
                                    Circle()
                                        .stroke(matrix[row][column] == 1 ? Color.black : Color.white, lineWidth: 2)
                                )
                                .onTapGesture {
                                    // Handle the user's tap
                                    let chance = Int.random(in: 0...10)
                                    
                                    if (chance <= 5){
                                        
                                        matrixStates[row][column] = true;
                                        
                                        
                                        timer?.invalidate()
                                        // Start a new timer that fires after 1 second
                                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                            level += 1
                                  
                                        }
                                        
                                    }else{
                                        matrixStates[row][column] = NULL;
                                        
                                        timer?.invalidate()
                                        // Start a new timer that fires after 1 second
                                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                            level = 2
                                            // Your existing code
                                            
                                        }
                                    }
                                    
                                    matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5)
                                    BFS(matrix: &matrix, levelParam: level)
                                    matrixStates = Array(repeating: Array(repeating: false, count: 5), count: 5)
                                    
                                    
                                    
                                    
                                    
                                }
                            
                        }
                    }.edgesIgnoringSafeArea(.horizontal)
                    // Offset every other row
                }
            }
            .padding()
            .edgesIgnoringSafeArea(.horizontal)
            .onAppear{
                BFS(matrix: &matrix, levelParam: level)
            }
            
        }
        .padding(.horizontal,0)
        .edgesIgnoringSafeArea(.horizontal)
        
        

    }
}

#Preview {
    ContentView()
}
