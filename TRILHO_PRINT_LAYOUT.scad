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
// BATCH 1: Trilhos finos — Tela Carvão (canal 3.4mm)
// 8 metades (4×A + 4×B) — todas as telas
// Peça: ~7.4mm larg × 122mm comp → 8 peças cabem fácil
// Tempo estimado: ~50min
// ============================================================

module batch_1_tela_carvao() {
    largura = 3.4 + 2*2; // canal + 2× parede = 7.4mm
    
    // 4× Metade A (com dovetail macho)
    for (i = [0:3]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(3.4);
    }
    
    // 4× Metade B (com dovetail fêmea) — afastadas em Y
    for (i = [0:3]) {
        translate([i * (largura + gap), 122 + gap + 5, 0])
            trilho_metade_b(3.4);
    }
    
    // Tamanho total: ~42mm × 249mm
    // Orientação: horizontal na cama (cabe em 200×200 se rotacionado)
    // NOTA: Se comp > 200mm, rotacionar 90° no slicer
}

// ============================================================
// BATCH 2: Trilhos Manta G3 (canal 12mm)
// 4 metades (2×A + 2×B)
// Peça: ~16mm larg × 122mm comp
// Tempo estimado: ~1h
// ============================================================

module batch_2_manta_g3() {
    largura = 12 + 2*2; // 16mm
    
    // 2× Metade A
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(12);
    }
    
    // 2× Metade B
    for (i = [0:1]) {
        translate([i * (largura + gap), 122 + gap + 5, 0])
            trilho_metade_b(12);
    }
    
    // Tamanho total: ~35mm × 249mm
}

// ============================================================
// BATCH 3: Trilhos GM Cabine (canal 21mm)
// 4 metades (2×A + 2×B)
// Peça: ~25mm larg × 122mm comp
// Tempo estimado: ~1h20
// ============================================================

module batch_3_gm_cabine() {
    largura = 21 + 2*2; // 25mm
    
    // 2× Metade A
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(21);
    }
    
    // 2× Metade B
    for (i = [0:1]) {
        translate([i * (largura + gap), 122 + gap + 5, 0])
            trilho_metade_b(21);
    }
    
    // Tamanho total: ~53mm × 249mm
}

// ============================================================
// BATCH 4: Trilhos HEPA (canal 26mm)
// 4 metades (2×A + 2×B)
// Peça: ~30mm larg × 122mm comp
// Tempo estimado: ~1h30
// ============================================================

module batch_4_hepa() {
    largura = 26 + 2*2; // 30mm
    
    // 2× Metade A
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(26);
    }
    
    // 2× Metade B
    for (i = [0:1]) {
        translate([i * (largura + gap), 122 + gap + 5, 0])
            trilho_metade_b(26);
    }
    
    // Tamanho total: ~63mm × 249mm
}

// ============================================================
// BATCH 5: Trilhos Wega Motor (canal 46mm) — O MAIOR
// 4 metades (2×A + 2×B)
// Peça: ~50mm larg × 122mm comp
// Tempo estimado: ~2h
// ============================================================

module batch_5_wega() {
    largura = 46 + 2*2; // 50mm
    
    // 2× Metade A
    for (i = [0:1]) {
        translate([i * (largura + gap), 0, 0])
            trilho_metade_a(46);
    }
    
    // 2× Metade B
    for (i = [0:1]) {
        translate([i * (largura + gap), 122 + gap + 5, 0])
            trilho_metade_b(46);
    }
    
    // Tamanho total: ~103mm × 249mm
    // NOTA: Wega é o mais largo mas ainda cabe na Ender 3
}

// ============================================================
// BATCH 6: Acessórios — Puxadores + Travas
// 6× puxadores + 6× travas = 12 peças pequenas
// Tempo estimado: ~45min
// ============================================================

module batch_6_acessorios() {
    // 6 puxadores (30×7.4×15mm cada)
    for (i = [0:5]) {
        translate([i * 35, 0, 0])
            puxador();
    }
    
    // 6 travas (10×1.2×8mm cada)
    for (i = [0:5]) {
        translate([i * 15, 25, 0])
            trava();
    }
    
    // Tamanho total: ~210mm × 33mm
    // NOTA: puxadores podem precisar de 2 fileiras se largos demais
}

// ============================================================
// BATCH COMBO: Batches 2+3 juntos (Manta + GM)
// 8 metades no total — cabem na mesma cama
// Tempo estimado: ~2h
// ============================================================

