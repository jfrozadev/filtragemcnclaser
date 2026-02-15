// ============================================================
// PRINT: CLIPS RETENÇÃO — HEPA
// 8 unidades — braço 5mm (borda filtro 2mm + MDF 3mm)
// Mesa: ~92mm × 33mm — cabe na Ender 3 (200×200mm) ✓
// Divisória: 10_DIVISORIA_HEPA — Abertura 100×130mm
// ============================================================
// Clip com braço curto (5mm) — segura apenas a borda fina do HEPA
// Borda HEPA: 5mm largura × 2mm espessura
// Orientação: base na mesa (Z=0), braço+aba para cima
// Infill recomendado: 80-100%
// Material: PETG (melhor) ou PLA
// Parafusos: 8× M3×6mm + 8× porca M3
// ============================================================
// Posições M3 na divisória (coordenadas NC):
//   (57,100)(57,140)(187,100)(187,140)
//   (105,40)(139,40)(105,200)(139,200)
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
ret_w = 20;
ret_d = 15;

// 4 colunas × 2 fileiras = 8 clips HEPA (braço 5mm)
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), row * (ret_d + gap), 0])
            clip_hepa();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
