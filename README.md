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

A board is a set of rows and columns populated with cells and printed to SDOUT.
The board is redrawn with each iteration of the game and cells are turned on or off based on their adjoining neighbors.

##### Instance variables

1. `size` [rows, columns]. An array or rows and columns. e.g. [100, 200]. 
1. `fps` integer. The number of frames per second
1. `population`. You may pre populate the board if you like, otherwise the board is populated by random.

#### Cell

A cell is a single point on the board.
A cell is `alive` or `dead` based on the number of adjoining neighbors.

##### Instance variables

1. `row` Integer. The row of the cell
1. `column` Integer. The column of the cell
1. `alive` Boolean. The current state of the cell. `true` if the cell is alive, or `false` if the cell is dead

##### Methods

1. `alive=` Boolean. Assign the state of the cell
1. `alive?` Boolean. The next state of the cell.  `true` if the cell should be alive, or `false` if the cell should be dead

##### Private Methods

1. `lonely?` Boolean. `true` if the cell should die from loneliness, or `false` if the cell should remain alive
1. `crowded?` Boolean. `true` if the cell should die from overpopulation, or `false` if the cell should remain alive
1. `sustained?` Boolean. `true` if the cell should remain alive, or `false` if the cell should die
1. `lush?` Boolean. `true` if the cell should live, or `false` if the cell should remain dormant
