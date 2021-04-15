import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Rectangle{
    id: dragRect
    width: Param.fBWidth
    height: Param.fBHeight
    radius: Param.elemRadius

    property color item: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
    property color back: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
    property color menu: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
    property color text: darkTheme?Param.dtextColor1:Param.ltextColor1
    property string fontFamily: Param.textFontFamily
    property int menuWidth: Param.fBWidth
    property int menuHeight: Param.fBHeight
    property int itemHeight: Param.buttonSmallHeight
    property int itemMargin: Param.margin32
    property int itemWidth: Param.buttonSmallWidth
    property int menuRadius: Param.elemRadius
    property int menuPointSize: Param.textButtonSize
    property string click: "no"
    property string createBlock:  "no"
    property string itemText
    property string icon

    property int dragMinX: 0
    property int dragMaxX: 0
    property int dragMinY: 0
    property int dragMaxY: 0

    signal positionChange(double x, double y, string itemText)
    z:3
    Drag.active:dragArea.drag.active
    MouseArea {
        id: dragArea
        z:4
        height: parent.height
        width:parent.width - parent.height
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
    Rectangle {
        id: menu
        width: dragRect.menuWidth
        height: dragRect.menuHeight
        color: dragRect.menu
        radius: dragRect.menuRadius
        Drag.active:dragArea.drag.active
        z:2
        MouseArea {

            anchors.fill: parent
            hoverEnabled : true

            // при наведении
            onEntered:{
                parent.border.width = Param.sizeFrame
                parent.border.color = Param.accentСolor3
            }
            onExited:{
                parent.border.width = 0
            }

            //при клике
            onPressed:
            {
                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                strelka.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                parent.border.width = Param.sizeFrame
                parent.border.color = Param.accentСolor1}
            onReleased:{
                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                strelka.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                parent.border.width = 0
            }
        }

        Text {
            width: parent.width - dragRect.menuHeight
            height: parent.height
            text: itemText

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: dragRect.fontFamily
            font.pointSize: 18 / 1.5
            color: dragRect.text
            anchors.left: parent.left
            anchors.leftMargin: dragRect.menuHeight - 40
        }

        Rectangle {
            property bool vis
            color: parent.color
            y: parent.y + 2
            width: dragRect.menuHeight - 2
            height: dragRect.menuHeight - 4
            radius: dragRect.menuRadius
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.Center
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: icon
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: strelka
            property bool vis
            color: parent.color
            y: parent.y + 2
            width: dragRect.menuHeight - 2
            height: dragRect.menuHeight - 4
            radius: dragRect.menuRadius
            anchors.right: parent.right
            anchors.rightMargin: 2
            Image {
                id: arrow_img
                anchors.verticalCenter: parent.verticalCenter
                source: darkTheme?Param.iconArrowBigWhite:Param.iconArrowBigBlack
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 270
            }
            vis: false
            PropertyAnimation { id: animation_item_open; target: itemMenu; property: "height"; to: (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin ; duration:600 }
            PropertyAnimation { id: animation_item_open_up; target: itemMenu; property: "y"; to: itemMenu.y - ((dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin + dragRect.menuHeight) ; duration:600 }
            PropertyAnimation { id: animation_item_close; target: itemMenu; property: "height"; to: 0 ; duration:600 }
            PropertyAnimation { id: animation_item_close_up; target: itemMenu; property: "y"; to: itemMenu.y + ((dragRect.itemHeight + dragRect.itemMargin)* (listItem.count + 1) + dragRect.itemMargin + dragRect.menuHeight) ; duration:600 }
            PropertyAnimation { id: arrow_img_rotate; target: arrow_img; property: "rotation"; to: arrow_img.rotation + 180; duration: 600 }

            Timer {
                id:timer
                onTriggered: {itemMenu.visible = false
                }
            }

            MouseArea {
                property bool openDown
                anchors.fill: parent
                onClicked: {
                    if (strelka.vis == false) {

                        itemMenu.visible = true
                        console.log(itemMenu.y)
                        if(dragRect.y < scene.height/2){
                            animation_item_open.running = true
                            openDown = true
                        }
                        else {
                            animation_item_open.running = true
                            animation_item_open_up.running = true
                            openDown = false
                        }
                        arrow_img_rotate.running = true
                        strelka.vis = true
                    }
                    else {

                        if(openDown){
                            animation_item_close.running = true
                        }
                        else {
                            animation_item_close.running = true
                            animation_item_close_up.running = true
                        }

                        timer.interval = 600
                        timer.running = true
                        timer.repeat = false

                        arrow_img_rotate.running = true

                        strelka.vis = false
                    }

                }
                onPressed: strelka.color  = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                onReleased: strelka.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
            }
        }
    }

    DropShadow {
        anchors.fill: menu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: menu
    }

    Rectangle {
        id:itemMenu
        y: dragRect.menuHeight
        width: dragRect.itemWidth + dragRect.itemMargin + dragRect.itemMargin
        height: 0
        clip: true
        color: dragRect.back
        radius: dragRect.menuRadius
        visible: false
        Rectangle {
            id: item1
            width:dragRect.itemWidth
            height: dragRect.itemHeight
            color: dragRect.back
            anchors.right: parent.right
            anchors.rightMargin: dragRect.itemMargin
            anchors.top: parent.top
            anchors.topMargin: dragRect.itemMargin
            radius: dragRect.menuRadius
            z:1

            property bool left_block_vis: true

            PropertyAnimation { id: animation_left_block_open; target: left_block; property: "width"; to: Param.fBSelectBigWidth; duration: 200 }
            PropertyAnimation { id: animation_left_block_close; target: left_block; property: "width"; to: Param.fBSelectSmallWidth; duration: 200 }
            PropertyAnimation { id: animation_right_block_open; target: right_block; property: "width"; to: Param.fBSelectBigWidth; duration: 200 }
            PropertyAnimation { id: animation_right_block_close; target: right_block; property: "width"; to: Param.fBSelectSmallWidth; duration: 200 }

            Rectangle {
                id: left_block
                y: 0
                width: Param.fBSelectBigWidth
                height: dragRect.itemHeight
                color: dragRect.item
                anchors.left: Param.fBSelectBigWidth
                anchors.leftMargin: 0
                radius: dragRect.menuRadius

                Text {
                    anchors.fill: parent
                    text: "i1"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: dragRect.fontFamily
                    font.pointSize: dragRect.menuPointSize
                    color: dragRect.text
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
                    hoverEnabled : true

                    // при наведении
                    onEntered:{
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor3
                    }
                    onExited:{
                        parent.border.width = 0
                    }

                    //при клике
                    onPressed:
                    {
                        parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor1}
                    onReleased:{
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        parent.border.width = 0
                    }

                }

            }
            Rectangle {
                id:right_block
                y: 0
                width: Param.fBSelectSmallWidth
                height: dragRect.itemHeight
                color: dragRect.item
                anchors.right: parent.right
                anchors.rightMargin: 0
                radius: dragRect.menuRadius

                Text {
                    anchors.fill: parent
                    text: "i2"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: dragRect.fontFamily
                    font.pointSize: dragRect.menuPointSize
                    color: dragRect.text
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
                    hoverEnabled : true

                    // при наведении
                    onEntered:{
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor3
                    }
                    onExited:{
                        parent.border.width = 0
                    }

                    //при клике
                    onPressed:
                    {
                        parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                        parent.border.width = Param.sizeFrame
                        parent.border.color = Param.accentСolor1}
                    onReleased:{
                        parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        parent.border.width = 0
                    }
                }
            }
            DropShadow {
                anchors.fill: left_block
                horizontalOffset: Param.horizOffset
                verticalOffset: Param.verticOffset
                radius: Param.mainRadius
                samples: Param.mainSamples
                color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                source: left_block
            }
            DropShadow {
                anchors.fill: right_block
                horizontalOffset: Param.horizOffset
                verticalOffset: Param.verticOffset
                radius: Param.mainRadius
                samples: Param.mainSamples
                color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                source: right_block
            }

        }
        Rectangle{
            z:0
            anchors.top: parent.top
            anchors.topMargin: dragRect.itemHeight + dragRect.itemMargin
            width: dragRect.itemWidth + dragRect.itemMargin + dragRect.itemMargin
            height: (dragRect.itemHeight + dragRect.itemMargin)* (listItem.count) + dragRect.itemMargin
            color: parent.color
            radius: dragRect.menuRadius

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
                    width: dragRect.itemWidth
                    height: dragRect.itemHeight
                    anchors.right: itemMenu.right
                    anchors.rightMargin: dragRect.itemMargin
                    radius: dragRect.menuRadius
                    color: dragRect.item
                    Rectangle {
                        id:itemOfMenu
                        width: dragRect.itemWidth
                        height: dragRect.itemHeight
                        color: dragRect.item

                        radius: dragRect.menuRadius
                        border.width: stat=="yes" ? Param.sizeFrame: 0
                        border.color: Param.accentСolor1

                        Text{
                            width: parent.width - parent.height
                            height: parent.height
                            anchors.left: parent.left;
                            anchors.leftMargin:  Param.margin32
                            text: name
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: Param.textFontFamily
                            font.pointSize: Param.textButtonSize
                            color: darkTheme?Param.dtextColor1:Param.ltextColor1
                        }

                        Rectangle {

                            anchors.right: parent.right
                            anchors.rightMargin: 2
                            anchors.verticalCenter: parent.verticalCenter
                            width: dragRect.itemHeight - 2
                            height: dragRect.itemHeight - 4
                            color: parent.color
                            radius: dragRect.menuRadius

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                source: stat=="yes" ? Param.iconStateActive : (darkTheme?Param.iconStateDark:Param.iconStateLight)
                                anchors.horizontalCenter: parent.horizontalCenter
                                rotation: 0
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled : true

                            // при наведении
                            onEntered:{
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor3
                            }
                            onExited:{
                                parent.border.width = stat=="yes" ? Param.sizeFrame: 0
                                parent.border.color = Param.accentСolor1
                            }

                            //при клике
                            onPressed:
                            {
                                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor1}
                            onReleased:{
                                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                                parent.border.width = 0
                            }
                        }
                    }
                    DropShadow {
                        anchors.fill: itemOfMenu
                        horizontalOffset: Param.horizOffset
                        verticalOffset: Param.verticOffset
                        radius: Param.mainRadius
                        samples: Param.mainSamples
                        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
                        source: itemOfMenu
                    }

                }

                //                DropShadow {
                //                    anchors.fill: itemOfMenu
                //                    horizontalOffset: Param.horizOffset
                //                    verticalOffset: Param.verticOffset
                //                    radius: Param.mainRadius
                //                    samples: Param.mainSamples
                //                    color: Param.dDropShadowColor
                //                    source: itemOfMenu
                //                }

            }

            ListView {
                anchors.margins: dragRect.itemMargin
                anchors.fill: parent
                spacing: dragRect.itemMargin
                model: listItem
                delegate: delItem
            }
        }
    }
    DropShadow {
        anchors.fill: itemMenu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: itemMenu
    }
}
