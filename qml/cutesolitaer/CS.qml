import QtQuick 1.1
import com.cutecube.common 1.0
import "qrc:/qml/com/cutecube/common/"


Rectangle{
    id: cuteSolitaer
    color: "black"
    state: "displayCredits"

    property bool soundEnabled: true

    onSoundEnabledChanged: {
        soundWelcome.disabledGlobal = !soundEnabled
    }

    Component.onCompleted: { soundWelcome.play() }

    states: [
        State {
            name: "displayCredits"
            PropertyChanges { target: aboutDialog; opacity: 1.0 }
            PropertyChanges { target: aboutDialogTranslate; y: 0 }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity,y"; easing.type: Easing.InOutQuad }
        }
    ]

    Timer{
        id: timerHideCredids
        running: true
        interval: 1500
        onTriggered: {
            cuteSolitaer.state = ""
            aboutDialog.canClose = true
        }
    }

    CSPalette{ id: palette }
    CuteSound{ id: soundWelcome; source: "qrc:/snd/tile-click-success.wav" }
    CuteSound{ id: soundIllegalMove; source: "qrc:/SoundIllegalMove" }
    CuteSound{ id: soundIllegalTile; source: "qrc:/SoundIllegalTile" }
    CuteSound{ id: soundLegalMove; source: "qrc:/snd/button-pressed.wav" }
    CuteSound{ id: soundGameLost; source: "qrc:/SoundLost" }
    CuteSound{ id: soundGameWon; source: "qrc:/SoundWon" }

    Item{
        id: menuBar
        anchors { left: parent.left; right: parent.right; top: parent.top }
        anchors.margins: 5
        height: 45

        CuteText{
            id: textTime
            text: board.gameTime
            color: "white"
            anchors.centerIn: parent
        }

        CuteText{
            id: textMoves
            text: "Move " + board.gameMove
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
        }

        CuteButton{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 15
            onClicked: menu.show()
            width: menuBar.height
            height: menuBar.height
            defaultColor: "black"
            Image{
                id: image
                //anchors.fill: parent
                anchors.centerIn: parent
                source: "qrc:///home.png"
                //fillMode: Image.PreserveAspectFit
            }
        }
    }

    CSBoard{
        id: board
        anchors {
            left: parent.left; right: parent.right; top: menuBar.bottom; bottom: parent.bottom
            leftMargin: 5; rightMargin: 5; topMargin: 10; bottomMargin: 25
        }
        onIllegalTile:{
            soundIllegalTile.play()
        }
        onLegalMove:{
            soundLegalMove.play()
        }
        onIllegalMove:{
            soundIllegalMove.play()
        }
        onGameWon: {
            messageBox.show(qsTr("You Won!\n\n:D"))
            soundGameWon.play()
        }
        onGameLost: {
            messageBox.show(qsTr("You Lost!\n\n:P"))
            soundGameLost.play()
        }
    }

    CSMenu{
        id: menu
        onStartNewGame: {
            board.startNewGame()
            menu.state = "hidden"
        }
        onResumeGame: {
            menu.state = "hidden"
        }
        onShowCredits: {
            menu.state = "hidden"
            cuteSolitaer.state = "displayCredits"
        }
        onQuitGame: {
            Qt.quit()
        }
    }

    CSMessageBox{ id: messageBox }

    CuteAboutDialog{
        id: aboutDialog
        anchors.fill: parent
        opacity: 0
        credits: CSCredits{}
        transform: Translate{ id: aboutDialogTranslate; y: cuteSolitaer.height }
        onCloseDialog: cuteSolitaer.state = ""
    }
}
