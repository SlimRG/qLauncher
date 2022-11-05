import QtQuick
import QtQuick 2.15
import QtQuick.Controls.Material 2.3

import Custom

Window {
    id: mainWindow
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"

    //property int themeMode: PlatformToolsQML.themeMode
    property int titleHeight: PlatformToolsQML.captionHeight

    width: PlatformToolsQML.getFrameSize.x
    height: PlatformToolsQML.getFrameSize.y

    minimumWidth: PlatformToolsQML.getFrameMinSize.x
    minimumHeight: PlatformToolsQML.getFrameMinSize.y

    property color colorActiveWindow: PlatformToolsQML.colorActiveWindow
    property color colorBorderWindow: PlatformToolsQML.colorBorderWindow

    property int cornerRadiusTopLevel: PlatformToolsQML.cornerRadiusTopLevel
    property int borderWidthWindow: PlatformToolsQML.borderWidthWindow

    property bool isFullScreen: (mainWindow.visibility === Window.FullScreen)

    property point startMousePos
    property point startWindowPos
    property size startWindowSize

    function absoluteMousePos(mouseArea) {
        var windowAbs = mouseArea.mapToItem(null, mouseArea.mouseX, mouseArea.mouseY)
        return Qt.point(windowAbs.x + mainWindow.x,
                        windowAbs.y + mainWindow.y)
    }

    MouseArea {
        id: leftArea
        anchors.top: parent.top
        anchors.topMargin: 30 * 1.5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        cursorShape: Qt.SizeHorCursor
        width: 5
        visible: (mainWindow.visibility != Window.FullScreen)
        onPressed: {
            startMousePos = absoluteMousePos(leftArea)
            startWindowPos = Qt.point(mainWindow.x, mainWindow.y)
            startWindowSize = Qt.size(mainWindow.width, mainWindow.height)
        }
        onPositionChanged: {
            var abs = absoluteMousePos(leftArea)
            var newWidth = Math.max(mainWindow.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
            var newX = startWindowPos.x - (newWidth - startWindowSize.width)
            mainWindow.x = newX
            mainWindow.width = newWidth
        }
    }

    MouseArea {
        id: rightArea
        width: 5
        x: parent.width - rightArea.width
        anchors.right: parent.rigth
        anchors.top: parent.top
        anchors.rightMargin: 5
        anchors.topMargin: 48
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        cursorShape: Qt.SizeHorCursor

        visible: (mainWindow.visibility != Window.FullScreen)

        onPressed: {
            startMousePos = absoluteMousePos(rightArea)
            startWindowPos = Qt.point(mainWindow.x, mainWindow.y)
            startWindowSize = Qt.size(mainWindow.width, mainWindow.height)
        }
        onPositionChanged: {
            var abs = absoluteMousePos(rightArea)
            var newWidth = Math.max(mainWindow.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
            mainWindow.width = newWidth
        }
    }

    MouseArea {
        id: leftCorArea
        width: 5
        height: 5
        anchors.left: parent.left
        y: parent.height - leftCorArea.height
        cursorShape: Qt.SizeBDiagCursor

        visible: (mainWindow.visibility != Window.FullScreen)

        onPressed: {
            startMousePos = absoluteMousePos(leftCorArea)
            startWindowPos = Qt.point(mainWindow.x, mainWindow.y)
            startWindowSize = Qt.size(mainWindow.width, mainWindow.height)
        }

        onPositionChanged: {
            var abs = absoluteMousePos(leftCorArea)
            var newWidth = Math.max(mainWindow.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
            var newHeight = Math.max(mainWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            var newX = startWindowPos.x - (newWidth - startWindowSize.width)
            mainWindow.setGeometry(newX, mainWindow.y, newWidth, newHeight)
        }
    }

    MouseArea {
        id: rigthCorArea
        width: 5
        height: 5
        y: parent.height - rigthCorArea.height
        x: parent.width - rigthCorArea.width
        cursorShape: Qt.SizeFDiagCursor

        visible: (mainWindow.visibility != Window.FullScreen)

        onPressed: {
            startMousePos = absoluteMousePos(rigthCorArea)
            startWindowPos = Qt.point(mainWindow.x, mainWindow.y)
            startWindowSize = Qt.size(mainWindow.width, mainWindow.height)
        }

        onPositionChanged: {
            var abs = absoluteMousePos(rigthCorArea)
            var newWidth = Math.max(mainWindow.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
            var newHeight = Math.max(mainWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            mainWindow.setGeometry(mainWindow.x, mainWindow.y, newWidth, newHeight)
        }
    }

    MouseArea {
        id: buttonArea
        y: parent.height - buttonArea.height
        height: 5
        anchors.leftMargin: 5
        anchors.left: parent.left
        anchors.rightMargin: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeVerCursor

        visible: (mainWindow.visibility != Window.FullScreen)

        onPressed: {
            startMousePos = absoluteMousePos(buttonArea)
            startWindowPos = Qt.point(mainWindow.x, mainWindow.y)
            startWindowSize = Qt.size(mainWindow.width, mainWindow.height)
        }
        onPositionChanged: {
            var abs = absoluteMousePos(buttonArea)
            var newHeight = Math.max(mainWindow.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            mainWindow.height = newHeight
        }
    }

}
