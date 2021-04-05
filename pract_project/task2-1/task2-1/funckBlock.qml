import QtQuick 2.0
import QtQuick.Controls 2.15
Rectangle{
    property color itemColor: "#79B2B2"
    property int itemRadius: 6
    property int itemHeight: 50
    property int itemWidth: 250
    property int dragMinX: 0
    property int dragMaxX: 0
    property int dragMinY: 0
    property int dragMaxY: 0
    property string itemText: ""

    signal positionChange(double x, double y, string itemText)


    id: dragRect
    width: itemWidth
    height: itemHeight
    radius: itemRadius
    color: itemColor
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

     onPositionChanged:  {
         positionChange(dragRect.x, dragRect.y, dragRect.itemText)
     }

    }
}
