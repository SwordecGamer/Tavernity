from dataclasses import dataclass
from typing import Optional

@dataclass(frozen=True)
class AuthResult:
    success: bool
    message: str = ""
    access_token: Optional[str] = None

class AuthService:
    def login(self, username: str, password: str) -> AuthResult:
        username = (username or "").strip()
        password = password or ""

        if not username or not password:
            return AuthResult(success=False, message="Username and password are required.")
        
        if username == "admin" and password == "password":
            return AuthResult(success=True, access_token="fake_token_12345")
        
        return AuthResult(success=False, message="Invalid username or password.")