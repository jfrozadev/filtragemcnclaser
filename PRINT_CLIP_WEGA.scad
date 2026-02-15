// ============================================================
// PRINT: CLIPS RETENÇÃO — WEGA
// 4 unidades — braço 13mm (espessura filtro 10mm + MDF 3mm)
// Mesa: ~89mm × 23mm — cabe na Ender 3 (200×200mm) ✓
// Divisória: 09_DIVISORIA_WEGA — Abertura 223×160mm
// ============================================================
// ⚠️ APENAS 4 CLIPS (topo e base) — sem clips laterais
//    Frame lateral muito estreito (10.5mm)
// Design estilo clip HVAC (perfil Z com aba sobre o filtro)
// Orientação: base na mesa (Z=0), braço+aba para cima
// Infill recomendado: 80-100%
// Material: PETG (melhor) ou PLA
// Parafusos: 4× M3×10mm + 4× porca M3
// ============================================================
// Posições M3 na divisória (coordenadas NC):
//   (82,20)(162,20)(82,220)(162,220)
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
ret_w = 20;
aba_y = 8;    // offset Y para aba que estende em -Y

// 4 colunas × 1 fileira = 4 clips Wega (braço 13mm)
for (col = [0:3]) {
    translate([col * (ret_w + gap), aba_y, 0])
        clip_wega();
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
