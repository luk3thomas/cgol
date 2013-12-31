## Conway's Game of Life

### [Rules](http://www.bitstorm.org/gameoflife/)

Each cell has 8 neighbors

    +-----------+
    |   |   |   |
    +-----------+
    |   | X |   |
    +-----------+
    |   |   |   |
    +-----------+

1. A populated cell with 0 or 1 neighbors dies
1. A populated cell with 4, 5, 6, 7, or 8 neighbors dies
1. A populated cell with 2 or 3 neighbors survives
1. An unpopulated cell with 3 neighbors is born

### Structure

#### Board

A board is a set of rows and columns populated with cells.
The board is redrawn with each iteration of the game and cells are turned on or off based on their adjoining neighbors.

#### Cell

A cell is a single point on the board.
A cell is `alive?` based on the number of adjoining neighbors.

#### Screen

The screen draws the cells on the board.

#### Automaton

Scans the cells and sets the cell state.
