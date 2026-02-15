// ============================================================
// PRINT: CLIPS RETENÇÃO — GM CABINE
// 8 unidades — braço 23mm (espessura filtro 20mm + MDF 3mm)
// Mesa: ~92mm × 33mm — cabe na Ender 3 (200×200mm) ✓
// Divisória: 08_DIVISORIA_GM — Abertura 212×200mm
// ============================================================
// Orientação: base na mesa (Z=0), braço+aba para cima
// Infill recomendado: 80-100%
// Material: PETG (melhor) ou PLA
// Parafusos: 8× M3×16mm + 8× porca M3
// ============================================================
// Posições M3 na divisória (coordenadas NC):
//   (8,80)(8,160)(236,80)(236,160)
//   (82,10)(162,10)(82,230)(162,230)
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
ret_w = 20;
ret_d = 15;

// 4 colunas × 2 fileiras = 8 clips GM Cabine (braço 23mm)
for (row = [0:1]) {
    for (col = [0:3]) {
        translate([col * (ret_w + gap), row * (ret_d + gap), 0])
            clip_gm();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
