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
    minimumHeight: Param.margin80*3 + Param.margin48*3 + menu.height + menu2.height + Param.buttonSmallHeight
    minimumWidth: Param.margin80*2 + Param.margin48*4 + Param.fBWidth + Param.buttonBigWidth*2
    property bool darkTheme: true

    // Перемещение связи за квадратом
    function onPositionChange(x,y,itemText){

        for(let i = 0; i < connectFunckBlock.count; i++){
            if(connectFunckBlock.get(i).firstNode.itemText  === itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x1 = firstNode.x + firstNode.width/2
                connect.y1 = firstNode.y + firstNode.height/2
            }
            else if(connectFunckBlock.get(i).secondNode.itemText === itemText) {
                let firstNode = connectFunckBlock.get(i).firstNode
                let secondNode = connectFunckBlock.get(i).secondNode
                let connect = connectFunckBlock.get(i).connect
                connect.x2 = secondNode.x + secondNode.width/2
                connect.y2 = secondNode.y + secondNode.height/2

            }
        }
    }

    // функция для кнопок - в параметры передаются настраевымые значения
    function createFunckBlock(name_eng, name_ru, icon, itemComp, statConnect) {
        //динамическое создание объекта
        let component = Qt.createComponent("funckBlock.qml");
        if (component.status === Component.Ready) {
            let childRec = component.createObject(scene);
            childRec.x =  Param.margin48;
            childRec.y =  Param.margin48;
            childRec.dragMinX =  Param.margin48
            childRec.dragMaxX =  scene.width -  Param.margin48 - childRec.width
            childRec.dragMinY =  Param.margin48
            childRec.dragMaxY =  scene.height -  Param.margin48 - childRec.height
            childRec.itemText = name_ru
            childRec.icon = icon

            childRec.itemComp = itemComp

            childRec.positionChange.connect(onPositionChange)

            scene.widthChange.connect(function(){
                childRec.dragMinX =  Param.margin48
                childRec.dragMaxX =  scene.width -  Param.margin48 - childRec.width
            })
            scene.heightChange.connect(function(){
                childRec.dragMinY =  Param.margin48
                childRec.dragMaxY =  scene.height -  Param.margin48 - childRec.height
            })

            let coun = funckBlocks.count

            for( var i = 0; i < coun; i++ ) {
                //в connect  можно добавить данные о связи между блоками
                let componentLine = Qt.createComponent("line.qml");
                if (componentLine.status === Component.Ready) {
                    let childline = componentLine.createObject(scene);
                    childline.x1 = childRec.x + childRec.width/2;
                    childline.y1 = childRec.y + childRec.height/2;
                    childline.x2 = funckBlocks.get(i).data.x + funckBlocks.get(i).data.width/2;
                    childline.y2 = funckBlocks.get(i).data.y + funckBlocks.get(i).data.height/2;
                    childline.visible = true
                    childline.statConnect = statConnect
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

    //функция для скрытия связи
    function visConnectNO(itemText){
        for(let i = 0; i < connectFunckBlock.count; i++){
            let firstNode = connectFunckBlock.get(i).firstNode
            let secondNode = connectFunckBlock.get(i).secondNode
            let connect = connectFunckBlock.get(i).connect
            if((firstNode.itemText === itemText )|| secondNode.itemText === itemText){
                connect.visible = false
            }
        }
    }

    //функция для отоброжения связи
    function visConnect(itemText){
        for(let i = 0; i < connectFunckBlock.count; i++){
            let firstNode = connectFunckBlock.get(i).firstNode
            let secondNode = connectFunckBlock.get(i).secondNode
            let connect = connectFunckBlock.get(i).connect
            if((firstNode.itemText === itemText && secondNode.visible === true)|| (secondNode.itemText === itemText && firstNode.visible === true)){
                connect.visible = true
            }
        }
    }

    //функция для чтения файлов
    function readTextFile(file)    {
        var rawFile = new XMLHttpRequest();
        var allText
        rawFile.open("GET", file, false);
        rawFile.onreadystatechange = function ()
        {
            if(rawFile.readyState === 4)
            {
                if(rawFile.status === 200 || rawFile.status === 0)
                {
                    allText = rawFile.responseText;

                }
            }
        }
        rawFile.send(null);
        return allText
    }

    //функция создание компонентов для функционального блока
    function createItemComp(file) {

        let text = readTextFile(file)
        let string = text.split('\n')
        let item = []

        for (let i = 0; i < string.length; i++){
            let elem = string[i].split(";")
            item.push({number: elem[0]*1, name: elem[1], stat: elem[2], state_text: elem[3], text: elem[4]})
        }
        return item
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
            text: "Оценка работоспособности БА"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: Param.textFontFamily
            font.pointSize: Param.textTitleSize
            color: darkTheme? Param.accentСolor1:Param.ltextColor1
        }
    }

    signal themeChange()
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
                    themeChange()

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
        signal widthChange()

        onWidthChanged: {
            widthChange()
        }

        signal heightChange()

        onHeightChanged: {
            heightChange()
        }
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

                //параметры БА
                let itemCompPPU = createItemComp("file:/pract_project/task2-1/itemCompPPU.txt")

                childRec.onClick.connect(function(){
                    if(createBlockPPU === "no") {
                        createFunckBlock("PPU", "ППУ", Param.iconPPUDark, itemCompPPU, true)
                        createBlockPPU = "yes"
                    }
                    else if(createBlockPPU === "yes"){
                        let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                        PPU.data.visible = false
                        visConnectNO("ППУ")
                        createBlockPPU = "no-vis"
                    }
                    else {
                        let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                        PPU.data.visible = true
                        visConnect("ППУ")
                        createBlockPPU = "yes"
                    }
                    if(menu2.visibleConnect === false){
                        visConnectNO("ППУ")
                    }
                }
                )


                let childRec1 = component.createObject(menu)
                childRec1.x = parent.x + Param.margin32
                childRec1.y = parent.y + Param.margin32 +Param.margin24 +Param.buttonSmallHeight
                childRec1.itemText = "Отобразить БАСИ"
                childRec1.itemTextOnClick = "Скрыть БАСИ"

                //параметры БА
                let itemCompBASI = createItemComp("file:/pract_project/task2-1/itemCompBASI.txt")

                childRec1.onClick.connect(function(){
                    if(createBlockBASI === "no") {
                        createFunckBlock("BASI", "БАСИ", Param.iconBASIDark, itemCompBASI, false )
                        createBlockBASI = "yes"
                    }
                    else if(createBlockBASI === "yes"){
                        let PPU = find(funckBlocks, function(item) { return item.id === "BASI" })
                        PPU.data.visible = false
                        visConnectNO("БАСИ")
                        createBlockBASI = "no-vis"
                    }
                    else {
                        let PPU = find(funckBlocks, function(item) { return item.id === "BASI" })
                        PPU.data.visible = true
                        visConnect("БАСИ")
                        createBlockBASI = "yes"
                    }
                    if(menu2.visibleConnect === false){
                        visConnectNO("БАСИ")
                    }
                }
                )

                let childRec2 = component.createObject(menu)
                childRec2.x = parent.x + Param.margin32
                childRec2.y = parent.y + Param.margin32 +Param.margin24*2 +Param.buttonSmallHeight*2
                childRec2.itemText = "Отобразить БАППД"
                childRec2.itemTextOnClick = "Скрыть БАППД"

                //параметры БА
                let itemCompBAPPD = createItemComp("file:/pract_project/task2-1/itemCompBAPPD.txt")

                childRec2.onClick.connect(function(){
                    if(createBlockBAPPD === "no") {
                        createFunckBlock("BAPPD", "БАППД", Param.iconBAPPDDark , itemCompBAPPD,true)
                        createBlockBAPPD = "yes"
                    }
                    else if(createBlockBAPPD === "yes"){
                        let PPU = find(funckBlocks, function(item) { return item.id === "BAPPD" })
                        PPU.data.visible = false
                        visConnectNO("БАППД")
                        createBlockBAPPD = "no-vis"
                    }
                    else {
                        let PPU = find(funckBlocks, function(item) { return item.id === "BAPPD" })
                        PPU.data.visible = true
                        visConnect("БАППД")
                        createBlockBAPPD = "yes"
                    }
                    if(menu2.visibleConnect === false){
                        visConnectNO("БАППД")
                    }
                }
                )

                let childRec3 = component.createObject(menu)
                childRec3.x = parent.x + Param.margin32
                childRec3.y = parent.y + Param.margin32 +Param.margin24*3 +Param.buttonSmallHeight*3
                childRec3.itemText = "Отобразить ППО"
                childRec3.itemTextOnClick = "Скрыть ППО"

                //параметры БА
                let itemCompPPO = createItemComp("file:/pract_project/task2-1/itemCompPPO.txt")

                childRec3.onClick.connect(function(){
                    if(createBlockPPO === "no") {
                        createFunckBlock("PPO", "ППО", Param.iconPPODark, itemCompPPO, true )
                        createBlockPPO = "yes"
                    }
                    else if(createBlockPPO === "yes"){
                        let PPU = find(funckBlocks, function(item) { return item.id === "PPO" })
                        PPU.data.visible = false
                        visConnectNO("ППО")
                        createBlockPPO= "no-vis"
                    }
                    else {
                        let PPU = find(funckBlocks, function(item) { return item.id === "PPO" })
                        PPU.data.visible = true
                        visConnect("ППО")
                        createBlockPPO = "yes"
                    }
                    if(menu2.visibleConnect === false){
                        visConnectNO("ППО")
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
                // отоброжение связей
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

                            if(firstNode.visible && secondNode.visible){
                                connect.x1 = firstNode.x + firstNode.width/2
                                connect.y1 = firstNode.y + firstNode.height/2
                                connect.x2 = secondNode.x + firstNode.width/2
                                connect.y2 = secondNode.y + firstNode.height/2
                                connectFunckBlock.get(i).connect.visible = true}

                        }
                        menu2.visibleConnect = true
                    }
                })


                // упорядочить связи
                let childRec5 = component.createObject(menu2)
                childRec5.x = parent.x
                childRec5.y = parent.y + Param.margin32 + Param.buttonBigHeight
                childRec5.itemText = "Упорядочить"
                childRec5.itemTextOnClick = "Упорядочить"
                childRec5.onClick.connect(function(){
                    //readTextFile("file:/pract_project/task2-1/text.txt");

                    let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                    if(PPU !== null) {
                        PPU.data.x = Param.margin48
                        PPU.data.y = PPU.data.dragMaxY
                    }

                    let PPO = find(funckBlocks, function(item) { return item.id === "PPO" })
                    if(PPO !== null) {
                        PPO.data.x = scene.width - Param.margin48 - PPO.data.width
                        PPO.data.y = PPO.data.dragMaxY
                    }

                    let BASI = find(funckBlocks, function(item) { return item.id === "BASI" })
                    if(BASI !== null) {
                        BASI.data.x = scene.width/2 - Param.margin48/2 - BASI.data.width
                        BASI.data.y = BASI.data.dragMinY
                    }

                    let BAPPD = find(funckBlocks, function(item) { return item.id === "BAPPD" })
                    if(BAPPD!== null) {
                        BAPPD.data.x = scene.width/2 + Param.margin48/2
                        BAPPD.data.y = BAPPD.data.dragMinY
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
