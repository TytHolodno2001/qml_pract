import QtQuick 2.15
import QtQuick.Window 2.15
Window {
    width: 1000
    height: 480
    visible: true
    title: qsTr("Main")
    Item {
        width: 200; height: 200

        Rectangle {
            x: 10; y: 10
            width: 20; height: 20
            color: "red"

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
}
