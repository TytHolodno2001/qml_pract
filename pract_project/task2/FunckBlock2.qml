import QtQuick 2.0

Item {
    id: funckBlock2
    width: 60
    height: 60
    // статус объекта-отображается цветом
    property string stat
    property color ok: "#79B2B2"
    property color bad: "#FD6F6F"
    property int itemRadius: 6
//    DropArea {
//            x: 75; y: 75
//            width: 50; height: 50

//        }

    Rectangle{
        id: rect
        width: 50
        height: 50
        radius: itemRadius
        color: stat=="ok" ? ok : bad

        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10
        MouseArea {
                   id: dragArea
                   anchors.fill: parent
                   drag.target: parent
               }
    }

}
