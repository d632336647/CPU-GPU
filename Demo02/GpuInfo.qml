import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as FlatDark

Rectangle {
    id:root
    color: "#1A1A1C"
    clip:true

    //左侧 CPU GPU RAM状态显示
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:cpuGpuRamBox
        state: "HIDE"
        property real cGpuProportion: 0.8
        property real cGpuProportion2: 0.27
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 4
//        anchors.right: parent.right
//        anchors.rightMargin: 4
//        anchors.bottom: systemStatusBox.bottom
//        anchors.bottomMargin: 4
        height: cpuGpuRamBox.cGpuProportion*parent.height
        width: 0.27*parent.width
        clip:true
        color: "black"
        //border.color: "#808080"
        //radius: 4
        Text {
            visible: false
            id: moreButton
            font.family: "themify"
            text: qsTr("\ue6e6")
            font.pixelSize: 40
            color: "#1883D7"
//            anchors.verticalCenter: parent.verticalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -10
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    moreButton.color = "#18f0D7"
                }
                onExited: {
                    moreButton.color = "#1883D7"
                }
                onClicked: {
                    stateChange()
                    mouse.accpeted = true
                }
            }
        }

        Row{
            id:rowtop
            anchors.top: parent.top
            spacing: 0.12*parent.width
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 0.11*parent.width
//            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 0.8*cpuGpuRamBox.cGpuProportion2*root.height
            Item{
                width: 0.33*parent.width
                height: parent.height
                Text{
                    id:cpuLable
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "CPU使用率"
                    font.family: FlatDark.fontFamily

                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:cpuProcess
                    anchors.top: cpuLable.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: width
                    showGrow: false
                    Component.onCompleted: {
                        percent = Number(GetSysInfo.getCpuPercent())/100.0
                    }
                }
                Text{
                    id:cpuLable2
                    visible: false
                    anchors.top: cpuProcess.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:65℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressGrillX{
                    id:cpuTemp
                    visible: false
                    anchors.top: cpuLable2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
                }
            }

            Item{
                width: 0.33*parent.width
                height: width
                Text{
                    id:ramLable
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "RAM使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:ramProcess
                    anchors.top: ramLable.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: width
                    showGrow: false
//                    Component.onCompleted: {
//                        percent =  Number(GetSysInfo.getMemoryPercent())/100.0
//                    }
                }
            }
        }
        Rectangle {
            id: nc
            width: parent.width-0.2*parent.width
            height: 20
            anchors.bottom: rowtop.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#00000000"
            border.color: "#0afffc"
            Text{
                id:ramLable2
                height: 20
                anchors.left: parent.left
                anchors.leftMargin: 0.05*parent.width
                text: "物理内存：16GB"
                font.family: FlatDark.fontFamily
                color:FlatDark.fontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
            Text{
                id:ramLable3
                height: 20
                text: "虚拟内存: 16GB"
                anchors.right:  parent.right
                anchors.rightMargin: 0.05*parent.width
                font.family: FlatDark.fontFamily
                color:FlatDark.fontColor
                font.pixelSize: FlatDark.mainFontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }
        Row{
            id:rowmiddle
            anchors.top: rowtop.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            width: parent.width
//            height: cpuGpuRamBox.cGpuProportion2*root.height
            Item{
                id:gpu1
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable1
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[1]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess1
                    anchors.top: gpuLable1.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: gpuProcess1.width
                    showGrow: false
                    percent: gpu1.gpuPercent/100.0
                }
                ProgressSixGrilX{
                    id:gpuTemp1
                    anchors.bottom: gpuProcess1.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu1.cachePercent/100.0
                }
                Text{
                    id:gpuLable11
                    anchors.bottom: gpuTemp1.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:" +gpu1.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }

            Item{
                id:gpu2
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable2
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[2]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess2
                    anchors.top: gpuLable2.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent:gpu2.gpuPercent/100.0
                }
                ProgressSixGrilX{
                    id:gpuTemp2
                    anchors.bottom: gpuProcess2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent:gpu2.cachePercent/100.0
                }
                Text{
                    id:gpuLable21
                    anchors.bottom: gpuTemp2.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu2.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
        Rectangle
        {
            width: parent.width-30
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d0d0d0"
            anchors.bottom: rowmiddle.bottom
            opacity: 0.3
        }
        Row{
            id:rowdown
            anchors.top: rowmiddle.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            width: parent.width
//            height: cpuGpuRamBox.cGpuProportion2*root.heightt
            Item{
                id:gpu3
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable3
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[3]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess3
                    anchors.top: gpuLable3.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu3.gpuPercent/100.0
                }
                ProgressSixGrilX{
                    id:gpuTemp3
                    anchors.bottom: gpuProcess3.bottom

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu3.cachePercent/100.0
                }
                Text{
                    id:gpuLable31
                    anchors.bottom: gpuTemp3.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu3.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Item{
                id:gpu4
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable4
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[4]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess4
                    anchors.top: gpuLable4.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu4.gpuPercent/100.0
                }

                ProgressSixGrilX{
                    id:gpuTemp4
                    anchors.bottom: gpuProcess4.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu4.cachePercent/100.0
                }
                Text{
                    id:gpuLable41
                    anchors.bottom: gpuTemp4.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu4.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
        Rectangle
        {
            width: parent.width-30
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d0d0d0"
            anchors.bottom: rowdown.bottom
            opacity: 0.3
        }
        Row{
            id:rowdown2
            anchors.top: rowdown.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            width: parent.width
//            height: cpuGpuRamBox.cGpuProportion2*root.heightt
            Item{
                id:gpu5
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable5
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[5]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess5
                    anchors.top: gpuLable5.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu5.gpuPercent/100.0
                }
                ProgressSixGrilX{
                    id:gpuTemp5
                    anchors.bottom: gpuProcess5.bottom

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu5.cachePercent/100.0
                }
                Text{
                    id:gpuLable51
                    anchors.bottom: gpuTemp5.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu6.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Item{
                id:gpu6
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable6
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[6]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess6
                    anchors.top: gpuLable6.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu6.gpuPercent/100.0
                }

                ProgressSixGrilX{
                    id:gpuTemp6
                    anchors.bottom: gpuProcess6.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu6.cachePercent/100.0
                }
                Text{
                    id:gpuLable61
                    anchors.bottom: gpuTemp6.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu6.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
        Rectangle
        {
            width: parent.width-30
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d0d0d0"
            anchors.bottom: rowdown2.bottom
            opacity: 0.3
        }
        Row{
            id:rowdown3
            anchors.top: rowdown2.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            width: parent.width
//            height: cpuGpuRamBox.cGpuProportion2*root.heightt
            Item{
                id:gpu7
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable7
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[7]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess7
                    anchors.top: gpuLable7.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu7.gpuPercent/100.0
                }
                ProgressSixGrilX{
                    id:gpuTemp7
                    anchors.bottom: gpuProcess7.bottom

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu7.cachePercent/100.0
                }
                Text{
                    id:gpuLable71
                    anchors.bottom: gpuTemp7.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu7.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Item{
                id:gpu8
                scale: 1
                property real gpuPercent: 0
                property real cachePercent: 0
                width: 0.5*parent.width
                height: width-20
                Text{
                    id:gpuLable8
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 20
                    text: "[8]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess8
                    anchors.top: gpuLable8.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                    percent: gpu8.gpuPercent/100.0
                }

                ProgressSixGrilX{
                    id:gpuTemp8
                    anchors.bottom: gpuProcess8.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 10
                    cubeMargin: 1
                    showGrow: false
                    percent: gpu8.cachePercent/100.0
                }
                Text{
                    id:gpuLable81
                    anchors.bottom: gpuTemp8.top
                    anchors.bottomMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 20
                    text: "显存:"+gpu8.cachePercent+"%"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+6
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }

        //过渡动画
        states: [
            State {
                name: "HIDE"
                PropertyChanges { target: cpuGpuRamBox; cGpuProportion: 0.27}
                onCompleted:{
                }
            },
            State {
                name: "SHOW"
                PropertyChanges { target: cpuGpuRamBox; cGpuProportion: 1}
                onCompleted: {
                }
            }
        ]

        transitions: [
             Transition {
                 from:"SHOW"
                 to: "HIDE"
                 PropertyAnimation { properties: "cGpuProportion";
                     duration: 1000; easing.type: Easing.OutExpo }
             },
             Transition {
                 from:"HIDE"
                 to: "SHOW"
                 PropertyAnimation { properties: "cGpuProportion";
                     duration: 1000; easing.type: Easing.OutExpo }//OutCubic
             }
        ]

        Component.onCompleted: {
            cpuGpuRamBox.state= "SHOW"
            gpuProcess1.state = "SHOW"
            gpuProcess2.state = "SHOW"
            gpuProcess3.state = "SHOW"
            gpuProcess4.state = "SHOW"
            gpuProcess5.state = "SHOW"
            gpuProcess6.state = "SHOW"
            gpuProcess7.state = "SHOW"
            gpuProcess8.state = "SHOW"
            gpuTemp1.state    = "SHOW"
            gpuTemp2.state    = "SHOW"
            gpuTemp3.state    = "SHOW"
            gpuTemp4.state    = "SHOW"
            gpuTemp5.state    = "SHOW"
            gpuTemp6.state    = "SHOW"
            gpuTemp7.state    = "SHOW"
            gpuTemp8.state    = "SHOW"
        }
    }//END 底部右侧 CPU GPU RAM状态显示




    //右侧顶部 硬盘状态显示
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:systemStatusBox
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: cpuGpuRamBox.right
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
        height:0.27*parent.height
        width: 0.7*parent.width
        color: "black"
        //border.color: "#808080"
        //radius: 4
        Rectangle{
            color: "#3D3D3F"
            width: parent.width
            height: 1
        }
        Rectangle{
            id:sysStatusTitle
            anchors.top: parent.top
            anchors.topMargin: 1
            width: parent.width
            height: 30
            color: "#404244"
            Row{
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                Rectangle{
                    height: parent.height
                    width: 0.1*parent.width
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"磁盘分区"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.2*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"分区大小"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.2*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"硬盘温度"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Rectangle{
                    width: 0.5*parent.width
                    height: parent.height
                    color: "#404244"
                    //border.color: "#1A1A1C"
                    Text{
                        anchors.fill: parent
                        text:"分区使用率"
                        font.family: FlatDark.fontFamily
                        color:FlatDark.ComboBoxFontColor
                        font.pixelSize: FlatDark.mainFontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
        Component {
            id: sysDelegate
            Item {
                id:sysWrapper
                width: borderSysBox.width
                height: 30
                //color: "#404244"
                Row{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width
                    height: parent.height
                    Item{
                        height: parent.height
                        width: 0.1*parent.width
                        Text{
                            id:iconSSD
                            anchors.top: parent.top
                            anchors.left: parent.left
                            height: parent.height
                            width: height
                            text: icon
                            font.family: "themify"
                            color:"#c0c0c0"
                            font.weight: Font.Bold
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text{
                            anchors.top: parent.top
                            anchors.left: iconSSD.right
                            anchors.right: parent.right
                            height: parent.height
                            text: "SSD "+name
                            font.family: FlatDark.fontFamily
                            color:"#c0c0c0"
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.2*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text: size
                            font.family: FlatDark.fontFamily
                            color:"#c0c0c0"
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Item{
                        width: 0.2*parent.width
                        height: parent.height
                        Text{
                            anchors.fill: parent
                            text: temp
                            font.family: FlatDark.fontFamily
                            color:"#c0c0c0"
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Item{
                        width: 0.5*parent.width
                        height: parent.height


                        ProgressGrillX{
                            id:prigressDisk
                            anchors.fill: parent
                            iw: 6
                            cubeNumber: 50
                            cubeMargin: 1
                            showGrow: false
                            percent:percents
                        }
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //sysListView.ListView.view.currentIndex = index//更新视图索引
                        //listView.focus = true
                    }
                    onDoubleClicked:
                    {
                    }
                }
            }
        }
        ListModel {
            id: sysModel
            //ListElement {
            //  icon: "\ue69f"
            //  textColor:"#c0c0c0"
            //  name: "SSD1 C:\\"
            //  size: "120GB"
            //  temp: "46℃"
            //  used: 0.89
            //}
        }
        ScrollView{
            id:borderSysBox
            anchors.top: sysStatusTitle.bottom
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            //ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ListView {
                id:sysListView
                anchors.fill: parent
                model: sysModel
                delegate: sysDelegate
                //highlightMoveDuration: 200
                //highlight: Rectangle {
                //            color: "#808080"
                //          }
                onCurrentIndexChanged: {

                }
            }
        }
    }//END sysStateBox
    //右侧底部
    ChartPlot{
        anchors.left: systemStatusBox.left
        anchors.top: systemStatusBox.bottom
        anchors.topMargin: 4
        anchors.bottom: parent.bottom
        anchors.right: parent.right

    }
    function stateChange()
    {
        if(cpuGpuRamBox.state == "SHOW")
        {
        cpuGpuRamBox.state= "HIDE"
            gpuProcess1.state = "HIDE"
            gpuProcess2.state = "HIDE"
            gpuProcess3.state = "HIDE"
            gpuProcess4.state = "HIDE"
            gpuProcess5.state = "HIDE"
            gpuProcess6.state = "HIDE"
//            gpuProcess7.state = "HIDE"
//            gpuProcess8.state = "HIDE"
            gpuTemp1.state    = "HIDE"
            gpuTemp2.state    = "HIDE"
            gpuTemp3.state    = "HIDE"
            gpuTemp4.state    = "HIDE"
            gpuTemp5.state    = "HIDE"
            gpuTemp6.state    = "HIDE"
            gpuTemp7.state    = "HIDE"
            gpuTemp8.state    = "HIDE"
        }else{
            cpuGpuRamBox.state= "SHOW"
            gpuProcess1.state = "SHOW"
            gpuProcess2.state = "SHOW"
            gpuProcess3.state = "SHOW"
            gpuProcess4.state = "SHOW"
            gpuProcess5.state = "SHOW"
            gpuProcess6.state = "SHOW"
            gpuProcess7.state = "SHOW"
            gpuProcess8.state = "SHOW"
            gpuTemp1.state    = "SHOW"
            gpuTemp2.state    = "SHOW"
            gpuTemp3.state    = "SHOW"
            gpuTemp4.state    = "SHOW"
            gpuTemp5.state    = "SHOW"
            gpuTemp6.state    = "SHOW"
            gpuTemp7.state    = "SHOW"
            gpuTemp8.state    = "SHOW"
        }
    }
    Connections{
        target: GetSysInfo
        onUpdateMes:{
            cpuProcess.percent = GetSysInfo.getCpuPercent()/100.0
            //多一行是为了触发一次刷新
            ramProcess.percent = (GetSysInfo.getMemoryPercent()-10)/100.0
            ramProcess.percent = GetSysInfo.getMemoryPercent()/100.0

            for(var current = 0;current<GetSysInfo.getDiskCount();current++)
            {
                    var model = sysModel.get(current);
                if(model !== undefined)
                    model.percents = GetSysInfo.getDiskPercent(current)/100.0
            }

            var gpuArray = [gpu1,gpu2,gpu3,gpu4,gpu5,gpu6,gpu7,gpu8]
            for(current = 0;current< GetSysInfo.getGpuCount();current++)
            {
                gpuArray[current].gpuPercent = GetSysInfo.getGpuPercent(current)
                gpuArray[current].cachePercent = GetSysInfo.getGpuCache(current)
            }
        }
        //错误信息显示在底部 main.qml 里面定义的 rootBorder.stateError
        onSendError:{
            rootBorder.stateError = GetSysInfo.getGpuError()
        }
    }

    //初始化时 获取总内存 虚拟内存 GPU数量等信息
    Component.onCompleted: {
        ramLable2.text = "物理内存：" +GetSysInfo.getMemoryP()+"GB"
        ramLable3.text = "虚拟内存：" +GetSysInfo.getMemoryV()+"GB"
        ramProcess.percent = 0.01
        sysListView.currentIndex = 0
        sysModel.clear()
        for(var current = 0;current<GetSysInfo.getDiskCount();current++)
        {
            sysModel.append({"icon":"\ue69f",
                                "name":GetSysInfo.getDiskName(current),
                                "size":GetSysInfo.getDiskAll(current),
                                "temp":"50",
                                "percents":GetSysInfo.getDiskPercent(current)/100.0})
        }

        //GPU 确定核心数及获取使用率
        var gpuArray = [gpu1,gpu2,gpu3,gpu4,gpu5,gpu6,gpu7,gpu8]
        //全部灰掉

        for(current = 0;current< 8;current++)
        {
            gpuArray[current].opacity = 0.1
        }
        for(current = 0;current< GetSysInfo.getGpuCount();current++)
        {

            gpuArray[current].opacity = 1;
            gpuArray[current].gpuPercent = GetSysInfo.getGpuPercent(current)
            gpuArray[current].cachePercent = GetSysInfo.getGpuCache(current)
        }
    }
}
