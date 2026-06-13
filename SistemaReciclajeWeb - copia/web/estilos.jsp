<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
:root {
    --verde-primario:  #176B4E;
    --verde-hover:     #1E825F;
    --verde-claro:     #EAF4F0;
    --verde-badge:     #D4EDDA;
    --fondo:           #F0F4F2;
    --blanco:          #FFFFFF;
    --texto:           #2D3748;
    --texto-suave:     #718096;
    --borde:           #E2E8F0;
    --sombra:          0 4px 12px rgba(0,0,0,0.07);
    --radio:           12px;
    --rojo:            #E53E3E;
    --rojo-claro:      #FFF5F5;
    --amarillo:        #F6E05E;
    --amarillo-claro:  #FFFFF0;
}

* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    font-family: 'Inter', sans-serif;
    background-color: var(--fondo);
    color: var(--texto);
    display: flex;
    min-height: 100vh;
}

.rm-sidebar {
    width: 270px;
    min-width: 270px;
    background: var(--blanco);
    border-right: 1px solid var(--borde);
    display: flex;
    flex-direction: column;
    padding: 1.5rem 1.25rem;
    min-height: 100vh;
    position: sticky;
    top: 0;
}

.rm-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 1.4rem;
    font-weight: 700;
    color: var(--verde-primario);
    margin-bottom: 1.5rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid var(--borde);
}
.rm-brand-icon { font-size: 1.6rem; }

.rm-user-card {
    display: flex;
    align-items: center;
    gap: 12px;
    background: var(--verde-claro);
    border-radius: var(--radio);
    padding: 0.85rem 1rem;
    margin-bottom: 1.5rem;
}
.rm-user-avatar {
    width: 42px; height: 42px;
    background: var(--verde-primario);
    color: white;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 1.1rem;
    flex-shrink: 0;
}
.rm-user-info { display: flex; flex-direction: column; overflow: hidden; }
.rm-user-name {
    font-weight: 600;
    font-size: 0.88rem;
    color: var(--texto);
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.rm-user-pts {
    font-size: 0.8rem;
    color: var(--verde-hover);
    font-weight: 600;
    margin-top: 2px;
}

.rm-nav { display: flex; flex-direction: column; gap: 4px; flex: 1; }
.rm-nav-link {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    color: var(--texto-suave);
    padding: 0.7rem 1rem;
    border-radius: 8px;
    font-weight: 500;
    font-size: 0.9rem;
    transition: all 0.2s;
}
.rm-nav-link:hover { background: var(--verde-claro); color: var(--verde-primario); }
.rm-nav-link.active { background: var(--verde-claro); color: var(--verde-primario); font-weight: 600; }
.rm-nav-icon { font-size: 1.1rem; width: 22px; text-align: center; }

.rm-sidebar-footer { margin-top: auto; padding-top: 1.5rem; border-top: 1px solid var(--borde); }
.rm-logout-btn {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    color: var(--rojo);
    padding: 0.7rem 1rem;
    border-radius: 8px;
    font-weight: 500;
    font-size: 0.9rem;
    transition: background 0.2s;
}
.rm-logout-btn:hover { background: var(--rojo-claro); }

.rm-main {
    flex: 1;
    padding: 2.5rem 2.5rem;
    overflow-y: auto;
    min-height: 100vh;
}
.rm-page-header { margin-bottom: 2rem; }
.rm-page-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: var(--texto);
    margin-bottom: 4px;
}
.rm-page-subtitle { color: var(--texto-suave); font-size: 0.95rem; }

