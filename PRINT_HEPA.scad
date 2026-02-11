// ============================================================
// PRINT: TRILHOS HEPA (Posição 4 — X=155mm)
// 4 peças idênticas — canal 26mm (filtro 25mm + folga)
// Mesa: 132mm × 122mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~1h30
// ============================================================
// 1 filtro × 2 laterais × 2 metades = 4 peças
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;
canal = 26;
largura = canal + 2*2; // 30mm

// 4 peças lado a lado em X
for (i = [0:3]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
