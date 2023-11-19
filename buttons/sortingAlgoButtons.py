def isLegal(a, b):
    if a <= 4 and b <= 4 and a >= 0 and b >= 0:
        return True
    return False

def main():
    opened = []
    closed = []
    d = [
        ['y', 'y', 'y', 'y', 'y'],
        ['y', 'y', 'y', 'y', 'y'],
        ['y', 'y', 'y', 'y', 'y'],
        ['y', 'y', 'y', 'y', 'y'],
        ['y', 'y', 'y', 'y', 'y'],
    ]

    x = 9

    if x % 2 != 0:
        d[2][2] = 'x'
        opened.append([2, 2])
        x -= 1
    else:
        opened.append([2, 2])

    while len(opened) > 0 and x > 0:
        node = opened.pop(0)
        closed.append(node)

        # Define ROW and COLUMN actions
        row_actions = [
            [node[0] - 1, node[1]],
        ]

        col_actions = [
            [node[0], node[1] - 1],
        ]

        for row_act in row_actions:
            if isLegal(row_act[0], row_act[1]) and ([row_act[0], row_act[1]] not in closed) and x>0:
                # Legal action, editing the grid
                d[row_act[0]][row_act[1]] = "x"
                x -= 1
                opened.append([row_act[0], row_act[1]])

                # Set 'x' in the corresponding position in the opposite row
                opposite_row = 4 - row_act[0]
                opposite_col = row_act[1]
                if isLegal(opposite_row, opposite_col) and ([opposite_row, opposite_col] not in closed) and x>0:
                    d[opposite_row][opposite_col] = "x"
                    x -= 1
                    opened.append([opposite_row, opposite_col])
            
                

        for col_act in col_actions:
            if isLegal(col_act[0], col_act[1]) and ([col_act[0], col_act[1]] not in closed) and x>0:
                d[col_act[0]][col_act[1]] = "x"
                x -= 1
                opened.append([col_act[0], col_act[1]])

                # Set 'x' in the corresponding position in the opposite column
                opposite_row = col_act[0]
                opposite_col = 4 - col_act[1]
                if isLegal(opposite_row, opposite_col) and ([opposite_row, opposite_col] not in closed) and x>0:
                    d[opposite_row][opposite_col] = "x"
                    x -= 1
                    opened.append([opposite_row, opposite_col])

    for row in d:
        for a in row:
            print(a, end=' ')
        print()

main()
