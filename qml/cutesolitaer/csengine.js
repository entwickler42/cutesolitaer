var m_templ_state =
        [
            [ 0,0,1,1,1,0,0],
            [ 0,0,1,1,1,0,0],
            [ 1,1,1,1,1,1,1],
            [ 1,1,1,2,1,1,1],
            [ 1,1,1,1,1,1,1],
            [ 0,0,1,1,1,0,0],
            [ 0,0,1,1,1,0,0]
        ]

var _m_state =
        [
            [ 0,0,2,2,2,0,0],
            [ 0,0,2,2,2,0,0],
            [ 1,2,2,2,2,2,2],
            [ 1,2,2,2,2,2,2],
            [ 1,1,2,2,2,2,2],
            [ 0,0,1,2,2,0,0],
            [ 0,0,1,2,2,0,0]
        ]

var __m_state =
        [
            [ 0,0,2,2,2,0,0],
            [ 0,0,2,1,2,0,0],
            [ 2,2,2,1,2,2,2],
            [ 2,2,2,2,2,2,2],
            [ 2,2,2,2,2,2,2],
            [ 0,0,2,2,2,0,0],
            [ 0,0,2,2,2,0,0]
        ]
var m_state =
        [
            [ 0,0,1,1,1,0,0],
            [ 0,0,1,1,1,0,0],
            [ 1,1,1,1,1,1,1],
            [ 1,1,1,2,1,1,1],
            [ 1,1,1,1,1,1,1],
            [ 0,0,1,1,1,0,0],
            [ 0,0,1,1,1,0,0]
        ]

var m_goal_x = 3
var m_goal_y = 3
var m_moves = 0

function moveTile(idxSrc, idxDst)
{
    var srcx = Math.floor(idxSrc % m_state.length)
    var srcy = Math.floor(idxSrc / m_state.length)
    var dstx = Math.floor(idxDst % m_state.length)
    var dsty = Math.floor(idxDst / m_state.length)

    if (srcy === dsty){
        // check right
        if (dstx - srcx === 2)
            if (m_state[dsty][dstx-1] === 1)
                if (m_state[dsty][dstx] === 2){
                    m_state[dsty][dstx] = 1
                    m_state[dsty][dstx-1] = 2
                    m_state[dsty][dstx-2] = 2
                    tiles.itemAt(idxSrc+1).state = "Unused"
                    tiles.itemAt(idxSrc).state = "Unused"
                    tiles.itemAt(idxDst).state = "Used"

                    return true
                }
        // check left
        if (srcx - dstx === 2)
            if (m_state[dsty][dstx+1] === 1)
                if (m_state[dsty][dstx] === 2){
                    m_state[dsty][dstx] = 1
                    m_state[dsty][dstx+1] = 2
                    m_state[dsty][dstx+2] = 2
                    tiles.itemAt(idxSrc-1).state = "Unused"
                    tiles.itemAt(idxSrc).state = "Unused"
                    tiles.itemAt(idxDst).state = "Used"

                    return true
                }
    }else if (srcx === dstx){
        // check bottom
        if (dsty - srcy === 2)
            if (m_state[dsty-1][dstx] === 1)
                if (m_state[dsty][dstx] === 2){
                    m_state[dsty][dstx] = 1
                    m_state[dsty-1][dstx] = 2
                    m_state[dsty-2][dstx] = 2

                    tiles.itemAt(idxSrc+m_state.length).state = "Unused"
                    tiles.itemAt(idxSrc).state = "Unused"
                    tiles.itemAt(idxDst).state = "Used"

                    return true;
                }
        // check top
        if (srcy - dsty === 2)
            if (m_state[dsty+1][dstx] === 1)
                if (m_state[dsty][dstx] === 2){
                    m_state[dsty][dstx] = 1
                    m_state[dsty+1][dstx] = 2
                    m_state[dsty+2][dstx] = 2
                    tiles.itemAt(idxSrc-m_state.length).state = "Unused"
                    tiles.itemAt(idxSrc).state = "Unused"
                    tiles.itemAt(idxDst).state = "Used"

                    return true
                }
    }
    return false
}

function getGameState()
{
    var ntiles = 0;
    var nmoves = 0;

    for (var x=0, xmax=m_state.length; x<xmax; x++)
        for (var y=0, ymax=m_state[x].length; y<ymax; y++){
            if (m_state[x][y] === 1){
                ntiles++
                if (x>2 && m_state[x-1][y] === 1 && m_state[x-2][y] === 2) nmoves++
                if (x<xmax-2 && m_state[x+1][y] === 1 && m_state[x+2][y] === 2) nmoves++
                if (y>2 && m_state[x][y-1] === 1 && m_state[x][y-2] === 2) nmoves++
                if (y<ymax-2 && m_state[x][y+1] === 1 && m_state[x][y+2] === 2) nmoves++
            }
        }
    if (ntiles === 1 && m_state[m_goal_x][m_goal_y] === 1){
        console.debug("won: only "+ntiles+" tile left and state for goal x "+m_goal_x+" and gloal y is "+m_goal_y+" is "+m_state[m_goal_x][m_goal_y])
        return "won";
    }else if(nmoves === 0){
        console.debug("lost: no more possible moves");
        return "lost";
    }
    return "playing";
}

function getTileState(index)
{
    switch(m_state[Math.floor(index/m_state.length)][Math.floor(index % m_state.length)])
    {
    case 1: return "Used"
    case 2: return "Unused"
    }
    return ""
}

function loadTemplate()
{
    m_state = new Array
    for(var i=0; i<m_templ_state.length; i++){
        m_state[i] = m_templ_state[i].slice(0)
    }
}
