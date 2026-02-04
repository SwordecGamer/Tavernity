from PySide6.QtCore import QObject, Slot, Signal, Property

from services.auth_service import AuthService

class LoginController(QObject):
    busyChanged = Signal()
    errorChanged = Signal()
    loginSuccess = Signal(str, str)

    def __init__(self, auth_service: AuthService, parent=None):
        super().__init__(parent)
        self._auth = auth_service
        self._busy = False
        self._error = ""

    def get_busy(self) -> bool:
        return self._busy
    
    def set_busy(self, value: bool) -> None:
        if self._busy == value:
            return
        self._busy = value
        self.busyChanged.emit()

    busy = Property(bool, get_busy, set_busy, notify=busyChanged)

    def get_error(self) -> str:
        return self._error
    
    def set_error(self, value:str) -> None:
        if self._error == value:
            return
        self._error = value
        self.errorChanged.emit()

    error = Property(str, get_error, set_error, notify=errorChanged)

    @Slot(str, str)
    def login(self, username:str, password:str) -> None:
        self.error = ""
        self.busy = True

        result = self._auth.login(username, password)

        self.busy = False

        if result.success and result.access_token:
            self.loginSuccess.emit(result.access_token, username)
        else:
            self.error = result.message or "Login failed. Please try again."