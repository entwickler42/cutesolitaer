import QtQuick 1.1
import 'csengine.js' as CSEngine

Item{
    signal illegalTile
    signal illegalMove
    signal legalMove
    signal gameWon
    signal gameLost

    property string gameState: CSEngine.getGameState()
    property int selectedTile: -1
    property int gameTime: 0
    property int gameMove: 0

    function startNewGame()
    {
        CSEngine.loadTemplate()
        for(var i=0; i<tiles.count; i++){
            tiles.itemAt(i).state = CSEngine.getTileState(i)
        }
        gameMove = 0
        gameTime = 0
        selectedTile = -1
    }

    function updateGameState()
    {
        gameState = CSEngine.getGameState()
        switch (gameState)
        {
        case "won": gameWon(); break
        case "lost": gameLost(); break
        default: legalMove()
        }
    }

    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_C) {
            console.log('Key C was pressed');
            updateGameState()
            event.accepted = true;
        }
    }

    Timer{
        repeat: true
        running: gameState == "playing" && gameMove > 0
        onTriggered: gameTime += 1;
    }

    Grid {
        id: board
        anchors.centerIn: parent
        rows: CSEngine.m_state.length
        columns: CSEngine.m_state[0].length
        spacing: 5

        Repeater{
            id: tiles
            model: board.rows * board.columns

            Item{
                width: height
                height:
                    if (board.parent.width < board.parent.height) board.parent.width / board.columns - board.spacing
                    else board.parent.height / board.columns - board.spacing

                state: CSEngine.getTileState(index)

                CSTile{
                    id: tile
                    anchors.fill: parent
                    selected: index == selectedTile
                    opacity: CSEngine.getTileState(index) !== ""
                    state: parent.state

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if (tile.state === "Used") selectedTile = index
                            else if (tile.state === "Unused" && selectedTile !== -1){
                                if (CSEngine.moveTile(selectedTile, index)){
                                    gameMove += 1
                                    selectedTile = -1
                                    updateGameState()
                                }else{
                                    selectedTile = -1
                                    illegalMove()
                                }
                            }else illegalTile()
                        }
                    }
                }
            }
        }
    }
}
