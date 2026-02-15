// ============================================================
// PRINT: CLIPS RETENÇÃO — HEPA
// 8 unidades — braço 5mm (borda filtro 2mm + MDF 3mm)
// Mesa: ~89mm × 56mm — cabe na Ender 3 (200×200mm) ✓
// Divisória: 10_DIVISORIA_HEPA — Abertura 100×130mm
// ============================================================
// Clip com braço curto (5mm) — segura apenas a borda fina do HEPA
// Borda HEPA: 5mm largura × 2mm espessura
// Design estilo clip HVAC (perfil Z com aba sobre o filtro)
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
aba_y = 8;            // offset Y para aba que estende em -Y
row_h = 15 + aba_y;   // altura total Y por clip = base + aba

// 4 colunas × 2 fileiras = 8 clips HEPA (braço 5mm)
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), row * (row_h + gap) + aba_y, 0])
            clip_hepa();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
