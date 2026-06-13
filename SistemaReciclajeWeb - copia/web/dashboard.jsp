<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.dto.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - ReciclaMas</title>
    <%@include file="estilos.jsp" %>
</head>
<body>
    <%@include file="sidebar.jsp" %>
    <main class="rm-main">
        <div class="rm-page-header">
            <h1 class="rm-page-title">¡Bienvenido, <%= user.getNombre().split(" ")[0] %>! 👋</h1>
            <p class="rm-page-subtitle">Aquí tienes un resumen de tu actividad ecológica</p>
        </div>

        <div class="rm-stats-grid">
            <div class="rm-stat-card">
                <div class="rm-stat-icon">⭐</div>
                <div>
                    <div class="rm-stat-value"><%= user.getPuntosTotal() %></div>
                    <div class="rm-stat-label">Puntos Acumulados</div>
                </div>
            </div>
            <div class="rm-stat-card">
                <div class="rm-stat-icon naranja">♻</div>
                <div>
                    <div class="rm-stat-value">0</div>
                    <div class="rm-stat-label">Reciclajes este mes</div>
                </div>
            </div>
            <div class="rm-stat-card">
                <div class="rm-stat-icon azul">🌍</div>
                <div>
                    <div class="rm-stat-value"><%= (int)(user.getPuntosTotal() * 0.05) %> g</div>
                    <div class="rm-stat-label">CO₂ Reducido (est.)</div>
                </div>
            </div>
            <div class="rm-stat-card">
                <div class="rm-stat-icon morado">🏅</div>
                <div>
                    <div class="rm-stat-value">
                        <% int pts = user.getPuntosTotal();
                           if (pts >= 500) out.print("Oro");
                           else if (pts >= 200) out.print("Plata");
                           else if (pts >= 50) out.print("Bronce");
                           else out.print("Inicio"); %>
                    </div>
                    <div class="rm-stat-label">Tu Nivel Actual</div>
                </div>
            </div>
        </div>

        <div class="rm-card" style="margin-bottom: 1.75rem;">
            <h2 style="font-size:1.05rem; font-weight:700; margin-bottom:1.25rem; color:#2D3748;">Accesos Rápidos</h2>
            <div class="rm-shortcuts-grid">
                <a href="ControladorReciclaje?accion=formulario" class="rm-shortcut-card">
                    <span class="rm-shortcut-icon">♻</span>
                    <span class="rm-shortcut-title">Registrar Reciclaje</span>
                    <span class="rm-shortcut-desc">Registra tu aporte y suma puntos al instante</span>
                </a>
                <a href="ControladorRanking" class="rm-shortcut-card">
                    <span class="rm-shortcut-icon">🏆</span>
                    <span class="rm-shortcut-title">Ver Ranking</span>
                    <span class="rm-shortcut-desc">Mira tu posición entre los vecinos de la comunidad</span>
                </a>
                <a href="ControladorRecompensa" class="rm-shortcut-card">
                    <span class="rm-shortcut-icon">🎁</span>
                    <span class="rm-shortcut-title">Canjear Recompensas</span>
                    <span class="rm-shortcut-desc">Usa tus puntos para obtener premios ecológicos</span>
                </a>
                <a href="ControladorReciclaje?accion=historial" class="rm-shortcut-card">
                    <span class="rm-shortcut-icon">📋</span>
                    <span class="rm-shortcut-title">Mi Historial</span>
                    <span class="rm-shortcut-desc">Revisa todos tus reciclajes registrados</span>
                </a>
            </div>
        </div>

        <div class="rm-card">
            <h2 style="font-size:1.05rem; font-weight:700; margin-bottom:1.25rem; color:#2D3748;">📊 Tabla de Puntos por Material</h2>
            <div class="rm-table-wrapper">
                <table class="rm-table">
                    <thead><tr><th>Material</th><th>Puntos por Kg</th><th>Equivalencia</th></tr></thead>
                    <tbody>
                        <tr><td>🧴 Plástico</td><td><span class="rm-pts-badge">10 pts/kg</span></td><td>10 kg = 100 puntos</td></tr>
                        <tr><td>📦 Cartón</td><td><span class="rm-pts-badge">5 pts/kg</span></td><td>10 kg = 50 puntos</td></tr>
                        <tr><td>🍶 Vidrio</td><td><span class="rm-pts-badge">8 pts/kg</span></td><td>10 kg = 80 puntos</td></tr>
                        <tr><td>🔩 Metal</td><td><span class="rm-pts-badge">15 pts/kg</span></td><td>10 kg = 150 puntos</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>