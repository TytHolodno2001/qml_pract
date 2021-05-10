import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.qmlmodels 1.0
import Param 1.0
import QtGraphicalEffects 1.12


Rectangle{
    id: main_rec
    property int smallWidth: Param.tableSmallWidth
    property int bigWidth: Param.tableBigWidth
    property int headHeight: Param.tableHeadHeight
    property int cellHeight: Param.tableCellHeight
    property int margin: Param.margin24
    property string fontFamily: Param.textFontFamily
    property int fontPointSize: Param.textItemComp
    property color accentColor: Param.accentСolor1
    property color fontColor: darkTheme?Param.dtextColor1:Param.ltextColor1
    property color borderColor: darkTheme?Param.delemThirdColor:Param.lelemThirdColor

    property string title: "БАСИ"
    property string numberProduct: "20"
    property string dateProduct: "11.03.2021"
    property string timeProduct: "18:00"
    property var itemComp/*: [{mode: "Режим", bstp: "000000*", betp: "000000", bstr: "000000", betr: "000000*", info: "пока хз"},
        {mode: "Режим", bstp: "000000", betp: "000000", bstr: "000000", betr: "000000", info: "пока хз"},
        {mode: "Режим", bstp: "000000", betp: "000000", bstr: "000000", betr: "000000", info: "пока хз"}]*/
    signal close();
    onItemCompChanged: {
        listModel.append(itemComp)
    }

    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2 + bigWidth
        height: Param.tableHeight + 60
        visible: true
        radius: Param.elemRadius

        //первая строка - заголовка
        Rectangle {
            id:title
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight
            anchors.left: parent.left

            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Итоговая справка " + main_rec.title
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
            id:onlyError
            width: 100
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: headHeight
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: borderColor
            border.width: 2

            Text {
                text: "ошибки"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    let errorComp = [];
                    for(let i = 0; i < itemComp.length; i++){
                        if((itemComp[i].bstp.includes("*"))||(itemComp[i].betp.includes("*"))||(itemComp[i].bstr.includes("*"))||(itemComp[i].betr.includes("*"))){
                            errorComp.push(itemComp[i])
                        }

                    }
                    listModel.clear()
                    listModel.append(errorComp)
                    onlyError.border.color = Param.accentСolor1
                    all.border.color = borderColor
                }
            }
        }

        Rectangle {
            id:all
            width: 100
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: headHeight + margin + onlyError.width
            anchors.top: parent.top
            anchors.topMargin: (headHeight - onlyError.height)/2
            color: parent.color
            radius: Param.elemRadius
            border.color: Param.accentСolor1
            border.width: 2

            Text {
                text: "все"
                font.family: Param.textFontFamily
                anchors.fill: parent
                font.pointSize: 10/1.5
                color: darkTheme?Param.dtextColor2:Param.ltextColor2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            //отобразить только с ошибками
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listModel.clear()
                    listModel.append(itemComp)
                    all.border.color = Param.accentСolor1
                    onlyError.border.color = borderColor
                }
            }
        }

        Rectangle {
            id:cross
            width: headHeight
            height: headHeight
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

        //номер изделия, дата и время
        Rectangle {
            id:numberProduct
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight - 20
            anchors.left: parent.left
            anchors.topMargin: headHeight - 10
            anchors.top: parent.top
            radius: Param.elemRadius
            color: parent.color

            Text {
                text: "Номер изделия: " + main_rec.numberProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin
            }
            Text {
                text: "Дата: " + main_rec.dateProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3
            }
            Text {
                text: "Время: " + main_rec.timeProduct
                font.family: Param.textFontFamily
                height: parent.height
                width: parent.width/3
                font.pointSize: fontPointSize
                color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: margin + parent.width/3*2
            }
        }


        //таблица
        //заголовок
        Rectangle {
            id: table
            height: 30
            width: Param.tableWidth - margin*2
            color: parent.color
            anchors.top: parent.top
            anchors.topMargin: headHeight*2 - 10
            anchors.left: parent.left
            anchors.leftMargin: margin
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: 0
            }
            Rectangle {
                height: parent.height
                width: parent.width / 5 * 2
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "Планировачные данные"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
            Rectangle {
                height: parent.height
                width: parent.width / 5 * 2
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5 *3
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "Реальные данные"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
        }

        Rectangle {
            height: 30
            width: Param.tableWidth - margin*2
            color: parent.color
            anchors.top: parent.top
            anchors.topMargin: headHeight*2 - 10 + 30
            anchors.left: parent.left
            anchors.leftMargin: margin
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: 0
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "Режим"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }

            }
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "БВн"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5 *2
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "БВк"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5 *3
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "БВн"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
            Rectangle {
                height: parent.height
                width: parent.width / 5
                color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                border.color: borderColor
                border.width: 2
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 5 *4
                Text {
                    //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                    text: "БВк"
                    font.family: Param.textFontFamily
                    anchors.fill: parent
                    font.pointSize: fontPointSize
                    color:  darkTheme?Param.dtextColor1:Param.ltextColor1
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin: margin
                }
            }
        }

        //сам список
        Rectangle {
            id: listPar
            anchors.top: parent.top
            anchors.topMargin: headHeight*2 - 10 + 30*2
            anchors.left: parent.left
            anchors.leftMargin: margin
            width: Param.tableWidth - margin*2
            height: table_info.height - (headHeight*2 - 10) - margin - 30*2
            clip: true
            color: parent.color
            radius: Param.elemRadius

            ListModel {
                id: listModel
                Component.onCompleted: {
                }
            }

            Component {
                id:listDelegate
                Rectangle {
                    height: 30
                    width: Param.tableWidth - margin*2
                    color: parent.color
                    Rectangle {
                        height: parent.height
                        width: parent.width / 5
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: 2
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: mode
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  mode.includes('*')?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                        MouseArea{
                            property bool create: false
                            anchors.fill: parent
                            onClicked: {
                                if(!create){
                                    let component = Qt.createComponent("expressHelpParam.qml");
                                    if (component.status === Component.Ready) {
                                        var child= component.createObject(main_rec);
                                        //открывается справа или слева
                                        child.x = 0
                                        child.y = headHeight*2 - 10 + 30*2
                                        create = true


                                        child.title = mode
                                        let tableInfo = []

                                        let string = info.split('#')
                                        for (let i = 0; i < string.length; i++){
                                            let elem = string[i].split('\\')
                                            tableInfo.push({param: elem[0], bstp: elem[1], betp: elem[2], bstr: elem[3], betr: elem[4]})
                                        }
                                        child.itemComp = tableInfo

                                        child.close.connect(function(){
                                            child.destroy()
                                            create = false
                                        })
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        height: parent.height
                        width: parent.width / 5
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: 2
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 5
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: bstp
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  bstp.includes('*')?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    }
                    Rectangle {
                        height: parent.height
                        width: parent.width / 5
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: 2
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 5 *2
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: betp
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  betp.includes('*')?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    }
                    Rectangle {
                        height: parent.height
                        width: parent.width / 5
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: 2
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 5 *3
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: bstr
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  bstr.includes('*')?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    }
                    Rectangle {
                        height: parent.height
                        width: parent.width / 5
                        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                        border.color: borderColor
                        border.width: 2
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width / 5 *4
                        Text {
                            //mode: "Режим", bstp: 000000, betp: 000000, bstr: 000000, betr: 000000
                            text: betr
                            font.family: Param.textFontFamily
                            anchors.fill: parent
                            font.pointSize: fontPointSize
                            color:  betr.includes('*')?Param.accentСolor2:(darkTheme?Param.dtextColor1:Param.ltextColor1)
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left
                            anchors.leftMargin: margin
                        }
                    }

                }
            }

            ListView {
                anchors.fill: parent
                model: listModel
                delegate: listDelegate
            }
        }
    }
    DropShadow {
        anchors.fill: table_info
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: table_info
    }
}
