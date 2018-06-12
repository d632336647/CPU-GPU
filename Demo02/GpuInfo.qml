import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as FlatDark

Rectangle {
    id:root
    color: "#1A1A1C"
    clip:true

    //顶部左侧 CPU GPU RAM状态显示
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
        onCGpuProportionChanged: {
            console.log("sdsa::")
        }
        Text {
            id: moreButton
            font.family: "themify"

            text: qsTr("\ue6e6")
            font.pixelSize: 40
            color: "#1883D7"
//            anchors.verticalCenter: parent.verticalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
            anchors.topMargin: 20
            anchors.left: parent.left
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
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:cpuLable2
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
                    id:gpuLable0
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "GPU使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressCircle{
                    id:gpuProcess0
                    anchors.top: gpuLable0.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:gpuLable01
                    anchors.top: gpuProcess0.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressGrillX{
                    id:gpuTemp0
                    anchors.top: gpuLable01.bottom
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
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:ramLable2
                    anchors.top: ramProcess.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  12
                    anchors.right: parent.right
                    height: 30
                    text: "总内存:16 GB"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                Text{
                    id:ramLable3
                    anchors.top: ramLable2.bottom

                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    height: 20
                    text: "虚拟内存:16 GB"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }


        Rectangle {
            id: title
            anchors.bottom: rowmiddle.top
//            anchors.bottom: rowdown.bottom
            width: parent.width
            height: 30
            color: "#00000000"
//            border.color: "#1883D7"
            Rectangle{
                height: 1
                width: parent.width-20
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#1883d7"
            }
            Text {
                id: titletext
                anchors.centerIn: parent
                font.family: "themify"
                text: qsTr("\ue684 GPU-状态详情")
                color: "#1883D7"
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }
        Row{
            id:rowmiddle
            anchors.top: rowtop.bottom
            anchors.topMargin: 60
            anchors.left: parent.left
            width: parent.width
            height: cpuGpuRamBox.cGpuProportion2*root.height
            Item{
                width: 0.5*parent.width
                height: width
                Text{
                    id:gpuLable1
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "[1]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess1
                    anchors.top: gpuLable1.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false

                }
                Text{
                    id:gpuLable11
                    anchors.top: gpuProcess1.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressSixGrilX{
                    id:gpuTemp1
                    anchors.top: gpuLable11.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false

                }
            }

            Item{
                width: 0.5*parent.width
                height: width
                Text{
                    id:gpuLable2
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "[2]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess2
                    anchors.top: gpuLable2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:gpuLable21
                    anchors.top: gpuProcess2.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressSixGrilX{
                    id:gpuTemp2
                    anchors.top: gpuLable21.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
                }
            }
        }
        Rectangle {

            anchors.bottom: rowdown.top
//            anchors.bottom: rowdown.bottom
            width: parent.width
            height: 30
            color: "#00000000"
//            border.color: "#1883D7"
            Rectangle{
                height: 1
                width: parent.width-80
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#1883d7"
            }
        }
        Row{
            id:rowdown
            anchors.top: rowmiddle.bottom
            anchors.topMargin: 0.1*parent.height
            anchors.left: parent.left
            width: parent.width
            height: cpuGpuRamBox.cGpuProportion2*root.heightt
            Item{
                width: 0.5*parent.width
                height: width
                Text{
                    id:gpuLable3
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "[3]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess3
                    anchors.top: gpuLable3.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:gpuLable31
                    anchors.top: gpuProcess3.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressSixGrilX{
                    id:gpuTemp3
                    anchors.top: gpuLable31.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
                }
            }

            Item{
                width: 0.5*parent.width
                height: width
                Text{
                    id:gpuLable4
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30
                    text: "[4]-使用率"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ProgressSix{
                    id:gpuProcess4
                    anchors.top: gpuLable4.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    height: width
                    showGrow: false
                }
                Text{
                    id:gpuLable41
                    anchors.top: gpuProcess4.bottom
                    anchors.left: parent.left
                    anchors.leftMargin:  20
                    anchors.right: parent.right
                    height: 30
                    text: "温度:75℃"
                    font.family: FlatDark.fontFamily
                    color:FlatDark.fontColor
                    font.pixelSize: FlatDark.mainFontSize+10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                ProgressSixGrilX{
                    id:gpuTemp4
                    anchors.top: gpuLable41.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 30
                    iw: 2
                    height: 20
                    cubeMargin: 1
                    showGrow: false
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
                 PropertyAnimation { properties: "cGpuProportion"; duration: 1000; easing.type: Easing.OutExpo }
             },
             Transition {
                 from:"HIDE"
                 to: "SHOW"
                 PropertyAnimation { properties: "cGpuProportion"; duration: 1000; easing.type: Easing.OutExpo }//OutCubic
             }
        ]
    }//END 底部右侧 CPU GPU RAM状态显示




    //底部左侧 硬盘状态显示
    //////////////////////////////////////////////////////////////////////////////
    Rectangle{
        id:systemStatusBox
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: cpuGpuRamBox.right
        anchors.leftMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 4
//        anchors.bottom: cpuGpuRamBox.bottom
//        anchors.bottomMargin: 4
        height:cpuGpuRamBox.cGpuProportion2*parent.height
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
                            color:textColor
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
                            text: name
                            font.family: FlatDark.fontFamily
                            color:textColor
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
                            color:textColor
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
                            color:textColor
                            font.pixelSize: FlatDark.mainFontSize
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    Item{
                        width: 0.5*parent.width
                        height: parent.height

                        ProgressGrillX{
                            anchors.fill: parent
                            iw: 6
                            cubeNumber: 50
                            cubeMargin: 1
                            showGrow: false
                            percent:used
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
            ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD1 C:\\"
                      size: "120GB"
                      temp: "46℃"
                      used: 0.89
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD1 D:\\"
                      size: "120GB"
                      temp: "46℃"
                      used: 0.35
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD2 E:\\"
                      size: "400GB"
                      temp: "52℃"
                      used: 0.55
                  }
                  ListElement {
                      icon: "\ue69f"
                      textColor:"#c0c0c0"
                      name: "SSD2 F:\\"
                      size: "100GB"
                      temp: "52℃"
                      used: 0.24
                  }

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
//                highlightMoveDuration: 200
//                highlight: Rectangle {
//                            color: "#808080"
//                          }
                onCurrentIndexChanged: {

                }
            }
        }
    }//END sysStateBox

    function stateChange()
    {
        if(cpuGpuRamBox.state == "SHOW")
        {
        cpuGpuRamBox.state= "HIDE"
        gpuProcess1.state = "HIDE"
        gpuProcess2.state = "HIDE"
        gpuProcess3.state = "HIDE"
        gpuProcess4.state = "HIDE"
        gpuTemp1.state    = "HIDE"
        gpuTemp2.state    = "HIDE"
        gpuTemp3.state    = "HIDE"
        gpuTemp4.state    = "HIDE"
        }else{
            cpuGpuRamBox.state= "SHOW"
            gpuProcess1.state = "SHOW"
            gpuProcess2.state = "SHOW"
            gpuProcess3.state = "SHOW"
            gpuProcess4.state = "SHOW"
            gpuTemp1.state    = "SHOW"
            gpuTemp2.state    = "SHOW"
            gpuTemp3.state    = "SHOW"
            gpuTemp4.state    = "SHOW"
        }
    }
}
