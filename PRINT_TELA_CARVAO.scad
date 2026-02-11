// ============================================================
// PRINT: TRILHOS TELA CARVÃO (Posições 5 e 6)
// 8 peças idênticas — canal 3.4mm (MDF 3mm + 0.4mm folga)
// Mesa: 83mm × 122mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~50min
// ============================================================
// 2 filtros × 2 laterais × 2 metades = 8 peças
// Todas idênticas (junta reta, sem dovetail)
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;
canal = 3.4;
largura = canal + 2*2; // 7.4mm

// 8 peças lado a lado em X
for (i = [0:7]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
