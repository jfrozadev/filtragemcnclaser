// ============================================================
// PRINT: SNAP-FIT CLIPS — 16 unidades (tampa + base)
// Mesa: ~92mm × 45mm — cabe na Ender 3 (200×200mm) ✓
// ============================================================
// Snap-fit: ponte na mesa (Z=0), pernas para cima
// 8× tampa (topo) + 8× base (inferior)
// Infill recomendado: 80% (precisa ser resistente)
// ============================================================
// Clips de retenção de filtro estão em arquivos separados:
//   PRINT_CLIP_MANTA.scad — 8× braço 13mm
//   PRINT_CLIP_GM.scad    — 8× braço 23mm
//   PRINT_CLIP_WEGA.scad  — 4× braço 13mm
//   PRINT_CLIP_HEPA.scad  — 8× braço 5mm
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;

// === SEÇÃO 1: 16 SNAP-FIT CLIPS (tampa + base) ===
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
