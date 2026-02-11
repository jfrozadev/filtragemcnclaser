// ============================================================
// PRINT_LAYOUT_COMPLETO.scad
// Layout de referência — Ender 3 (200×200mm)
// ============================================================
//
// ⚠️  ARQUIVOS SEPARADOS POR FILTRO (recomendado):
//   Use os arquivos PRINT_*.scad individuais para imprimir.
//   Cada arquivo tem as peças distribuídas na mesa, prontas
//   para exportar STL direto no OpenSCAD (F6 → F7).
//
// | Arquivo               | Peças                   | Mesa       | Tempo  |
// |-----------------------|-------------------------|------------|--------|
// | PRINT_TELA_CARVAO.scad| 8× trilho 3.4mm         | 83×122mm   | ~50min |
// | PRINT_MANTA_G3.scad   | 4× trilho 12mm          | 76×122mm   | ~1h    |
// | PRINT_GM_CABINE.scad  | 4× trilho 21mm          | 112×122mm  | ~1h20  |
// | PRINT_HEPA.scad       | 4× trilho 26mm          | 132×122mm  | ~1h30  |
// | PRINT_WEGA.scad       | 2+2× trilho 46mm        | 106×122mm  | ~2h    |
// | PRINT_ACESSORIOS.scad | 6× puxadores + 6× travas| 200×33mm   | ~45min |
// | PRINT_SNAP_CLIPS.scad | 16× snap clips          | 92×48mm    | ~2h    |
// | PRINT_VEDACAO.scad    | 8× vedação segmentos    | 122×72mm   | ~1h30  |
// | FLANGE_150mm.scad     | Flange 150mm            | 180×180mm  | ~3h    |
// | FLANGE_70mm.scad      | Flange 70mm             | 100×100mm  | ~1h30  |
// |-----------------------|-------------------------|------------|--------|
// | TOTAL                 | 62 peças                | 11 prints  | ~15h30 |
//
// CONFIGURAÇÕES DE IMPRESSÃO:
//   Material: PLA ou PETG
//   Layer: 0.2mm
//   Infill: 40% (trilhos) / 80% (clips)
//   Walls: 3 perímetros
//   Suporte: NÃO necessário (orientação otimizada)
//
// ============================================================
//
// Este arquivo mantém os batches consolidados para
// preview/referência. Para impressão use os PRINT_*.scad.
//
// ============================================================

// Importar módulos dos arquivos principais
use <TRILHO_FILTRO.scad>
use <SNAP_TAMPA.scad>

// Espaçamento entre peças na cama
gap = 3; // 3mm entre peças

// Bed size
bed_x = 200;
bed_y = 200;

// ============================================================
// SUMÁRIO DE BATCHES (10 impressões totais)
// ============================================================
//
// | Batch | Peças                    | Tamanho     | Tempo  |
// |-------|--------------------------|-------------|--------|
// | 1     | 8× trilho fino (3.4mm)   | 80×122mm    | ~50min |
// | 2     | 4× trilho G3 (12mm)      | 73×122mm    | ~1h    |
// | 3     | 4× trilho GM (21mm)      | 109×122mm   | ~1h20  |
// | 4     | 4× trilho HEPA (26mm)    | 129×122mm   | ~1h30  |
// | 5A    | 2× trilho Wega A (46mm)  | 103×122mm   | ~1h    |
// | 5B    | 2× trilho Wega B (46mm)  | 103×122mm   | ~1h    |
// | 6     | 6× puxadores + 6× travas | 200×33mm    | ~45min |
// | 7     | 16× snap clips           | 100×130mm   | ~2h    |
// | 8     | 8× vedação segmentos     | 130×65mm    | ~1h30  |
// | 9     | Flange 150mm             | 180×180mm   | ~3h    |
// | 10    | Flange 70mm              | 100×100mm   | ~1h30  |
// |-------|--------------------------|-------------|--------|
// | TOTAL | 55 peças                 | 10 prints   | ~15h   |
//
// ============================================================

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
    
    color("Magenta") translate([0, 945, 0])
        batch_7_snap_clips();
    
    color("Cyan") translate([0, 1080, 0])
        batch_8_vedacao();
}

// ============================================================
// BATCH 7: Snap-fit Clips — 16 unidades
// 4 fileiras × 4 colunas (20mm × 30mm cada + gap)
// Tamanho total: ~100mm × 130mm ✓
// Tempo estimado: ~2h
// ORIENTAÇÃO: Clip deitado com ponte na mesa (Z=0)
// ============================================================

module batch_7_snap_clips() {
    clip_w = 20;    // largura do clip (X)
    clip_d = 8.3;   // profundidade total Y (mdf+folga+2*parede = 3+0.3+2*2 = 7.3 + ganchos ~1mm)
    altura_ext = 30; // altura perna externa
    parede = 2;      // espessura ponte
    
    for (row = [0:3]) {
        for (col = [0:3]) {
            translate([col * (clip_w + gap), row * (clip_d + gap), 0])
            // Orientação para impressão: pernas para cima, ponte na mesa
            // Geometria original: Z[-30, +2], Y[~-1.2, ~8.3]
            // rotate 180° (XZ): Z→[-2,+30], Y→[-8.3,+1.2]
            // translate Y+clip_d, Z+parede: Y[0, 9.5], Z[0, 32]
            translate([0, clip_d, parede])
            rotate([180, 0, 0])
                snap_clip_tampa();
        }
    }
    
