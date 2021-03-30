import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1000
    height: 480
    visible: true
    title: qsTr("Main")
    // FunckBlock {x:10; y:10}
    // если меню создано то статус элемента блок 2 меняетя на ok если не создано то bad
    property string stat: "bad"

    DropArea {
        x: 260; y: 0
        width: 300; height: 300
    }
    Rectangle {
        id: createBlock
        width: 200
        height: 70
        color: "#DCCEC3"
        radius: 6
        property int blockCount: 0
        Text {
            width: parent.width
            height: parent.height
            text: "Создать меню"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Comfortaa"
            font.pointSize: 10
            color: "black"
        }


        MouseArea
        {
            id: mArea
            anchors.fill: parent
            onClicked:
            {
                let component = Qt.createComponent("FunckBlock.qml");
                if (component.status == Component.Ready) {
                    let childRec = component.createObject(createBlock);
                    childRec.x = createBlock.x + createBlock.width + 20 + 260 *createBlock.blockCount;
                    childRec.y = 0;
                    createBlock.blockCount = createBlock.blockCount + 1
                }
                stat = "ok"


            }
        }

    }

    Rectangle {
        id: createBlock2
        y: 85
        width: 200
        height: 70
        color: "#DCCEC3"
        radius: 6
        property int blockCount2: 0
        Text {
            width: parent.width
            height: parent.height
            text: "Создать блок"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Comfortaa"
            font.pointSize: 10
            color: "black"
        }
        MouseArea
        {
            id: mArea2
            anchors.fill: parent
            onClicked:
            {
//                Drag.active: dragArea.drag.active
//                        Drag.hotSpot.x: 10
//                        Drag.hotSpot.y: 10

//                        MouseArea {
//                            id: dragArea
//                            anchors.fill: parent

//                            drag.target: parent
//                        }


                let component = Qt.createComponent("FunckBlock2.qml");

                if (component.status == Component.Ready) {
                    let childRec = component.createObject(createBlock2);
                    childRec.x = createBlock2.x + createBlock2.width + 20 + 60 *createBlock2.blockCount2;
                    childRec.y = 0;
                    childRec.stat = stat;
                    createBlock2.blockCount2 = createBlock2.blockCount2 + 1
                }

            }
        }

    }

}
