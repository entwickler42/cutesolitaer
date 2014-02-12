import QtQuick 1.1
import "qrc:/qml/com/cutecube/common/" as CuteCubeCommon


Item{
    id: menu
    state: "hidden"
    anchors.fill: parent

    function show()
    {
        state = ""
    }

    signal startNewGame()
    signal resumeGame()
    signal showCredits()
    signal quitGame()

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: menu; opacity: 0.0 }
            PropertyChanges { target: frame; opacity: 0.0 }
            PropertyChanges { target: background; opacity: 0 }
            PropertyChanges { target: frameTranslate; y: menu.width }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity" }
            NumberAnimation { properties: "x,y" }
        }
    ]

    Rectangle{
        id: background
        anchors.fill: parent
        color: palette.color1
        opacity: palette.opacity2

        MouseArea{
            anchors.fill: parent
            onClicked: resumeGame()
        }
    }

    CSFrame{
        id: frame
        anchors.centerIn: parent
        width: Math.min(320, parent.width-5)
        height: Math.min(cuteSolitaer.height, listView.count * 50 + 20)
        transform: Translate{ id: frameTranslate; y: 0 }

        MouseArea{ anchors.fill: frame }

        ListView{
            id: listView
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10
            clip: true
            model: VisualItemModel{
                CuteCubeCommon.CuteButton{
                    width: listView.width
                    text: qsTr("Resume Game")
                    onClicked: resumeGame()
                }
                CuteCubeCommon.CuteButton{
                    width: listView.width
                    text: qsTr("New Game")
                    onClicked: startNewGame()
                }
                CuteCubeCommon.CuteButton{
                    width: listView.width
                    text: cuteSolitaer.soundEnabled ? qsTr("Toggle Sound Off") : qsTr("Toggle Sound On")
                    onClicked: cuteSolitaer.soundEnabled = !cuteSolitaer.soundEnabled
                }
                CuteCubeCommon.CuteButton{
                    width: listView.width
                    text: qsTr("About")
                    onClicked: showCredits()
                }
                CuteCubeCommon.CuteButton{
                    width: listView.width
                    text: qsTr("Quit Game")
                    onClicked: quitGame()
                }
            }
        }
    }
}
