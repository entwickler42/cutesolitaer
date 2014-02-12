import QtQuick 1.1
import "qrc:/qml/com/cutecube/common/"


Item{
    id: messageBox
    state: "hidden"
    anchors.fill: parent

    function show(msg)
    {
        message.text = msg
        state = ""
    }

    states: [
        State{
            name: "hidden"
            PropertyChanges { target: background; opacity: 0 }
            PropertyChanges { target: message; opacity: 0 }
            PropertyChanges { target: frame; opacity: 0 }
            PropertyChanges { target: transformFrame; y: height }
            PropertyChanges { target: transformMessage; y: height }
            PropertyChanges { target: messageBox; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation{ properties: "y"; }
            NumberAnimation{ properties: "opacity"; }
        }
    ]

    Rectangle{
        id: background
        anchors.fill: parent
        color: palette.color1
        opacity: palette.opacity2
    }

    CSFrame{
        id: frame
        anchors.centerIn: parent
        width: Math.min(cuteSolitaer.width, message.paintedWidth + 80)
        height: Math.min(cuteSolitaer.height, message.paintedHeight + 80)
        transform: Translate{ id: transformFrame }
    }

    CuteText{
        id: message
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        state: "big"
        transform: Translate{ id: transformMessage }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: parent.state = "hidden"
    }
}
