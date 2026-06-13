<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.dto.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    // CORRECCIÓN: atributo "ranking" (no "usuariosRanking")
    List<Usuario> listaRanking = (List<Usuario>) request.getAttribute("ranking");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ranking Vecinal - ReciclaMas</title>
    <%@include file="estilos.jsp" %>
</head>
<body>
    <%@include file="sidebar.jsp" %>
    <main class="rm-main">
        <div class="rm-page-header">
            <h1 class="rm-page-title">🏆 Ranking Vecinal</h1>
            <p class="rm-page-subtitle">Los 10 vecinos con mayor impacto ecológico</p>
        </div>

        <% if (listaRanking != null && listaRanking.size() >= 3) { %>
        <div style="display:flex; gap:1rem; margin-bottom:1.75rem; align-items:flex-end; flex-wrap:wrap;">
            <div class="rm-card" style="flex:1; min-width:160px; text-align:center; padding:1.5rem 1rem; border-top:4px solid #A0AEC0;">
                <div style="font-size:2rem; margin-bottom:0.5rem;">🥈</div>
                <div style="font-weight:700; font-size:0.95rem; margin-bottom:4px;"><%= listaRanking.get(1).getNombre().split(" ")[0] %></div>
                <div class="rm-pts-badge"><%= listaRanking.get(1).getPuntosTotal() %> pts</div>
                <div style="font-size:0.78rem; color:#718096; margin-top:6px;">2° Lugar</div>
            </div>
            <div class="rm-card" style="flex:1; min-width:180px; text-align:center; padding:2rem 1rem; border-top:5px solid #F6E05E; transform:translateY(-10px);">
                <div style="font-size:2.5rem; margin-bottom:0.5rem;">🥇</div>
                <div style="font-weight:700; font-size:1.05rem; margin-bottom:4px;"><%= listaRanking.get(0).getNombre().split(" ")[0] %></div>
                <div class="rm-pts-badge"><%= listaRanking.get(0).getPuntosTotal() %> pts</div>
                <div style="font-size:0.78rem; color:#718096; margin-top:6px;">🌟 Líder del mes</div>
            </div>
            <div class="rm-card" style="flex:1; min-width:160px; text-align:center; padding:1.5rem 1rem; border-top:4px solid #DD6B20;">
                <div style="font-size:2rem; margin-bottom:0.5rem;">🥉</div>
                <div style="font-weight:700; font-size:0.95rem; margin-bottom:4px;"><%= listaRanking.get(2).getNombre().split(" ")[0] %></div>
                <div class="rm-pts-badge"><%= listaRanking.get(2).getPuntosTotal() %> pts</div>
                <div style="font-size:0.78rem; color:#718096; margin-top:6px;">3° Lugar</div>
            </div>
        </div>
        <% } %>

        <div class="rm-card">
            <h2 style="font-size:1rem; font-weight:700; margin-bottom:1.25rem; color:#2D3748;">Tabla General Top 10</h2>
            <% if (listaRanking != null && !listaRanking.isEmpty()) { %>
            <div class="rm-table-wrapper">
                <table class="rm-table">
                    <thead>
                        <tr><th style="width:80px;">Puesto</th><th>Nombre del Vecino</th><th style="width:180px;">Puntos</th></tr>
                    </thead>
                    <tbody>
                        <% int pos = 1;
                           for (Usuario u : listaRanking) {
                               String rowClass = "";
                               String badgeClass = "normal";
                               String medal = "#" + pos;
                               if (pos == 1) { rowClass = "rm-rank-gold";   badgeClass = "gold";   medal = "🥇"; }
                               if (pos == 2) { rowClass = "rm-rank-silver"; badgeClass = "silver"; medal = "🥈"; }
                               if (pos == 3) { rowClass = "rm-rank-bronze"; badgeClass = "bronze"; medal = "🥉"; }
                               if (u.getId() == user.getId()) rowClass = "rm-rank-gold"; %>
                        <tr class="<%= rowClass %>">
                            <td><span class="rm-rank-badge <%= badgeClass %>"><%= medal %></span></td>
                            <td style="font-weight:<%= pos<=3 ? "700" : "400" %>;">
                                <%= u.getNombre() %>
                                <% if (u.getId() == user.getId()) { %>
                                    <span style="font-size:0.75rem; background:#EAF4F0; color:#176B4E; padding:2px 8px; border-radius:10px; margin-left:8px; font-weight:600;">Tú</span>
                                <% } %>
                            </td>
                            <td><span class="rm-pts-badge"><%= u.getPuntosTotal() %> pts</span></td>
                        </tr>
                        <% pos++; } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="rm-empty">
                <div class="rm-empty-icon">🏆</div>
                <h3>Aún no hay datos en el ranking</h3>
                <p>¡Sé el primero en registrar un reciclaje!</p>
                <a href="ControladorReciclaje?accion=formulario" class="rm-btn-secondary">♻ Registrar reciclaje</a>
            </div>
            <% } %>
        </div>
    </main>
</body>
</html>