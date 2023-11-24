//
//  ContentView.swift
//  buttons
//
//  Created by Girish Verma on 2023-11-17.
//

import SwiftUI

struct ContentView: View {
    
    @State var matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5);
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
    
    
   
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<5) { row in
                HStack { // Adjust spacing as needed
                    ForEach(0..<5) { column in
                        Text(matrix[row][column] == 1 ? String(matrix[row][column]) : " ")
                            .frame(width: 40, height: 40) // Adjust the size as needed
                            .overlay(
                                Circle()
                                    .stroke(matrix[row][column] == 1 ? Color.black : Color.white, lineWidth: 2)
                            )
                            .background(
                                Circle()
                                    .fill(Color.white) // Or any other color you prefer
                            )
                            .onTapGesture {
                                // Handle the user's tap
                                level += 1
                                print(level)
                                // Your existing code
                                matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5)
                                BFS(matrix: &matrix, levelParam: level)
                            }
                    }
                }
                // Offset every other row
            }
        }
        .padding()
        .onAppear{
            BFS(matrix: &matrix, levelParam: level)
        }

    }
}

#Preview {
    ContentView()
}
