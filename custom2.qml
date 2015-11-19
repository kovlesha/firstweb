import QtQuick 2.2

import QGroundControl.Controls 1.0
import QGroundControl.FactSystem 1.0
import QGroundControl.FactControls 1.0
import QGroundControl.Controllers 1.0
import QtQuick.Controls 1.2
//import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.3

Rectangle
{

    //property int CurentValue: 0

    function fun (x,max)
    {
        if (x>0){
            outStatus1.x= 100;
            outStatus1.width= x*100/max;
            outStatus1.color= "green";
        }
        else if (x<0){
            outStatus1.x= 100-x*100/max*(-1);
            outStatus1.width= x*100/max*(-1);
            outStatus1.color= "red";
        }
    }
    id:root
    color: "#222222"

    property string m_OutText: "value"
    Column
    {
        id:col1
        anchors.fill: parent
        opacity: 15
        FactComboBox{
            id:comBox
            width: 200
            model: [ "Выберите значение", "Roll", "Yaw", "Pitch","LocalZ","Longitude", "BatterySpecs"]
            onActivated:
                m_Timer.running = true;
        }
        Timer{
            id: m_Timer
            interval: 100; running: false; repeat: true
            onTriggered:{
                    if (comBox.currentIndex == 1){
                        outText.text= controller.m_getRoll();
                        root.fun(controller.m_getRoll(),3.14);
                    }
                    else if (comBox.currentIndex == 2){
                        outText.text= controller.m_getYaw();
                        root.fun(controller.m_getYaw(),3.14);
                    }
                    else if (comBox.currentIndex == 3){
                        outText.text= controller.m_getPitch();
                        root.fun(controller.m_getPitch(),3.14);
                    }
                    else if (comBox.currentIndex == 4){
                        outText.text= controller.m_LocalZ();
                        root.fun(controller.m_LocalZ(),3.14);
                    }
                    else if (comBox.currentIndex == 5){
                        outText.text= controller.m_Longitude();
                        root.fun(controller.m_Longitude(),3.14);
                    }
					else if (comBox.currentIndex == 6){
                        outText.text= controller.m_getBatterySpecs();
                        //root.fun(controller.m_Longitude(),3.14);
                    }
                    else outText.text= "Ничего не выбрано!";
                    }
            }

        Rectangle
        {
            id:outTextRec
            width: 200
            height: 50

            Text{
                anchors.centerIn: parent
                id:outText
                text: m_OutText
                color: "black"
                font.pixelSize: 18

            }
        }
    }
    Rectangle
        {
            id:outStatus
            width: 200
            height: 75
            x: 210
            y:0
            color: "#626264"
            Rectangle{
                id: outStatus1
                y: 0
                height: 75
                width: 0
            }
        }

}
