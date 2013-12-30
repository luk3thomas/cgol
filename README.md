## Conway's Game of Life

### [Rules](http://www.bitstorm.org/gameoflife/)

Each cell has 8 neighboors

    +-----------+
    |   |   |   |
    +-----------+
    |   | X |   |
    +-----------+
    |   |   |   |
    +-----------+

**For a space that is 'populated'**:

* Each cell with one or no neighbors dies, as if by loneliness.
* Each cell with four or more neighbors dies, as if by overpopulation.
* Each cell with two or three neighbors survives.

**For a space that is 'empty' or 'unpopulated'**:

* Each cell with three neighbors becomes populated.

### How it works

1. A populated cell with 0 or 1 dies
1. A populated cell with 4, 5, 6, 7, or 8 dies
1. A populated cell with 2 or 3 survives
1. An unpopulated cell with 3 is born
