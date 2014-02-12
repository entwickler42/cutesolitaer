import QtQuick 1.1

Rectangle {
    id: tile
    smooth: true
    border { color: "silver"; width: 2 }
    radius: 25

    property bool selected: false

    Behavior on color{
        ColorAnimation { duration: 200 }
    }

    states: [
        State {
            name: "Used"
            PropertyChanges { target: tile; color: selected ? "silver" : "white" }
        },
        State {
            name: "Unused"
            PropertyChanges { target: tile; color: "black" }
        }
    ]
}
