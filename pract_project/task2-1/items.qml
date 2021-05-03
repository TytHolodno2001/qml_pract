import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12


Rectangle{
    id: main_rec
    property int elemWidth: Param.itemsWidth
    property int elemHeight: Param.itemsHeight
    property int titleHeight: Param.itemsTitleHeight

    property int margin: Param.margin24
    property string fontFamily: Param.textFontFamily
    property int fontPointSize: Param.textItemComp
    property color accentColor: Param.accentСolor1
    property color fontColor: darkTheme?Param.dtextColor1:Param.ltextColor1

    property string title: "Liza"

    // параметры в списоk
    property var itemComp

    signal close();
    onItemCompChanged: {
        listModel.append(itemComp)
    }

    Rectangle {
        id:content
        width: elemWidth
        height: elemHeight
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        radius: Param.elemRadius
        Rectangle {
            id:table_info
            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
            width: elemWidth
            height: titleHeight
            visible: true
            radius: Param.elemRadius
            Rectangle {
                id:title
                width: elemWidth - titleHeight
                height: titleHeight
                anchors.left: parent.left
                anchors.top: parent.top
                radius: Param.elemRadius
                color: parent.color

                Text {
                    text: main_rec.title
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  Param.accentСolor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }

            Rectangle {
                id:cross
                width: titleHeight
                height: titleHeight
                anchors.right: parent.right
                anchors.top: parent.top
                color: parent.color
                radius: Param.elemRadius
                Image {
                    id: cross_img
                    source: darkTheme?Param.iconCrossDark:Param.iconCrossLight
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                //закрыть окно
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        main_rec.close()
                    }
                }
            }

            //сам список
            Rectangle {
                id: listPar
                anchors.top: parent.top
                anchors.topMargin: titleHeight
                width: elemWidth
                height: elemHeight - titleHeight
                clip: true
                color: parent.color
                radius: Param.elemRadius

                ListModel {
                    id: listModel

                    Component.onCompleted: {
                        listModel.append(itemComp)
                    }
                }

                Component {
                    id:listDelegate
                    Rectangle {
                        height: 40
                        width: elemWidth - margin*2
                        color: darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                        radius: Param.elemRadius
                        border.width: statePar=="bad"?Param.sizeFrame:0
                        border.color: Param.accentСolor2
                        Text {
                            width: parent.width
                            height: parent.height
                            text: name
                            font.family: Param.textFontFamily
                            font.pointSize: Param.textButtonSize
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: darkTheme?Param.dtextColor1:Param.ltextColor1
                        }
                        MouseArea {
                            property bool create: false
                            anchors.fill: parent
                            hoverEnabled : true
                            // при наведении
                            onEntered:{
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor3
                            }
                            onExited:{
                                parent.border.width= statePar=="bad"?Param.sizeFrame:0
                                parent.border.color= Param.accentСolor2
                            }

                            //при клике
                            onPressed:
                            {
                                parent.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                                parent.border.width = Param.sizeFrame
                                parent.border.color = Param.accentСolor1
                            }
                            onReleased:{
                                themeChange.connect(function(){
                                    parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                                })
                                parent.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
                                border.width= statePar=="bad"?Param.sizeFrame:0
                                border.color= Param.accentСolor2
                            }

                            onClicked: {
                                if(!create){
                                    if(type == "info") {

                                        let component = Qt.createComponent("info.qml");
                                        if (component.status === Component.Ready) {
                                            var child= component.createObject(content);
                                            //открывается справа или слева
                                            child.x = elemWidth + margin
                                            child.y = 0

                                            let elem = info.split(",")

                                            child.text = elem[1]
                                            child.state_text = statePar
                                            child.title_text = elem[0]

                                            create = true

                                            child.close.connect(function(){
                                                child.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    if(type == "list") {

                                        let component = Qt.createComponent("list.qml");
                                        if (component.status === Component.Ready) {
                                            var child= component.createObject(content);
                                            //открывается справа или слева
                                            child.x = elemWidth + margin
                                            child.y = 0

                                            let string = info.split('-')
                                            let items = []
                                            for (let i = 0; i < string.length; i++){
                                                let elem = string[i].split(",")
                                                items.push({number: elem[0], value: elem[1], statePar: elem[2]})
                                            }
                                            child.itemComp = items
                                            child.title = name
                                            create = true

                                            child.close.connect(function(){
                                                child.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                    if(type == "table") {
                                        let component = Qt.createComponent("table.qml");
                                        if (component.status === Component.Ready) {
                                            var child= component.createObject(content);
                                            //открывается справа или слева
                                            child.x = elemWidth + margin
                                            child.y = 0

                                            let string = info.split('-')
                                            let rows = []
                                            for (let i = 0; i < string.length; i++){
                                                let elem = string[i].split(",")
                                                rows.push({number: elem[0], tn: elem[1], tk: elem[2], mode: elem[3]})
                                            }
                                            child.tableCell = rows

                                            child.title = name

                                            create = true

                                            child.close.connect(function(){
                                                child.destroy()
                                                create = false
                                            })

                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                ListView {
                    anchors.margins: margin
                    anchors.fill: parent
                    model: listModel
                    delegate: listDelegate
                    spacing: margin
                }

            }
        }
    }
    DropShadow {
        anchors.fill: content
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: content
    }
}
