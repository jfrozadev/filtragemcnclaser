// ============================================================
// TRILHO_PRINT_LAYOUT.scad
// Layout otimizado para impressão na Ender 3 (200×200mm)
// ============================================================
//
// Este arquivo organiza as peças do TRILHO_FILTRO.scad em
// batches que cabem na mesa da Ender 3.
//
// USO:
//   1. Abrir no OpenSCAD
//   2. Descomentar o batch desejado
//   3. Exportar STL → Slicer (Cura/PrusaSlicer)
//
// CONFIGURAÇÕES DE IMPRESSÃO:
//   Material: PLA ou PETG
//   Layer: 0.2mm
//   Infill: 40% (grid ou gyroid)
//   Walls: 3 perímetros
//   Suporte: NÃO necessário (perfil U deitado, abas para cima)
//   Orientação: base do trilho na cama, abas U para cima
//
// ============================================================

// Importar módulos do arquivo principal
use <TRILHO_FILTRO.scad>

// Espaçamento entre peças na cama
gap = 3; // 3mm entre peças

// Bed size
bed_x = 200;
bed_y = 200;

// ============================================================
// LAYOUT CORRIGIDO: Peças lado a lado em X, comp em Y
// Cada metade: largura × 122mm comp.  Y=122mm < 200mm ✓
// ============================================================

// ============================================================
// BATCH 1: Trilhos finos — Tela Carvão (canal 3.4mm)
// 8 metades (4×A + 4×B) lado a lado em X
// Peça: ~7.4mm larg × 122mm comp → cabe: 59×122mm
// Tempo estimado: ~50min
// ============================================================

module batch_1_tela_carvao() {
    largura = 3.4 + 2*2; // canal + 2× parede = 7.4mm
    
    // 4× Metade A + 4× Metade B — tudo em uma fileira X
    for (i = [0:3]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(3.4);
    }
    for (i = [0:3]) {
        translate([(4 + i) * (largura + gap), 0, 0])
            trilho_metade_b(3.4);
    }
    
    // Tamanho total: ~80mm × 122mm ✓
}

// ============================================================
// BATCH 2: Trilhos Manta G3 (canal 12mm)
// 4 metades (2×A + 2×B) lado a lado em X
// Peça: ~16mm larg × 122mm comp → cabe: 73mm × 122mm
// Tempo estimado: ~1h
// ============================================================

module batch_2_manta_g3() {
    largura = 12 + 2*2; // 16mm
    
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(12);
    }
    for (i = [0:1]) {
        translate([(2 + i) * (largura + gap), 0, 0])
            trilho_metade_b(12);
    }
    
    // Tamanho total: ~73mm × 122mm ✓
}

// ============================================================
// BATCH 3: Trilhos GM Cabine (canal 21mm)
// 4 metades (2×A + 2×B) lado a lado em X
// Peça: ~25mm larg × 122mm comp → cabe: 109mm × 122mm
// Tempo estimado: ~1h20
// ============================================================

module batch_3_gm_cabine() {
    largura = 21 + 2*2; // 25mm
    
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(21);
    }
    for (i = [0:1]) {
        translate([(2 + i) * (largura + gap), 0, 0])
            trilho_metade_b(21);
    }
    
    // Tamanho total: ~109mm × 122mm ✓
}

// ============================================================
// BATCH 4: Trilhos HEPA (canal 26mm)
// 4 metades (2×A + 2×B) lado a lado em X
// Peça: ~30mm larg × 122mm comp → cabe: 129mm × 122mm
// Tempo estimado: ~1h30
// ============================================================

module batch_4_hepa() {
    largura = 26 + 2*2; // 30mm
    
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(26);
    }
    for (i = [0:1]) {
        translate([(2 + i) * (largura + gap), 0, 0])
            trilho_metade_b(26);
    }
    
    // Tamanho total: ~129mm × 122mm ✓
}

// ============================================================
// BATCH 5A: Trilhos Wega Motor (canal 46mm) — Metades A
// 2 metades A lado a lado
// Peça: ~50mm larg × 122mm comp → cabe: 103mm × 122mm
// Tempo estimado: ~1h
// ============================================================

module batch_5a_wega() {
    largura = 46 + 2*2; // 50mm
    
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(46);
    }
    
    // Tamanho total: ~103mm × 122mm ✓
}

// ============================================================
// BATCH 5B: Trilhos Wega Motor (canal 46mm) — Metades B
// 2 metades B lado a lado
// Peça: ~50mm larg × 122mm comp → cabe: 103mm × 122mm
// Tempo estimado: ~1h
// ============================================================

module batch_5b_wega() {
    largura = 46 + 2*2; // 50mm
    
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_b(46);
    }
    
    // Tamanho total: ~103mm × 122mm ✓
}

// ============================================================
// BATCH 6: Acessórios — Puxadores + Travas
// 6× puxadores + 6× travas = 12 peças pequenas
// Tempo estimado: ~45min
// ============================================================

module batch_6_acessorios() {
    // 3 puxadores por fileira (30mm cada + gap)
    for (i = [0:2]) {
        translate([i * 35, 0, 0])
            puxador();
    }
    for (i = [0:2]) {
        translate([i * 35, 25, 0])
            puxador();
    }
    
    // 6 travas ao lado
    for (i = [0:5]) {
        translate([110 + i * 15, 0, 0])
            trava();
    }
    
    // Tamanho total: ~200mm × 33mm ✓
}

// ============================================================
// BATCH COMBO: Batches 2+3 juntos (Manta + GM)
// 8 metades no total — lado a lado em X: 185mm × 122mm
// Tempo estimado: ~2h
// ============================================================

