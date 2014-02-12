import QtQuick 1.1
import com.cutecube.common 1.0
import "qrc:/qml/com/cutecube/common/"

Column{
    anchors{ left: parent.left; right: parent.right }
    spacing: 12

    CuteText{
        state: "big"
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("Sounds")
    }
    CuteText{
        anchors.horizontalCenter: parent.horizontalCenter
        onLinkActivated: Qt.openUrlExternally(link)
        font.bold: true
        text: qsTr("<a href=\"http://ubuntu.com\">Ubuntu Audio Theme</a>")
    }
    CuteText{
        state: "big"
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("Fonts")
    }
    CuteText{
        anchors.horizontalCenter: parent.horizontalCenter
        onLinkActivated: Qt.openUrlExternally(link)
        text: "<div align=center>A.C.M.E. Secret Agent<br><a href=\"http://www.blambot.com\">www.blambot.com</a></div>"
        font.bold: true
    }
    CuteText{
        state: "big"
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("Icons")
    }
    CuteText{
        anchors.horizontalCenter: parent.horizontalCenter
        onLinkActivated: Qt.openUrlExternally(link)
        text: "<div align=center>Crystal Icon Set<br><a href=\"http://www.everaldo.com/crystal/\">www.everaldo.com</a></div>"
        font.bold: true
    }
    CuteText{
        state: "big"
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("Source")
    }
    CuteText{
        state: "big"
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("License")
    }
    CuteText{
        anchors{ left: parent.left; right: parent.right }
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        text: qsTr("GNU General public license v3")
    }
}
