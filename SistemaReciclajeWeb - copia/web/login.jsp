<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReciclaMas - Iniciar Sesión</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #176B4E 0%, #1E825F 60%, #2da876 100%);
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center; padding: 1rem;
        }
        .login-wrapper {
            display: flex; width: 100%; max-width: 900px; min-height: 520px;
            background: #fff; border-radius: 20px; overflow: hidden;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }
        .login-panel-left {
            flex: 1;
            background: linear-gradient(160deg, #176B4E, #2da876);
            padding: 3rem; display: flex; flex-direction: column;
            justify-content: center; color: white;
        }
        .login-brand { font-size: 2.2rem; font-weight: 800; margin-bottom: 0.5rem; }
        .login-tagline { font-size: 1rem; opacity: 0.85; margin-bottom: 2.5rem; line-height: 1.6; }
        .login-feature { display: flex; align-items: center; gap: 12px; margin-bottom: 1rem; font-size: 0.9rem; opacity: 0.9; }
        .login-feature-icon {
            width: 36px; height: 36px; border-radius: 8px;
            background: rgba(255,255,255,0.15);
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; flex-shrink: 0;
        }
        .login-panel-right { width: 400px; padding: 3rem 2.5rem; display: flex; flex-direction: column; justify-content: center; }
        .login-title { font-size: 1.6rem; font-weight: 700; color: #2D3748; margin-bottom: 0.4rem; }
        .login-subtitle { color: #718096; font-size: 0.9rem; margin-bottom: 2rem; }
        .form-group { margin-bottom: 1.25rem; }
        .form-label { display: block; font-weight: 500; font-size: 0.85rem; color: #4A5568; margin-bottom: 0.5rem; }
        .form-input {
            width: 100%; padding: 0.75rem 1rem;
            border: 1.5px solid #E2E8F0; border-radius: 8px;
            font-size: 0.95rem; font-family: 'Inter', sans-serif;
            color: #2D3748; background: #F8FAFC; transition: all 0.2s;
        }
        .form-input:focus { outline: none; border-color: #176B4E; background: #fff; box-shadow: 0 0 0 3px rgba(23,107,78,0.1); }
        .btn-login {
            width: 100%; padding: 0.85rem; background: #176B4E; color: white;
            border: none; border-radius: 8px; font-size: 1rem; font-weight: 600;
            cursor: pointer; font-family: 'Inter', sans-serif; transition: background 0.2s; margin-top: 0.5rem;
        }
        .btn-login:hover { background: #1E825F; }
        .alert-error {
            background: #FED7D7; border-left: 4px solid #E53E3E;
            color: #742A2A; padding: 0.75rem 1rem; border-radius: 8px;
            font-size: 0.88rem; margin-bottom: 1.25rem; font-weight: 500;
        }
        .alert-success {
            background: #C6F6D5; border-left: 4px solid #38A169;
            color: #22543D; padding: 0.75rem 1rem; border-radius: 8px;
            font-size: 0.88rem; margin-bottom: 1.25rem; font-weight: 500;
        }
        .login-footer { margin-top: 1.5rem; text-align: center; font-size: 0.88rem; color: #718096; }
        .login-footer a { color: #176B4E; font-weight: 600; text-decoration: none; }
    </style>
</head>
<body>
<div class="login-wrapper">
    <div class="login-panel-left">
        <div class="login-brand">♻ ReciclaMas</div>
        <p class="login-tagline">Recicla, acumula puntos y gana recompensas mientras cuidas tu comunidad.</p>
        <div class="login-feature">
            <div class="login-feature-icon">♻</div>
            <span>Registra tu reciclaje y gana puntos automáticamente</span>
        </div>
        <div class="login-feature">
            <div class="login-feature-icon">🏆</div>
            <span>Compite en el ranking vecinal mensual</span>
        </div>
        <div class="login-feature">
            <div class="login-feature-icon">🎁</div>
            <span>Canjea tus puntos por recompensas ecológicas</span>
        </div>
    </div>
    <div class="login-panel-right">
        <h1 class="login-title">Bienvenido de vuelta</h1>
        <p class="login-subtitle">Ingresa tus datos para continuar</p>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert-error">⚠ <%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("exito") != null) { %>
            <div class="alert-success">✓ <%= request.getAttribute("exito") %></div>
        <% } %>
        <form action="ControladorUsuario" method="POST">
            <input type="hidden" name="accion" value="login">
            <div class="form-group">
                <label class="form-label">Correo Electrónico</label>
                <input class="form-input" type="email" name="email" required placeholder="tu@email.com">
            </div>
            <div class="form-group">
                <label class="form-label">Contraseña</label>
                <input class="form-input" type="password" name="password" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn-login">Iniciar Sesión</button>
        </form>
        <div class="login-footer">
            ¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a>
        </div>
    </div>
</div>
</body>
</html>