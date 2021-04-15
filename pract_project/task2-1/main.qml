import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Param 1.0

Window {
    id: mainWindow
    width: 1920
    height: 1000
    visible: true
    color: darkTheme? Param.dbgColor:Param.lbgColor

    property bool darkTheme: true

    // Перемещение связи за квадратом
    function onPositionChange(x,y,itemText){
        for(let i = 0; i < connectFunckBlock.count; i++){
            if(connectFunckBlock.get(i).firstNode.itemText  == itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x1 = firstNode.x + firstNode.width/2
                connect.y1 = firstNode.y + firstNode.height/2
            }
            else if(connectFunckBlock.get(i).secondNode.itemText == itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x2 = secondNode.x + secondNode.width/2
                connect.y2 = secondNode.y + secondNode.height/2

            }
        }
    }

    // функция для кнопок - в параметры передаются настраевымые значения
    function createFunckBlock(name_eng, name_ru, icon) {
        //динамическое создание объекта
        let component = Qt.createComponent("funckBlock.qml");
        if (component.status == Component.Ready) {
            let childRec = component.createObject(scene);
            childRec.x =  Param.margin48;
            childRec.y =  Param.margin48;
            childRec.dragMinX =  Param.margin48
            childRec.dragMaxX =  scene.width -  Param.margin48 - childRec.width
            childRec.dragMinY =  Param.margin48
            childRec.dragMaxY =  scene.height -  Param.margin48 - childRec.height
            childRec.itemText = name_ru
            childRec.icon = icon

            // Сигнал
            childRec.positionChange.connect(onPositionChange)

            let coun = funckBlocks.count

            for( var i = 0; i < coun; i++ ) {
                //в connect  можно добавить данные о связи между блоками
                let componentLine = Qt.createComponent("line.qml");
                if (componentLine.status == Component.Ready) {
                    let childline = componentLine.createObject(scene);
                    childline.x1 = childRec.x + childRec.width/2;
                    childline.y1 = childRec.y + childRec.height/2;
                    childline.x2 = funckBlocks.get(i).data.x + funckBlocks.get(i).data.width/2;
                    childline.y2 = funckBlocks.get(i).data.y + funckBlocks.get(i).data.height/2;

                    childline.visible = true
                    console.log(childline.x, childline.y, childline.x1,childline.y1, childline.x2,childline.y2, childline.rotation)
                    connectFunckBlock.append({firstNode: childRec, secondNode: funckBlocks.get(i).data, connect:childline })
                }
            }
            funckBlocks.append({id:name_eng,data:childRec})
        }
    }

    // поиск по блокам и связям
    function find(model, criteria) {
        for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return model.get(i)
        return null
    }

    // тут хранятся созданные блоки
    ListModel {
        id: funckBlocks

    }

    // тут хранятся связи между ними
    ListModel {
        id: connectFunckBlock

    }

    //заголовок
    Rectangle{
        x: Param.margin80
        y: 0
        height: Param.margin80*2 + Param.margin48
        width: Param.buttonBigWidth
        color: mainWindow.color
        Text {
            width: parent.width
            height: parent.height
            anchors.left: parent.left;
            anchors.leftMargin: 0
            text: "Мониторинг"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textTitleSize
            color: darkTheme? Param.accentСolor1:Param.ltextColor1
        }
    }

    //кнопка для смены цвета темы
    Rectangle{
        id: theme
        x: mainWindow.width - Param.buttonThemeSize - Param.margin80
        y: Param.margin80
        height: Param.buttonThemeSize
        width: Param.buttonThemeSize
        color: mainWindow.color
        Component.onCompleted: {
            let component = Qt.createComponent("theme.qml");
            if (component.status === Component.Ready) {
                let childRec = component.createObject(theme)
                childRec.onClick.connect(function(){
                    darkTheme = !darkTheme
                })
            }
        }
    }

    //сцена для отоброжения объектов
    Rectangle {
        id: scene
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        width: parent.width - Param.margin48 - Param.margin80*2- Param.buttonBigWidth
        height: parent.height - Param.margin48 - Param.margin80*3
        y: Param.margin80*2 + Param.margin48
        x: Param.margin48 + Param.margin80 + Param.buttonBigWidth
        radius: Param.elemRadius
        z: -1
        clip: true

        DropArea {
            id: dropArea
            anchors.fill: parent
        }
    }

    //тени
    DropShadow {
        anchors.fill: scene
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: scene
    }

    //меню для отоброжения и скрытия объектов
    Rectangle {
        id: menu
        color: darkTheme?Param.delemFirstColor:Param.lelemFirstColor
        width: Param.buttonBigWidth
        height: Param.buttonSmallHeight*4 + Param.margin32*2 + Param.margin24*3
        y: Param.margin80*2 + Param.margin48
        x: Param.margin80
        radius: Param.elemRadius
        z: -1

        property string createBlockPPU:  "no"
        property string createBlockPPO:  "no"
        property string createBlockBASI:  "no"
        property string createBlockBAPPD:  "no"


        Component.onCompleted: {
            let component = Qt.createComponent("smallButton.qml");
            if (component.status === Component.Ready) {

                let childRec = component.createObject(menu)
                childRec.x = parent.x + Param.margin32
                childRec.y = parent.y + Param.margin32
                childRec.itemText = "Отобразить ППУ"
                childRec.itemTextOnClick = "Скрыть ППУ"

                childRec.onClick.connect(function(){
                    if(createBlockPPU == "no") {
                        createFunckBlock("PPU", "ППУ", Param.iconPPUDark )
                        createBlockPPU = "yes"
                    }
                }
                )


                let childRec1 = component.createObject(menu)
                childRec1.x = parent.x + Param.margin32
                childRec1.y = parent.y + Param.margin32 +Param.margin24 +Param.buttonSmallHeight
                childRec1.itemText = "Отобразить ППО"
                childRec1.itemTextOnClick = "Скрыть БАСИ"

                childRec1.onClick.connect(function(){
                    if(createBlockBASI == "no") {
                        createFunckBlock("BASI", "БАСИ", Param.iconBASIDark )
                        createBlockBASI = "yes"
                    }
                }
                )

                let childRec2 = component.createObject(menu)
                childRec2.x = parent.x + Param.margin32
                childRec2.y = parent.y + Param.margin32 +Param.margin24*2 +Param.buttonSmallHeight*2
                childRec2.itemText = "Отобразить БАППД"
                childRec2.itemTextOnClick = "Скрыть БАППД"

                childRec2.onClick.connect(function(){
                    if(createBlockBAPPD == "no") {
                        createFunckBlock("BAPPD", "БАППД", Param.iconBAPPDDark )
                        createBlockBAPPD = "yes"
                    }
                }
                )

                let childRec3 = component.createObject(menu)
                childRec3.x = parent.x + Param.margin32
                childRec3.y = parent.y + Param.margin32 +Param.margin24*3 +Param.buttonSmallHeight*3
                childRec3.itemText = "Отобразить ППО"
                childRec3.itemTextOnClick = "Скрыть ППО"

                childRec3.onClick.connect(function(){
                    if(createBlockPPO == "no") {
                        createFunckBlock("PPO", "ППО", Param.iconPPODark )
                        createBlockPPO = "yes"
                    }
                }
                )
            }
        }
    }

    //тени
    DropShadow {
        anchors.fill: menu
        horizontalOffset: Param.horizOffset
        verticalOffset: Param.verticOffset
        radius: Param.mainRadius
        samples: Param.mainSamples
        color: darkTheme?Param.dDropShadowColor:Param.lDropShadowColor
        source: menu
    }

    //меню для отоброжения связей и расположения
    Rectangle {
        id: menu2
        color: mainWindow.color
        width: Param.buttonBigWidth
        height: Param.margin32 + Param.buttonBigHeight*2
        y: mainWindow.height - Param.margin32 - Param.margin80 - Param.buttonBigHeight*2
        x: Param.margin80
        radius: Param.elemRadius
        z: -1
        property bool visibleConnect: true
        Component.onCompleted: {
            let component = Qt.createComponent("bigButton.qml");
            if (component.status === Component.Ready) {
                let childRec4 = component.createObject(menu2)
                childRec4.x = parent.x
                childRec4.y = parent.y
                childRec4.itemText = "Показать связи"
                childRec4.itemTextOnClick = "Скрыть связи"

                childRec4.onClick.connect(function(){
                    if(menu2.visibleConnect){
                        menu2.visibleConnect = false
                        for(let i = 0; i < connectFunckBlock.count; i++){
                            connectFunckBlock.get(i).connect.visible = false
                        }
                    }
                    else{
                        for(let i = 0; i < connectFunckBlock.count; i++){

                            let firstNode = connectFunckBlock.get(i).firstNode
                            let secondNode = connectFunckBlock.get(i).secondNode
                            let connect = connectFunckBlock.get(i).connect

                            connect.x1 = firstNode.x + firstNode.width/2
                            connect.y1 = firstNode.y + firstNode.height/2
                            connect.x2 = secondNode.x + firstNode.width/2
                            connect.y2 = secondNode.y + firstNode.height/2
                            connectFunckBlock.get(i).connect.visible = true

                        }
                        menu2.visibleConnect = true
                    }
                })


                let childRec5 = component.createObject(menu2)
                childRec5.x = parent.x
                childRec5.y = parent.y + Param.margin32 + Param.buttonBigHeight
                childRec5.itemText = "Упорядочить"
                childRec5.itemTextOnClick = "Упорядочить"
                childRec5.onClick.connect(function(){
                    let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                    if(PPU !== null) {
                        PPU.data.x = Param.margin48
                        PPU.data.y = scene.height - Param.margin48 - PPU.data.height
                    }

                    let PPO = find(funckBlocks, function(item) { return item.id === "PPO" })
                    if(PPO !== null) {
                        PPO.data.x = scene.width - Param.margin48 - PPO.data.width
                        PPO.data.y = scene.height - Param.margin48 - PPO.data.height
                    }

                    let BASI = find(funckBlocks, function(item) { return item.id === "BASI" })
                    if(BASI !== null) {
                        BASI.data.x = scene.width/2 - Param.margin48/2 - BASI.data.width
                        BASI.data.y = Param.margin48
                    }

                    let BAPPD = find(funckBlocks, function(item) { return item.id === "BAPPD" })
                    if(BAPPD!== null) {
                        BAPPD.data.x = scene.width/2 + Param.margin48/2
                        BAPPD.data.y = Param.margin48
                    }

                    for(let i = 0; i < connectFunckBlock.count; i++){
                        let firstNode = connectFunckBlock.get(i).firstNode
                        let secondNode = connectFunckBlock.get(i).secondNode
                        let connect = connectFunckBlock.get(i).connect

                        connect.x1 = firstNode.x + firstNode.width/2
                        connect.y1 = firstNode.y + firstNode.height/2
                        connect.x2 = secondNode.x + firstNode.width/2
                        connect.y2 = secondNode.y + firstNode.height/2

                    }
                }
                )

            }
        }
    }
}
