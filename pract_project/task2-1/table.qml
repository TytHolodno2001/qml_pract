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

    property string title
    property var tableCell
     signal close();

    onTableCellChanged: {
        for(let i =0; i < tableCell.length; i++) {
                table.appendRow(tableCell[i])
        }
    }
    Rectangle {
        id:table_info
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        width: headHeight + smallWidth*2 + bigWidth
        height: Param.tableHeight
        visible: true
        radius: Param.elemRadius
        Rectangle {
            id:title
            width: headHeight + smallWidth*2 + bigWidth
            height: headHeight
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


        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: headHeight
            width: headHeight+smallWidth*2+bigWidth
            height: Param.tableHeight - headHeight
            clip: true
            color: parent.color
            radius: Param.elemRadius

            TableView {
                id: table_view
                anchors.fill: parent
                columnSpacing: 0
                rowSpacing: 0
                boundsBehavior: Flickable.StopAtBounds
                model: TableModel {
                    id: table
                    TableModelColumn { display: "number" }
                    TableModelColumn { display: "tn" }
                    TableModelColumn { display: "tk" }
                    TableModelColumn { display: "mode" }


                }
                delegate: DelegateChooser {
                    DelegateChoice {
                        column: 0
                        row: 0
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: headHeight
                            implicitHeight: headHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                font.pointSize: fontPointSize
                                color: fontColor

                            }
                        }
                    }
                    DelegateChoice {
                        column: 1
                        row: 0
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: smallWidth
                            implicitHeight: headHeight
                            border.width: 1
                            border.color:borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 2
                        row: 0
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: smallWidth
                            implicitHeight: headHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 3
                        row: 0
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: bigWidth
                            implicitHeight: headHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 0
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: headHeight
                            implicitHeight: cellHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 1
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: smallWidth
                            implicitHeight: cellHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                anchors.left: parent.left
                                anchors.leftMargin: margin
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 2
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: smallWidth
                            implicitHeight: cellHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                anchors.left: parent.left
                                anchors.leftMargin: margin
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                    DelegateChoice {
                        column: 3
                        delegate:
                            Rectangle{
                            color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
                            implicitWidth: bigWidth
                            implicitHeight: cellHeight
                            border.width: 1
                            border.color: borderColor
                            Text {
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.family: Param.textFontFamily
                                text: model.display
                                anchors.left: parent.left
                                anchors.leftMargin: margin
                                font.pointSize: fontPointSize
                                color: fontColor
                            }
                        }
                    }
                }
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
