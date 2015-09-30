#StackGrid

StackGrid is a dynamic view container, which automatically distributes views according to available space.
The end result looks something like this:
![Demo](resources/StackGrid-demo.gif)


It is based on iOS 9's UIStackViews, nesting them into each other to achieve the desired result.
To read more about the implementation read [IMPLEMENTATION.md](IMPLEMENTATION.md)

#Installation


#Usage
Using StackGrid is easy - after instatiation the following methods are used to set and alter the grid's views:

    
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
    grid.removeGridViewAtIndex(1)

    // Removes last view from grid
    grid.removeLastGridView()
    
        