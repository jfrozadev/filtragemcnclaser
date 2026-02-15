// ============================================================
// PRINT: CLIPS DE FIXAÇÃO — 44 unidades
// 16× snap-fit (tampa + base) + 28× retenção filtro (divisórias)
// Mesa: ~184mm × 135mm — cabe na Ender 3 (200×200mm) ✓
// Tempo estimado: ~5h30
// ============================================================
// Snap-fit: ponte na mesa (Z=0), pernas para cima
// Retenção: base na mesa (Z=0), braço+aba para cima
//   8× Manta G3  → braço 13mm (espessura filtro 10mm)
//   8× GM Cabine → braço 23mm (espessura filtro 20mm)
//   4× Wega      → braço 13mm (espessura filtro 10mm, só topo/base)
//   8× HEPA      → braço 28mm (espessura filtro 25mm)
// Infill recomendado: 80% (precisa ser resistente)
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

// === SEÇÃO 2: 28 CLIPS RETENÇÃO FILTRO (divisórias) ===
// Agrupados por espessura do filtro (3 tamanhos de braço)
ret_w = 20;       // largura X do clip retenção
ret_d = 15;       // profundidade Y do clip retenção
ret_offset_y = 4 * (clip_d + gap) + 10;  // Espaçamento entre seções

// --- Grupo A: 12× clips braço 13mm (8 Manta + 4 Wega) ---
// 4 colunas × 3 fileiras = 12 clips
for (row = [0:2]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), ret_offset_y + row * (ret_d + gap), 0])
            clip_manta();  // mesmo que clip_wega() — braço 13mm
    }
}

// --- Grupo B: 8× clips braço 23mm (GM Cabine) ---
// 4 colunas × 2 fileiras = 8 clips
grp_b_y = ret_offset_y + 3 * (ret_d + gap) + 5;
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), grp_b_y + row * (ret_d + gap), 0])
            clip_gm();
    }
}

// --- Grupo C: 8× clips braço 28mm (HEPA) ---
// 4 colunas × 2 fileiras = 8 clips
grp_c_y = grp_b_y + 2 * (ret_d + gap) + 5;
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), grp_c_y + row * (ret_d + gap), 0])
            clip_hepa();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