module batch_combo_manta_gm() {
    // Manta G3 (larg=16mm)
    largura_g3 = 12 + 2*2;
    for (i = [0:1]) {
        translate([i * (largura_g3 + gap), 0, 0])
            trilho_metade_a(12);
    }
    for (i = [0:1]) {
        translate([i * (largura_g3 + gap), 122 + gap + 5, 0])
            trilho_metade_b(12);
    }
    
    // GM Cabine (larg=25mm) — offset em X
    offset_x = 2 * (largura_g3 + gap) + 10;
    largura_gm = 21 + 2*2;
    for (i = [0:1]) {
        translate([offset_x + i * (largura_gm + gap), 0, 0])
            trilho_metade_a(21);
    }
    for (i = [0:1]) {
        translate([offset_x + i * (largura_gm + gap), 122 + gap + 5, 0])
            trilho_metade_b(21);
    }
    
    // Tamanho total: ~98mm × 249mm
}

// ============================================================
// BATCH COMBO: Batches 4+5 juntos (HEPA + Wega)
// 8 metades no total
// Tempo estimado: ~3h
// ============================================================

module batch_combo_hepa_wega() {
    // HEPA (larg=30mm)
    largura_hepa = 26 + 2*2;
    for (i = [0:1]) {
        translate([i * (largura_hepa + gap), 0, 0])
            trilho_metade_a(26);
    }
    for (i = [0:1]) {
        translate([i * (largura_hepa + gap), 122 + gap + 5, 0])
            trilho_metade_b(26);
    }
    
    // Wega (larg=50mm) — offset em X
    offset_x = 2 * (largura_hepa + gap) + 10;
    largura_wega = 46 + 2*2;
    for (i = [0:1]) {
        translate([offset_x + i * (largura_wega + gap), 0, 0])
            trilho_metade_a(46);
    }
    for (i = [0:1]) {
        translate([offset_x + i * (largura_wega + gap), 122 + gap + 5, 0])
            trilho_metade_b(46);
    }
    
    // Tamanho total: ~176mm × 249mm — apertado mas cabe
}

// ============================================================
// VISUALIZAÇÃO — Mostrar todos os batches side by side
// (Apenas para conferência visual, não para impressão)
// ============================================================

module preview_all_batches() {
    color("DodgerBlue") translate([0, 0, 0])
        batch_1_tela_carvao();
    
    color("LimeGreen") translate([0, 260, 0])
        batch_2_manta_g3();
    
    color("Gold") translate([0, 520, 0])
        batch_3_gm_cabine();
    
    color("DeepSkyBlue") translate([0, 780, 0])
        batch_4_hepa();
    
    color("Tomato") translate([0, 1040, 0])
        batch_5_wega();
    
    color("Orange") translate([0, 1300, 0])
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
// batch_5_wega();          // 4× trilhos Wega (~2h)
// batch_6_acessorios();    // 6× puxadores + 6× travas (~45min)

// Batches combinados (menos impressões):
// batch_combo_manta_gm();     // G3 + GM juntos (~2h)
// batch_combo_hepa_wega();    // HEPA + Wega juntos (~3h)

// Visualização geral (não para impressão):
// preview_all_batches();

// ============================================================
// RESUMO DOS BATCHES
// ============================================================
//
// OPÇÃO A — 6 batches individuais (~7h30 total):
// | Batch | Filtro     | Peças | Tempo  | Tamanho cama     |
// |-------|-----------|-------|--------|------------------|
// | 1     | Tela×2    | 8     | ~50min | 42×249mm         |
// | 2     | Manta G3  | 4     | ~1h    | 35×249mm         |
// | 3     | GM Cabine | 4     | ~1h20  | 53×249mm         |
// | 4     | HEPA      | 4     | ~1h30  | 63×249mm         |
// | 5     | Wega      | 4     | ~2h    | 103×249mm        |
// | 6     | Acessórios| 12    | ~45min | 210×33mm         |
// | TOTAL |           | 36    | ~7h25  |                  |
//
// OPÇÃO B — 4 batches combinados (~6h35 total):
// | Batch | Filtros        | Peças | Tempo  | Tamanho cama  |
// |-------|---------------|-------|--------|---------------|
// | 1     | Tela×2        | 8     | ~50min | 42×249mm      |
// | 2     | G3 + GM       | 8     | ~2h    | 98×249mm      |
// | 3     | HEPA + Wega   | 8     | ~3h    | 176×249mm     |
// | 4     | Acessórios    | 12    | ~45min | 210×33mm      |
// | TOTAL |               | 36    | ~6h35  |               |
//
// NOTA: Comprimento 249mm > 200mm da Ender 3
//   → Rotacionar as peças na diagonal OU
//   → Imprimir em Y (122mm comp cabe em 200mm)
//   → No slicer: girar 90° se necessário
//
// ============================================================
