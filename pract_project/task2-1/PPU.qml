import QtQuick 2.0
import QtQuick.Controls 2.15


Rectangle{

    property color ok: "#79B2B2"
    property color bad: "#FD6F6F"
    property int itemRadius: 6
    property int itemHeight: 50
    property int itemWidth: 250
        property int dragMinX: 0
        property int dragMaxX: 0
        property int dragMinY: 0
        property int dragMaxY: 0
//    property int dragX: x
//    property int dragY: y

    property string itemText: "ППУ"
    id: dragRect
    width: itemWidth
    height: itemHeight
    radius: itemRadius
    color: ok
    z: 2


    Text {
        width: parent.width
        height: parent.height
        text: itemText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: fontFamily
        font.pointSize: pointSize
        color: fontColor
    }

    Drag.active:dragArea.drag.active
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag {
            target: parent
            minimumY: dragMinY
            minimumX: dragMinX
            maximumX: dragMaxX
            maximumY: dragMaxY
        }

//        onPositionChanged: {
//            dragX = dragRect.x
//            dragY = dragRect.y
//        }

    }
}

