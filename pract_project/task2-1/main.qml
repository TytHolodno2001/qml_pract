import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {

    width: 1200
    height: 480
    visible: true
    property int menuWidth: 250
    property int menuHeight: 50
    property int margins: 10
    property color menuColor: "#DCCEC3"
    property int menuRadius: 6
    property string fontFamily: "Comfortaa"
    property int pointSize: 10
    property color fontColor:"black"


    // функция для кнопок - в параметры передаются настраевымые значения
    function createFunckBlock(name_eng, name_ru) {
        //динамическое создание объекта
        let component = Qt.createComponent("funckBlock.qml");
        if (component.status == Component.Ready) {
            let childRec = component.createObject(scene);
            childRec.x = margins;
            childRec.y = margins;
            childRec.dragMinX =  margins
            childRec.dragMaxX =  scene.width - margins - childRec.width
            childRec.dragMinY =  margins
            childRec.dragMaxY =  scene.height - margins - childRec.height
            childRec.itemText = name_ru

            let coun = funckBlocks.count
            funckBlocks.append({id:name_eng,data:childRec})

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
                    connectFunckBlock.append({firstNode: name_eng, secondNode: funckBlocks.get(i).id, connect:childline })
                }
            }
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
        dynamicRoles: true
    }

    // тут хранятся связи между ними
    ListModel {
        id: connectFunckBlock
        dynamicRoles: true
    }

    //сцена для отоброжения объектов
    Rectangle {
        id: scene
        border.color: menuColor
        width: parent.width - margins - menuWidth
        height: parent.height
        x: margins + menuWidth
        radius: menuRadius
        z: -1
        clip: true
    }

    //меню для создания и удаления объектов

    //создание ППУ
    Rectangle {
        id: createBlockPPU
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius

        property string createBlock:  "no"

        Text {
            width: parent.width - menuHeight
            height: parent.height
            text: "Создать ППУ"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }

        //показывает создан ли объект
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 0
            width: menuHeight
            height: menuHeight
            color: menuColor
            radius: menuRadius
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: createBlockPPU.createBlock =="yes" ? "file:/pract_project/task2-1/yes.png" : "file:/pract_project/task2-1/no.png"
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if(createBlockPPU.createBlock == "no") {
                    createFunckBlock( "PPU", "ППУ" )
                    createBlockPPU.createBlock = "yes"
                }
            }
        }
    }

    //создание БАСИ
    Rectangle {
        id: createBlockBASI
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius
        y: menuHeight + margins

        property string createBlock:  "no"

        Text {
            width: parent.width - menuHeight
            height: parent.height
            text: "Создать БАСИ"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }


        //показывает создан ли объект
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 0
            width: menuHeight
            height: menuHeight
            color: menuColor
            radius: menuRadius
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: createBlockBASI.createBlock =="yes" ? "file:/pract_project/task2-1/yes.png" : "file:/pract_project/task2-1/no.png"
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                if(createBlockBASI.createBlock == "no") {
                    createFunckBlock( "BASI", "БАСИ" )
                    createBlockBASI.createBlock = "yes"
                }

            }
        }
    }

    //создание ППО
    Rectangle {
        id: createBlockPPO
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius
        y: (menuHeight + margins)*2

        property string createBlock:  "no"

        Text {
            width: parent.width - menuHeight
            height: parent.height
            text: "Создать ППО"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }


        //показывает создан ли объект
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 0
            width: menuHeight
            height: menuHeight
            color: menuColor
            radius: menuRadius
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: createBlockPPO.createBlock =="yes" ? "file:/pract_project/task2-1/yes.png" : "file:/pract_project/task2-1/no.png"
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {

                if(createBlockPPO.createBlock == "no") {
                    createFunckBlock( "PPO", "ППО" )
                    createBlockPPO.createBlock = "yes"
                }

            }
        }
    }

    //создание БАППД
    Rectangle {
        id: createBlockBAPPD
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius
        y: (menuHeight + margins)*3

        property string createBlock:  "no"

        Text {
            width: parent.width - menuHeight
            height: parent.height
            text: "Создать БАППД"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }


        //показывает создан ли объект
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 0
            width: menuHeight
            height: menuHeight
            color: menuColor
            radius: menuRadius
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: createBlockBAPPD.createBlock =="yes" ? "file:/pract_project/task2-1/yes.png" : "file:/pract_project/task2-1/no.png"
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 0
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {

                if(createBlockBAPPD.createBlock == "no") {
                    createFunckBlock("BAPPD", "БАППД" )
                    createBlockBAPPD.createBlock = "yes"
                }

            }
        }
    }

    //выравнять объекты
    Rectangle {
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius
        y: parent.height - menuHeight - margins


        Text {
            width: parent.width
            height: parent.height
            text: "Упорядочить"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {

                let PPU = find(funckBlocks, function(item) { return item.id === "PPU" })
                if(PPU !== null) {
                    PPU.data.x = margins
                    PPU.data.y = scene.height - margins - PPU.data.height
                }

                let PPO = find(funckBlocks, function(item) { return item.id === "PPO" })
                if(PPO !== null) {
                    PPO.data.x = scene.width - margins - PPO.data.width
                    PPO.data.y = scene.height - margins - PPO.data.height
                }

                let BASI = find(funckBlocks, function(item) { return item.id === "BASI" })
                if(BASI !== null) {
                    BASI.data.x = scene.width/2 - margins/2 - BASI.data.width
                    BASI.data.y = margins
                }

                let BAPPD = find(funckBlocks, function(item) { return item.id === "BAPPD" })
                if(BAPPD!== null) {
                    BAPPD.data.x = scene.width/2 + margins/2
                    BAPPD.data.y = margins
                }
            }
        }
    }

    //показать связи
    Rectangle {
        id: conn
        width: menuWidth
        height: menuHeight
        color: menuColor
        radius: menuRadius
        y: parent.height - (menuHeight + margins)*2
        property bool visibleConnect: true
        Text {
            width: parent.width
            height: parent.height
            text: conn.visibleConnect?"Скрыть связи":"Показать связи"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: fontFamily
            font.pointSize: pointSize
            color: fontColor
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            { //отоброжение свзяей

                if(conn.visibleConnect){
                    conn.visibleConnect = false
                    for(let i = 0; i < connectFunckBlock.count; i++){
                        connectFunckBlock.get(i).connect.visible = false
                    }
                }
                else{
                    for(let i = 0; i < connectFunckBlock.count; i++){
                        connectFunckBlock.get(i).connect.visible = true
                    }
                    conn.visibleConnect = true
                }


            }
        }
    }
}
