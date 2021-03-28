import QtQuick 2.0
import QtQuick.Controls 2.15


Item {
    id: funckBlock
    width: 300
    height: 600

    property color item: "#79B2B2"
    property color back: "#669999"
    property color menu: "#99CCCC"
    property color text: "#FEFFFC"
    property string fontFamily: "Comfortaa"
    property int menuWidth: 250
    property int itemHeight: 50
    property int itemMargin: 15
    property int itemWidth: menuWidth - 2*itemMargin
    property int menuRadius: 6
    property int menuPointSize: 10


    Rectangle {
        id: menu
        width: funckBlock.menuWidth

        height: funckBlock.itemHeight
        color: funckBlock.menu
        radius: funckBlock.menuRadius
        z: 1

        Text {
            width: parent.width - funckBlock.itemHeight
            height: parent.height
            text: "Menu"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: funckBlock.fontFamily
            font.pointSize: funckBlock.menuPointSize
            color: funckBlock.text
        }

        Rectangle {

            id: strelka
            property bool vis
            width: funckBlock.itemHeight
            height: funckBlock.itemHeight
            state: "RELEASED"
            radius: funckBlock.menuRadius
            anchors.right: parent.right
            anchors.rightMargin: 0
            Image {
                id: arrow_img
                anchors.verticalCenter: parent.verticalCenter
                source: "file:/pract_project/task1/arrow.png"
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
            vis: false
            PropertyAnimation { id: animation_item_open; target: itemMenu; property: "height"; to: (funckBlock.itemHeight + funckBlock.itemMargin)* (listItem.count + 1) + funckBlock.itemMargin ; duration:600 }
            PropertyAnimation { id: animation_item_close; target: itemMenu; property: "height"; to: 0 ; duration:600 }
            PropertyAnimation { id: arrow_img_rotate; target: arrow_img; property: "rotation"; to: arrow_img.rotation + 60; duration: 600 }



            Timer {
                id:timer
                onTriggered: {itemMenu.visible = false
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (strelka.vis == false) {

                        itemMenu.visible = true
                        animation_item_open.running = true

                        arrow_img_rotate.running = true
                        strelka.vis = true
                    }
                    else {

                        animation_item_close.running = true
                        timer.interval = 600
                        timer.running = true
                        timer.repeat = false

                        arrow_img_rotate.running = true

                        strelka.vis = false
                    }

                }
                onPressed: strelka.state = "PRESSED"
                onReleased: strelka.state = "RELEASED"
            }
            states: [
                State {
                    name: "PRESSED"
                    PropertyChanges { target: strelka; color: funckBlock.item}
                },
                State {
                    name: "RELEASED"
                    PropertyChanges { target: strelka; color: funckBlock.menu}
                }
            ]

            transitions: [
                Transition {
                    from: "PRESSED"
                    to: "RELEASED"
                    ColorAnimation { target: strelka; duration: 100}
                },
                Transition {
                    from: "RELEASED"
                    to: "PRESSED"
                    ColorAnimation { target: strelka; duration: 100}
                }
            ]
        }

    }



    Rectangle {
        id:itemMenu
        y: 50
        width: funckBlock.itemWidth + funckBlock.itemMargin + funckBlock.itemMargin
        height: 0
        clip: true

        color: funckBlock.back
        radius: funckBlock.menuRadius
        visible: false
        Rectangle {
            id: item1
            width:funckBlock.itemWidth
            height: funckBlock.itemHeight
            color: funckBlock.back
            anchors.right: parent.right
            anchors.rightMargin: funckBlock.itemMargin
            anchors.top: parent.top
            anchors.topMargin: funckBlock.itemMargin
            radius: funckBlock.menuRadius

            property bool left_block_vis: true

            PropertyAnimation { id: animation_left_block_open; target: left_block; property: "width"; to: 125; duration: 200 }
            PropertyAnimation { id: animation_left_block_close; target: left_block; property: "width"; to: 75; duration: 200 }
            PropertyAnimation { id: animation_right_block_open; target: right_block; property: "width"; to: 130; duration: 200 }
            PropertyAnimation { id: animation_right_block_close; target: right_block; property: "width"; to: 80; duration: 200 }

            Rectangle {
                id: left_block
                y: 0
                width: 125
                height: funckBlock.itemHeight
                color: funckBlock.item
                anchors.left: parent.left
                anchors.leftMargin: 0
                radius: 6

                Text {
                    anchors.fill: parent
                    text: "i1"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: funckBlock.fontFamily
                    font.pointSize: funckBlock.menuPointSize
                    color: funckBlock.text
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(item1.left_block_vis) {
                            animation_left_block_close.running = true
                            animation_right_block_open.running = true
                            item1.left_block_vis = false
                        }
                        else {
                            animation_left_block_open.running = true
                            animation_right_block_close.running = true
                            item1.left_block_vis = true
                        }
                    }
                }

            }

            Rectangle {
                id:right_block
                y: 0
                width: 75
                height: funckBlock.itemHeight
                color: funckBlock.item
                anchors.right: parent.right
                anchors.rightMargin: 0
                radius: funckBlock.menuRadius

                Text {
                    anchors.fill: parent
                    text: "i2"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: funckBlock.fontFamily
                    font.pointSize: funckBlock.menuPointSize
                    color: funckBlock.text
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(item1.left_block_vis) {
                            animation_left_block_close.running = true
                            animation_right_block_open.running = true
                            item1.left_block_vis = false
                        }
                        else {
                            animation_left_block_open.running = true
                            animation_right_block_close.running = true
                            item1.left_block_vis = true
                        }
                    }
                }
            }

        }
        Rectangle{

            anchors.top: parent.top
            anchors.topMargin: funckBlock.itemHeight + funckBlock.itemMargin
            width: funckBlock.itemWidth + funckBlock.itemMargin + funckBlock.itemMargin
            height: (funckBlock.itemHeight + funckBlock.itemMargin)* (listItem.count) + funckBlock.itemMargin
            color: parent.color
            radius: funckBlock.menuRadius

            ListModel {
                id:listItem

                ListElement {
                    name: "Elem1"
                    stat: "yes"
                }
                ListElement {
                    name: "Elem2"
                    stat: "no"
                }
                ListElement {
                    name: "Elem2"
                    stat: "no"
                }
            }

            Component {
                id:delItem

                Rectangle {
                    id:itemOfMenu
                    width: funckBlock.itemWidth
                    height: funckBlock.itemHeight
                    color: funckBlock.item
                    anchors.right: itemMenu.right
                    anchors.rightMargin: funckBlock.itemMargin
                    radius: funckBlock.menuRadius
                    //здесь можно попробовать анимацию


                    Text {
                        width: parent.width - funckBlock.itemHeight
                        height: parent.height
                        text: name
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: funckBlock.fontFamily
                        font.pointSize: funckBlock.menuPointSize
                        color: funckBlock.text
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        width: funckBlock.itemHeight
                        height: funckBlock.itemHeight
                        color: funckBlock.item
                        radius: funckBlock.menuRadius
                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            source: stat=="yes" ? "file:/pract_project/task1/yes.png" : "file:/pract_project/task1/no.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            rotation: 0
                        }
                    }
                }
            }

            ListView {

                anchors.margins: funckBlock.itemMargin
                anchors.fill: parent
                spacing: funckBlock.itemMargin
                model: listItem
                delegate: delItem

            }
        }
    }


}
