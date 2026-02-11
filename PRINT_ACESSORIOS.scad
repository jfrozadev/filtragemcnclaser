// ============================================================
// PRINT: ACESSÓRIOS — Puxadores + Travas
// 6× puxadores (30×7.4×17mm) + 6× travas (10×2.2×8mm)
// Mesa: ~200mm × 33mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~45min
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;

// 6 puxadores em 2 fileiras de 3
for (i = [0:2]) {
    translate([i * 35, 0, 0])
        puxador();
}
for (i = [0:2]) {
    translate([i * 35, 25, 0])
        puxador();
}

// 6 travas ao lado dos puxadores
for (i = [0:5]) {
    translate([110 + i * 15, 0, 0])
        trava();
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
