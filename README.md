# StackGrid

StackGrid is a dynamic view container, which automatically distributes views according to available space.
The end result looks something like this:

![Demo](docs/resources/StackGrid-demo.gif)


It is based on UIKit's UIStackViews, nesting them into each other to achieve the desired result.
To read more about the implementation read [IMPLEMENTATION.md](docs/IMPLEMENTATION.md)

## Installation
#### Carthage
The easiest way to get started with StackGrid is to use [Carthage](https://github.com/carthage/carthage). Simply add 

`github "VFUC/StackGrid"` to your `Cartfile`.

For further Carthage instructions, [check out how to add a Carthage framework to your project here.](https://github.com/carthage/carthage#adding-frameworks-to-an-application)

#### Manual Copy
Clone the repository somewhere or download it as ZIP archive. Add the files `StackGrid.swift` and `StackGrid-Extensions.swift` to your project.

## Usage
Using StackGrid is easy - after instatiation the following methods are used to set and alter the grid's views:


```Swift
let grid = StackGrid()

let aSingleView = UIView()
let multipleViews = [UIView(), UIView(), UIView()]

// Sets views to be displayed, overwrites all current views
grid.setGridViews(multipleViews) 

// Appends view to the end of the current view stack
grid.addGridView(aSingleView)

// Appends multiple views
grid.addGridViews(multipleViews)

// Removes view from grid for a given index
grid.removeGridView(at: 1)

// Removes last view from grid
grid.removeLastGridView()

// Set the root node orientation
// Vertical works best on screens with portrait-like dimensions, horizontal for landscape ones
grid.setRootAxis(.horizontal)
grid.setRootAxis(.vertical) 
```