// ============================================================
// PRINT: TRILHOS WEGA MOTOR (Posição 3 — X=125mm)
// 4 peças idênticas — canal 46mm (filtro 45mm + folga)
// Filtro corpo: 220×160×41mm (mídia), frame/borda: 246×183×4mm (PU)
// ============================================================
// ATENÇÃO: 4 peças (4×53mm = 212mm) NÃO cabem juntas!
// Impressão em 2 rodadas de 2 peças cada.
// Mesa: 106mm × 122mm por rodada ✓
// Tempo estimado: ~1h por rodada (2h total)
// ============================================================
// Rodada 1: descomentar RODADA_1
// Rodada 2: descomentar RODADA_2
// ============================================================

use <TRILHO_FILTRO.scad>

gap = 3;
canal = 46;
largura = canal + 2*2; // 50mm

// === RODADA 1 — 2 peças (lateral esquerda) ===
for (i = [0:1]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}

// === RODADA 2 — 2 peças (lateral direita) ===
// Descomente abaixo e comente a Rodada 1
/*
for (i = [0:1]) {
    translate([i * (largura + gap), 0, 0])
        trilho_metade_a(canal);
}
*/

// Guia visual da mesa (não imprime)
%translate([0, 0, -0.5])
    cube([200, 200, 0.1]);
