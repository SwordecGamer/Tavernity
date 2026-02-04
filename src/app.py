import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QCoreApplication

from services.auth_service import AuthService
from gui.controllers.login_controller import LoginController
from services.server_store import ServerStore
from gui.controllers.server_controller import ServerController

class App():
    def __init__(self):
        self.enigne = None

    def run(self):
        QCoreApplication.setOrganizationName("Tavernity Studio")
        QCoreApplication.setApplicationName("Tavernity")
        app = QGuiApplication(sys.argv)
        self._engine = QQmlApplicationEngine()

        auth_service = AuthService()
        login_controller = LoginController(auth_service)

        server_store = ServerStore()
        print("Server data stored at:", server_store.file_path)
        server_controller = ServerController(server_store)

        self._engine.rootContext().setContextProperty("loginController", login_controller)
        self._engine.rootContext().setContextProperty("serverController", server_controller)
        
        qml_path = Path(__file__).resolve().parent / "gui" / "qml" / "App.qml"
        self._engine.load(str(qml_path))

        if not self._engine.rootObjects():
            print("Error: No root objects found in QML file.")
            return 1
        
        return app.exec()