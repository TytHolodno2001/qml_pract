import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Item {
    property string itemText: "Текст"
    property string itemTextOnClick: "Текст"
    property string click: "no"
    signal onClick();
    Rectangle {
        id:smallButton

        width: Param.buttonSmallWidth
        height: Param.buttonSmallHeight
        color: darkTheme?Param.delemSecondColor:Param.lelemSecondColor
        radius: Param.elemRadius

        Text{
            width: parent.width - parent.height
            height: parent.height
            anchors.left: parent.left;
            anchors.leftMargin:  Param.margin32
            text: itemText
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textButtonSize
            color: darkTheme?Param.dtextColor1:Param.ltextColor1
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled : true

            // при наведении
            onEntered:{
                smallButton.border.width = Param.sizeFrame
                smallButton.border.color = click == "yes"?Param.accentСolor1:Param.accentСolor3
            }
            onExited:{
                smallButton.border.width = click == "yes"? Param.sizeFrame: 0
            }

            //при клике
            onPressed:smallButton.color = darkTheme?Param.delemThirdColor:Param.lelemThirdColor
            onReleased: smallButton.color = darkTheme?Param.delemSecondColor:Param.lelemSecondColor

            //после клика
            onClicked:
            {
                smallButton.border.width = Param.sizeFrame
                smallButton.border.color = Param.accentСolor1
                click = "yes"
                onClick()
            }
        }


        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 2
            height: parent.height - 4
            color: parent.color
            radius: Param.elemRadius


            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: click =="yes" ? Param.iconStateActive : (darkTheme?Param.iconStateDark:Param.iconStateLight)
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

    }

    //тени
    DropShadow {
        anchors.fill: smallButton
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: smallButton
    }
}