    // Dimensão cada clip: 20mm × ~9mm × 32mm (X×Y×Z)
    // Layout: 4col × 4row
    // Tamanho total: 4×(20+3)=92mm × 4×(9+3)=48mm ✓ (bem compacto!)
}

// ============================================================
// BATCH 8: Vedação Divisória — 8 segmentos
// 4 horizontais (122mm) + 4 verticais (120mm)
// Deitados lado a lado em Y
// Tamanho total: ~130mm × 65mm ✓
// Tempo estimado: ~1h30
// ============================================================

module batch_8_vedacao() {
    frame_w = 6;
    
    // 4 segmentos horizontais (122mm cada, deitados em Y)
    for (i = [0:1]) {
        translate([0, i * (frame_w + gap), 0])
            vedacao_segmento_h_a();
    }
    for (i = [0:1]) {
        translate([0, (2 + i) * (frame_w + gap), 0])
            vedacao_segmento_h_b();
    }
    
    // 4 segmentos verticais (120mm cada, rotacionados)
    for (i = [0:1]) {
        translate([0, (4 + i) * (frame_w + gap), 0])
        rotate([0, 0, -90])
        translate([-120, 0, 0])
            vedacao_segmento_v_a();
    }
    for (i = [0:1]) {
        translate([0, (6 + i) * (frame_w + gap), 0])
        rotate([0, 0, -90])
        translate([-120, 0, 0])
            vedacao_segmento_v_b();
    }
    
    // Tamanho total: 122mm × 8×(6+3) = 122mm × 72mm ✓
}

// ============================================================
// RENDER — Descomentar a linha desejada
// ============================================================

// === TRILHOS ===
batch_1_tela_carvao();      // 8× trilhos finos (~50min)
// batch_2_manta_g3();      // 4× trilhos G3 (~1h)
// batch_3_gm_cabine();     // 4× trilhos GM (~1h20)
// batch_4_hepa();          // 4× trilhos HEPA (~1h30)
// batch_5a_wega();         // 2× trilhos Wega A (~1h)
// batch_5b_wega();         // 2× trilhos Wega B (~1h)
// batch_6_acessorios();    // 6× puxadores + 6× travas (~45min)

// === SNAP CLIPS + VEDAÇÃO ===
// batch_7_snap_clips();    // 16× snap clips (~2h)
// batch_8_vedacao();       // 8× segmentos vedação (~1h30)

// === BATCHES COMBINADOS ===
// batch_combo_manta_gm();     // G3 + GM juntos (~2h)
// batch_combo_hepa_wega_a();  // HEPA + Wega A juntos (~2h30)

// === VISUALIZAÇÃO ===
// preview_all_batches();

// ============================================================
// NOTA: FLANGES (180×180 e 100×100mm)
// ============================================================
// As flanges são impressas separadamente usando seus arquivos:
//   - FLANGE_150mm.scad → 180×180mm ✓ (cabe em 200×200)
//   - FLANGE_70mm.scad  → 100×100mm ✓ (cabe em 200×200)
// Basta abrir o arquivo .scad, F6 para renderizar, F7 para exportar STL.
// ============================================================

// ============================================================
// RESUMO COMPLETO — TODAS AS PEÇAS 3D
// ============================================================
//
// | Batch | Peças                    | Qtd | Tempo  | Tamanho      |
// |-------|--------------------------|-----|--------|--------------|
// | 1     | Trilhos Tela Carvão      |  8  | ~50min | 80×122mm  ✓ |
// | 2     | Trilhos Manta G3         |  4  | ~1h    | 73×122mm  ✓ |
// | 3     | Trilhos GM Cabine        |  4  | ~1h20  | 109×122mm ✓ |
// | 4     | Trilhos HEPA             |  4  | ~1h30  | 129×122mm ✓ |
// | 5A    | Trilhos Wega (metade A)  |  2  | ~1h    | 103×122mm ✓ |
// | 5B    | Trilhos Wega (metade B)  |  2  | ~1h    | 103×122mm ✓ |
// | 6     | Puxadores + Travas       | 12  | ~45min | 200×33mm  ✓ |
// | 7     | Snap Clips (tampa/base)  | 16  | ~2h    | 100×130mm ✓ |
// | 8     | Vedação Divisória (opt)  |  8  | ~1h30  | 130×65mm  ✓ |
// | 9     | Flange 150mm             |  1  | ~3h    | 180×180mm ✓ |
// | 10    | Flange 70mm              |  1  | ~1h30  | 100×100mm ✓ |
// |-------|--------------------------|-----|--------|--------------|
// | TOTAL |                          | 62  | ~15h30 |              |
//
// TODAS AS PEÇAS CABEM NA MESA 200×200mm ✓
//
// MATERIAL ESTIMADO:
//   PLA/PETG: ~150g (trilhos 80g + clips 30g + flanges 40g)
//
// ============================================================
