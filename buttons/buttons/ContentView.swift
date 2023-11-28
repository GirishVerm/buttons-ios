//
//  ContentView.swift
//  buttons
//
//  Created by Girish Verma on 2023-11-17.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabaseInternal

struct CircleButtonView: View {
    var row: Int
    var column: Int
    var matrix: Array<Array<Int>>
    var matrixState: Array<Array<Int>>
    var action: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(
                    matrix[row][column] == 1 && matrixState[row][column] == 1 ? Color.green 
                    :
                    matrix[row][column] == 1 && matrixState[row][column] == 2 ? Color.red
                    :
                        Color.white
                )
                .overlay(
                    Circle()
                        .stroke(matrix[row][column] == 1 ? Color.black : Color.white, lineWidth: 2)
                    
                )
                .overlay(
                    Image(systemName: matrixState[row][column] == 1 ? "checkmark.circle": "xmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                
                )
                .onTapGesture{
                    if matrix[row][column] == 1 {
                        action()
                    }
                }

            
        }
    }
}

struct ContentView: View {

    var ref = Database.database().reference();
    @State var matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5);
    @State private var matrixStates = Array(repeating: Array(repeating: 0, count: 5), count: 5);
    @State var level: Int = 2;
    @State private var timer: Timer?
    @State private var showLeaderboard = false
    
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
        
        
        
        while opened.count > 0 && level > 0 {
            
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
        
            
        
        
        
    }
    
    func updateScoreIfNeeded(with level: Int) {
        let scoreRef = Database.database().reference(withPath: "users/\(GlobalSettings.uuid)/score")

        scoreRef.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            var score = currentData.value as? Int ?? 0
            // Only set this to the current level if it's higher
            if level > score {
                score = level
                currentData.value = score
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.abort()
        }) { (error, committed, snapshot) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
            }
            if committed {
                print("Score updated to: \(snapshot?.value ?? "nil")")
            }
        }
    }

    
    func action(row: Int, col: Int){
        
        print(GlobalSettings.uuid)
        
        let chance:Int = level > 4 ? Int.random(in: 0..<level/2) : Int.random(in: 0..<2)
        
        if(chance == 0){
            matrixStates[row][col] = 1;
            
            
            timer?.invalidate()
    // Start a new timer that fires after 1 second
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                if level >= 25{
                    level = 2
                }else{
                    level += 1
                    
                }
                matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5)
                BFS(matrix: &matrix, levelParam: level)
                matrixStates = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    //
            }
        }else{
            updateScoreIfNeeded(with: level)
            matrixStates[row][col] = 2;
            
            
            timer?.invalidate()
    // Start a new timer that fires after 1 second
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                level = 2
                matrix = Array(repeating: Array(repeating: 0, count: 5), count: 5)
                BFS(matrix: &matrix, levelParam: level)
                matrixStates = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    //
            }
        }
        
        
    }
    

    var body: some View {
        NavigationView{
            
            HStack {
                // ... Your existing code ...

                VStack(alignment: .leading) {
                    ForEach(0..<5, id: \.self) { row in
                        HStack {
                            ForEach(0..<5, id: \.self) { column in
                                CircleButtonView(row: row, column: column, matrix: matrix, matrixState: matrixStates) {
                                    action(row: row, col: column)
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    BFS(matrix: &matrix, levelParam: level)
                }
            }
            .toolbar{
                MultiLineNavigationTitle(line1: "Level " + String(level), line2: GlobalSettings.uuid )
            }
            .navigationBarItems(trailing:
                            NavigationLink(destination: ScoresView()) {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(.black)
                            }
                        )
            .navigationBarTitleDisplayMode(.automatic)
            .padding(.all, 0)
            .edgesIgnoringSafeArea(.horizontal)
        }
        
        
    }
}
struct MultiLineNavigationTitle: View {
    var line1: String
    var line2: String

    var body: some View {
        VStack {
            Text(line1)
                .font(.headline) // Customize the font as needed
                
            Text(line2)
                .textScale(.secondary)
                .font(.subheadline) // Customize the font as needed
        }
    }
}
// ... Preview provider ...


#Preview {
    ContentView()
}
