// ============================================================
// PRINT: CANTONEIRAS M3 — 16 unidades (8 tampa + 8 base)
// L-bracket para fixação tampa/base nos painéis laterais
// Mesa: ~92mm × 73mm — cabe na Ender 3 (200×200mm) ✓
// ============================================================
// Orientação: flange horizontal na mesa (Z=0)
//             flange vertical para cima
// Infill recomendado: 80-100% (precisa ser resistente)
// Material: PETG (melhor) ou PLA
// Hardware: 32× M3×8mm + 32× porca M3
// ============================================================
// Clips de retenção de filtro estão em arquivos separados:
//   PRINT_CLIP_MANTA.scad — 8× braço 13mm
//   PRINT_CLIP_GM.scad    — 8× braço 23mm
//   PRINT_CLIP_WEGA.scad  — 4× braço 13mm
//   PRINT_CLIP_HEPA.scad  — 8× braço 5mm
// ============================================================

use <SNAP_TAMPA.scad>

gap = 3;
cant_w = 20;      // largura X da cantoneira
cant_d = 15;      // profundidade Y da cantoneira (flange horizontal)

// 4 colunas × 4 fileiras = 16 cantoneiras
for (row = [0:3]) {
    for (col = [0:3]) {
        translate([col * (cant_w + gap), row * (cant_d + gap), 0])
            cantoneira_tampa();
    }
}

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