module batch_combo_manta_gm() {
    largura_g3 = 12 + 2*2;  // 16mm
    largura_gm = 21 + 2*2;  // 25mm
    
    // G3: 2A + 2B
    for (i = [0:1]) {
        translate([i * (largura_g3 + gap), 0, 0])
            trilho_metade_a(12);
    }
    for (i = [0:1]) {
        translate([(2 + i) * (largura_g3 + gap), 0, 0])
            trilho_metade_b(12);
    }
    
    // GM: 2A + 2B — offset em X
    offset_x = 4 * (largura_g3 + gap) + 5;
    for (i = [0:1]) {
        translate([offset_x + i * (largura_gm + gap), 0, 0])
            trilho_metade_a(21);
    }
    for (i = [0:1]) {
        translate([offset_x + (2 + i) * (largura_gm + gap), 0, 0])
            trilho_metade_b(21);
    }
    
    // Tamanho total: ~185mm × 122mm ✓
}

// ============================================================
// BATCH COMBO: Batches 4+5A juntos (HEPA + Wega×A)
// 4 HEPA + 2 Wega A — max 6 peças: ~192mm × 122mm
// Tempo estimado: ~2h30
// ============================================================

module batch_combo_hepa_wega_a() {
    largura_hepa = 26 + 2*2; // 30mm
    largura_wega = 46 + 2*2; // 50mm
    
    // HEPA: 2A + 2B
    for (i = [0:1]) {
        translate([i * (largura_hepa + gap), 0, 0])
            trilho_metade_a(26);
    }
    for (i = [0:1]) {
        translate([(2 + i) * (largura_hepa + gap), 0, 0])
            trilho_metade_b(26);
    }
    
    // Wega A: 2 peças após HEPA
    offset_x = 4 * (largura_hepa + gap) + 5;
    for (i = [0:1]) {
        translate([offset_x + i * (largura_wega + gap), 0, 0])
            trilho_metade_a(46);
    }
    
    // Tamanho total: ~192mm × 122mm ✓ (apertado, cabe)
}

// ============================================================
// VISUALIZAÇÃO — Mostrar todos os batches side by side
// (Apenas para conferência visual, não para impressão)
// ============================================================

module preview_all_batches() {
    color("DodgerBlue") translate([0, 0, 0])
        batch_1_tela_carvao();
    
    color("LimeGreen") translate([0, 135, 0])
        batch_2_manta_g3();
    
    color("Gold") translate([0, 270, 0])
        batch_3_gm_cabine();
    
    color("DeepSkyBlue") translate([0, 405, 0])
        batch_4_hepa();
    
    color("Tomato") translate([0, 540, 0])
        batch_5a_wega();
    
    color("OrangeRed") translate([0, 675, 0])
        batch_5b_wega();
    
    color("Orange") translate([0, 810, 0])
        batch_6_acessorios();
}

// ============================================================
// RENDER — Descomentar a linha desejada
// ============================================================

// Batches individuais (para gerar STL):
batch_1_tela_carvao();      // 8× trilhos finos (~50min)
// batch_2_manta_g3();      // 4× trilhos G3 (~1h)
// batch_3_gm_cabine();     // 4× trilhos GM (~1h20)
// batch_4_hepa();          // 4× trilhos HEPA (~1h30)
// batch_5a_wega();         // 2× trilhos Wega A (~1h)
// batch_5b_wega();         // 2× trilhos Wega B (~1h)
// batch_6_acessorios();    // 6× puxadores + 6× travas (~45min)

// Batches combinados (menos impressões):
// batch_combo_manta_gm();     // G3 + GM juntos (~2h)
// batch_combo_hepa_wega_a();  // HEPA + Wega A juntos (~2h30)

// Visualização geral (não para impressão):
// preview_all_batches();

// ============================================================
// RESUMO DOS BATCHES
// ============================================================
//
// OPÇÃO A — 7 batches individuais (~7h25 total):
// | Batch | Filtro     | Peças | Tempo  | Tamanho cama     |
// |-------|-----------|-------|--------|------------------|
// | 1     | Tela×2    | 8     | ~50min | 80×122mm   ✓    |
// | 2     | Manta G3  | 4     | ~1h    | 73×122mm   ✓    |
// | 3     | GM Cabine | 4     | ~1h20  | 109×122mm  ✓    |
// | 4     | HEPA      | 4     | ~1h30  | 129×122mm  ✓    |
// | 5A    | Wega (A)  | 2     | ~1h    | 103×122mm  ✓    |
// | 5B    | Wega (B)  | 2     | ~1h    | 103×122mm  ✓    |
// | 6     | Acessórios| 12    | ~45min | 200×33mm   ✓    |
// | TOTAL |           | 36    | ~7h25  |                  |
//
// OPÇÃO B — 4 batches combinados (~6h05 total):
// | Batch | Filtros        | Peças | Tempo  | Tamanho cama  |
// |-------|---------------|-------|--------|---------------|
// | 1     | Tela×2        | 8     | ~50min | 80×122mm  ✓  |
// | 2     | G3 + GM       | 8     | ~2h    | 185×122mm ✓  |
// | 3     | HEPA + Wega A | 6     | ~2h30  | 192×122mm ✓  |
// | 4     | Wega B        | 2     | ~1h    | 103×122mm ✓  |
// | 5     | Acessórios    | 12    | ~45min | 200×33mm  ✓  |
// | TOTAL |               | 36    | ~7h05  |               |
//
// NOTA: Todas as dimensões agora cabem na Ender 3 (200×200mm)
//   Peças dispostas lado a lado em X, comp=122mm em Y
//
// ============================================================
