// ============================================================
// PRINT: SNAP-FIT CLIPS — 16 unidades
// Clips de fixação para tampa e base da caixa
// Mesa: 92mm × 48mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~2h
// ============================================================
// Orientação: ponte na mesa (Z=0), pernas para cima
// Infill recomendado: 80% (precisa ser resistente)
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
clip_w = 20;     // largura X
clip_d = 8.3;    // profundidade Y
parede = 2;      // espessura ponte

// 4 colunas × 4 fileiras = 16 clips
for (row = [0:3]) {
    for (col = [0:3]) {
        translate([col * (clip_w + gap), row * (clip_d + gap), 0])
        // Orientação: ponte na mesa, pernas para cima
        translate([0, clip_d, parede])
        rotate([180, 0, 0])
            snap_clip_tampa();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
