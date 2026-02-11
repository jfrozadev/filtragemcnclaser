// ============================================================
// PRINT: TRILHOS GM CABINE (Posição 2 — X=75mm)
// 4 peças idênticas — canal 21mm (filtro 20mm + folga)
// Mesa: 112mm × 122mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~1h20
// ============================================================
// 1 filtro × 2 laterais × 2 metades = 4 peças
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;
canal = 21;
largura = canal + 2*2; // 25mm

// 4 peças lado a lado em X
for (i = [0:3]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
