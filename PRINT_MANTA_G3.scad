// ============================================================
// PRINT: TRILHOS MANTA G3 (Posição 1 — X=50mm)
// 4 peças idênticas — canal 17mm (MDF 3 + clips 3.5 + manta 10 + folga)
// Mesa: 88mm × 122mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~1h
// ============================================================
// 1 filtro × 2 laterais × 2 metades = 4 peças
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;
canal = 17;
largura = canal + 2*2; // 21mm

// 4 peças lado a lado em X
for (i = [0:3]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
