// ============================================================
// PRINT: CLIPS RETENÇÃO — MANTA G3
// 8 unidades — braço 13mm (espessura filtro 10mm + MDF 3mm)
// Mesa: ~92mm × 33mm — cabe na Ender 3 (200×200mm) ✓
// Divisória: 07_DIVISORIA_MANTA_G3 — Abertura 200×200mm
// ============================================================
// Orientação: base na mesa (Z=0), braço+aba para cima
// Infill recomendado: 80-100%
// Material: PETG (melhor) ou PLA
// Parafusos: 8× M3×10mm + 8× porca M3
// ============================================================
// Posições M3 na divisória (coordenadas NC):
//   (12,80)(12,160)(232,80)(232,160)
//   (88,10)(156,10)(88,230)(156,230)
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
ret_w = 20;
ret_d = 15;

// 4 colunas × 2 fileiras = 8 clips Manta G3 (braço 13mm)
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), row * (ret_d + gap), 0])
            clip_manta();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
