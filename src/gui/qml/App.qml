import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1000
    height: 650
    title: "Tavernity"

    property string token: ""
    property string currentPage: "pages/Login.qml"

    Loader {
        id: pageLoader
        anchors.fill: parent
        source: window.currentPage

        onLoaded: {
            if (item) {
                item.host = window
            }
        }
    }
}