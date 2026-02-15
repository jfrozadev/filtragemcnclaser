// ============================================================
// PRINT: CLIPS MANTA G3 — 8 unidades
// Mesa: ~136mm × 33mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~45min
// Infill: 60% | Walls: 3 | Layer: 0.2mm
// ============================================================

use <CLIP_MANTA_G3.scad>

gap = 3;
clip_w = 30;

// 8 clips em 2 fileiras de 4
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (clip_w + gap), row * (18 + gap), 0])
            clip_manta();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
