// Usuarios que pueden iniciar sesión en la app.
// (No hay servidor: las cuentas viven aquí, en el código)
class Auth {
  // correo : contraseña
  static const Map<String, String> _users = {
    'cliente@donutapp.com': 'donas123',
    'admin@donutapp.com': 'admin123',
  };

  // Regresa true si el correo existe y la contraseña coincide
  static bool login(String email, String password) {
    return _users[email.trim().toLowerCase()] == password;
  }
}