.rm-card {
    background: var(--blanco);
    border-radius: var(--radio);
    box-shadow: var(--sombra);
    padding: 1.75rem;
}
.rm-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.25rem;
    margin-bottom: 1.75rem;
}
.rm-stat-card {
    background: var(--blanco);
    border-radius: var(--radio);
    box-shadow: var(--sombra);
    padding: 1.5rem;
    display: flex;
    align-items: center;
    gap: 1rem;
}
.rm-stat-icon {
    width: 52px; height: 52px;
    border-radius: 12px;
    background: var(--verde-claro);
    display: flex; align-items: center; justify-content: center;
    font-size: 1.5rem;
    flex-shrink: 0;
}
.rm-stat-icon.naranja { background: #FFF3E0; }
.rm-stat-icon.azul { background: #E3F2FD; }
.rm-stat-icon.morado { background: #F3E5F5; }
.rm-stat-value { font-size: 1.6rem; font-weight: 700; color: var(--texto); line-height: 1; }
.rm-stat-label { font-size: 0.8rem; color: var(--texto-suave); margin-top: 4px; }

.rm-shortcuts-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
    gap: 1.25rem;
    margin-bottom: 1.75rem;
}
.rm-shortcut-card {
    background: var(--blanco);
    border-radius: var(--radio);
    box-shadow: var(--sombra);
    padding: 1.5rem;
    text-decoration: none;
    color: var(--texto);
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
    border: 2px solid transparent;
    transition: all 0.2s;
}
.rm-shortcut-card:hover { border-color: var(--verde-primario); transform: translateY(-2px); }
.rm-shortcut-icon { font-size: 2rem; }
.rm-shortcut-title { font-weight: 600; font-size: 0.95rem; }
.rm-shortcut-desc { font-size: 0.82rem; color: var(--texto-suave); }

.rm-alert {
    padding: 0.9rem 1.2rem;
    border-radius: 8px;
    margin-bottom: 1.5rem;
    font-weight: 500;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 10px;
}
.rm-alert-success { background: #C6F6D5; color: #22543D; border-left: 4px solid #38A169; }
.rm-alert-error   { background: #FED7D7; color: #742A2A; border-left: 4px solid #E53E3E; }
.rm-alert-info    { background: #BEE3F8; color: #2A4365; border-left: 4px solid #3182CE; }

.rm-form-group { margin-bottom: 1.4rem; }
.rm-label {
    display: block;
    font-weight: 500;
    font-size: 0.88rem;
    color: #4A5568;
    margin-bottom: 0.5rem;
}
.rm-input, .rm-select {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1.5px solid var(--borde);
    border-radius: 8px;
    font-size: 0.95rem;
    font-family: 'Inter', sans-serif;
    color: var(--texto);
    background: var(--blanco);
    transition: border-color 0.2s, box-shadow 0.2s;
}
.rm-input:focus, .rm-select:focus {
    outline: none;
    border-color: var(--verde-primario);
    box-shadow: 0 0 0 3px rgba(23,107,78,0.12);
}
.rm-btn-primary {
    width: 100%;
    padding: 0.85rem;
    background: var(--verde-primario);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Inter', sans-serif;
    transition: background 0.2s, transform 0.1s;
    margin-top: 0.5rem;
}
.rm-btn-primary:hover { background: var(--verde-hover); transform: translateY(-1px); }

.rm-btn-secondary {
    padding: 0.65rem 1.25rem;
    background: var(--verde-claro);
    color: var(--verde-primario);
    border: none;
    border-radius: 8px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Inter', sans-serif;
    text-decoration: none;
    display: inline-block;
    transition: background 0.2s;
}
.rm-btn-secondary:hover { background: #c8e6da; }

.rm-btn-canje {
    width: 100%;
    padding: 0.65rem;
    background: var(--verde-primario);
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 0.88rem;
    font-weight: 600;
    cursor: pointer;
    font-family: 'Inter', sans-serif;
    transition: background 0.2s;
    margin-top: 0.75rem;
}
.rm-btn-canje:hover { background: var(--verde-hover); }
.rm-btn-canje:disabled {
    background: #CBD5E0;
    cursor: not-allowed;
}

.rm-table-wrapper {
    overflow-x: auto;
    border-radius: var(--radio);
}
.rm-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.9rem;
}
.rm-table thead tr { background: var(--verde-primario); }
.rm-table thead th {
    color: white;
    padding: 1rem 1.2rem;
    text-align: left;
    font-weight: 600;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
.rm-table tbody tr { border-bottom: 1px solid var(--borde); transition: background 0.15s; }
.rm-table tbody tr:hover { background: var(--verde-claro); }
.rm-table tbody td { padding: 1rem 1.2rem; color: var(--texto); }
.rm-table tbody tr:last-child { border-bottom: none; }

.rm-rank-gold   { background: #FFFDE7 !important; }
.rm-rank-silver { background: #F5F5F5 !important; }
.rm-rank-bronze { background: #FBE9E7 !important; }
.rm-rank-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 36px; height: 36px;
    border-radius: 50%;
    font-weight: 700;
    font-size: 0.95rem;
}
.rm-rank-badge.gold   { background: #F6E05E; color: #744210; }
.rm-rank-badge.silver { background: #CBD5E0; color: #2D3748; }
.rm-rank-badge.bronze { background: #FBD38D; color: #7B341E; }
.rm-rank-badge.normal { background: var(--fondo); color: var(--texto-suave); }

.rm-pts-badge {
    background: var(--verde-claro);
    color: var(--verde-primario);
    padding: 4px 12px;
    border-radius: 20px;
    font-weight: 700;
    font-size: 0.85rem;
}

.rm-rewards-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 1.25rem;
}
.rm-reward-card {
    background: var(--blanco);
    border-radius: var(--radio);
    box-shadow: var(--sombra);
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    border: 2px solid transparent;
    transition: border-color 0.2s, transform 0.2s;
}
.rm-reward-card:hover { border-color: var(--verde-primario); transform: translateY(-2px); }
.rm-reward-icon { font-size: 2.5rem; margin-bottom: 0.75rem; }
.rm-reward-name { font-weight: 700; font-size: 1rem; margin-bottom: 0.4rem; }
.rm-reward-desc { color: var(--texto-suave); font-size: 0.85rem; margin-bottom: 1rem; flex: 1; line-height: 1.5; }
.rm-reward-pts {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--verde-primario);
    margin-bottom: 0.25rem;
}
.rm-reward-stock { font-size: 0.78rem; color: var(--texto-suave); margin-bottom: 0.5rem; }

.rm-material-info {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
}
.rm-mat-pill {
    background: var(--verde-claro);
    color: var(--verde-primario);
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 0.82rem;
    font-weight: 600;
}

.rm-empty {
    text-align: center;
    padding: 3rem 1rem;
    color: var(--texto-suave);
}
.rm-empty-icon { font-size: 3rem; margin-bottom: 1rem; }
.rm-empty h3 { font-size: 1.1rem; margin-bottom: 0.5rem; color: var(--texto); }
.rm-empty p { font-size: 0.9rem; margin-bottom: 1.5rem; }
</style>