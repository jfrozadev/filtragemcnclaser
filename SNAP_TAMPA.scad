// ==========================================
// CANTONEIRA M3 PARA TAMPA E BASE - CAIXA DE FILTRAGEM
// + CLIP RETENÇÃO FILTRO (PARAFUSO M3) PARA DIVISÓRIAS
// Impressão 3D - PLA/PETG (Ender 3)
// ==========================================
// SISTEMA DE FIXAÇÃO:
// - 16 cantoneiras L-bracket: 8 tampa (topo) + 8 base (inferior)
//   Parafuso M3 pela tampa/base + parafuso M3 pelo painel lateral
//   Cada cantoneira: 2× M3 + 2× porca M3 (capturadas)
//   Total: 32× M3×8mm + 32× porcas M3
// - 28 clips retenção filtro (parafuso M3×10mm):
//     8× Manta G3  (10mm espessura, braço 13mm)
//     8× GM Cabine  (20mm espessura, braço 23mm)
//     4× Wega        (10mm espessura, braço 13mm, só topo/base)
//     8× HEPA        (borda 2mm espessura, braço 5mm)
//   Perfil Z: base parafusada no frame MDF → braço vertical →
//   aba horizontal pressiona filtro contra a divisória
// ==========================================

// Parâmetros da caixa
mdf = 3;          // Espessura MDF
folga = 0.3;      // Folga para encaixe
parede = 2;       // Espessura da parede do clip

// === CANTONEIRA (L-BRACKET) PARA TAMPA/BASE ===
//
// Vista lateral (seção):
//
//   ═══════════════ Tampa (MDF 3mm)
//       ↕ parafuso M3 (vertical, pela tampa)
//   ┌───●────┐
//   │ h-flange│ ← flange horizontal (sob a tampa)
//   ├────────┤
//   │        │
//   │ v-flange│ ← flange vertical (contra painel interno)
//   │   ●    │ ← parafuso M3 (horizontal, pelo painel)
//   │        │
//   └────────┘
//   ║ painel ║   (interior da caixa →)
//
// Montagem:
// 1. Inserir porca M3 nos bolsos hexagonais da cantoneira
// 2. Posicionar cantoneira no canto interno (tampa × painel)
// 3. Parafusar M3 por fora da tampa → rosca na porca do h-flange
// 4. Parafusar M3 por fora do painel → rosca na porca do v-flange
//
// Posições (8 por tampa/base, 2 por lado):
//   Lateral ESQ/DIR: profundidade X=100 e X=173
//   Frontal/Traseira: largura X=85 e X=165
//
// Furos nos painéis: Ø3.5mm a 10mm da borda topo/base
// Furos na tampa/base: Ø3.5mm a 10mm da borda de cada lado

// Parâmetros cantoneira
cant_larg = 20;       // Largura ao longo da parede (mm)
cant_h_prof = 15;     // Profundidade flange horizontal (mm)
cant_h_esp = 3;       // Espessura flange horizontal (mm)
cant_v_alt = 18;      // Altura flange vertical (mm)
cant_v_esp = 3;       // Espessura flange vertical (mm)
cant_furo_d = 3.5;    // Diâmetro furo M3 (com folga)
cant_porca_af = 5.5;  // Across-flats porca M3 hexagonal
cant_porca_h = 2.5;   // Altura porca M3
cant_gusset = 8;      // Tamanho do reforço triangular
cant_r = 1.5;         // Raio cantos arredondados

module cantoneira_tampa() {
    // L-bracket para fixação tampa/base nos painéis laterais
    // Orientação: flange horizontal no plano XY (plano Z=0)
    //             flange vertical sobe em Z a partir de Y=0
    
    difference() {
        union() {
            // ── FLANGE HORIZONTAL (sob a tampa) ──
            // Repousa contra a face inferior da tampa
            // X: 0..cant_larg, Y: 0..cant_h_prof, Z: 0..cant_h_esp
            hull() {
                translate([cant_r, cant_r, 0])
                    cylinder(h = cant_h_esp, r = cant_r, $fn = 20);
                translate([cant_larg - cant_r, cant_r, 0])
                    cylinder(h = cant_h_esp, r = cant_r, $fn = 20);
                translate([cant_r, cant_h_prof - cant_r, 0])
                    cylinder(h = cant_h_esp, r = cant_r, $fn = 20);
                translate([cant_larg - cant_r, cant_h_prof - cant_r, 0])
                    cylinder(h = cant_h_esp, r = cant_r, $fn = 20);
            }
            
            // ── FLANGE VERTICAL (contra painel interno) ──
            // Sobe de Z=0 até Z=cant_v_alt, na face Y=0
            // X: 0..cant_larg, Y: 0..cant_v_esp, Z: 0..cant_v_alt
            cube([cant_larg, cant_v_esp, cant_v_alt]);
            
            // ── REFORÇO TRIANGULAR (gusset) ──
            // No canto entre h-flange e v-flange
            hull() {
                translate([2, cant_v_esp, cant_h_esp])
                    cube([cant_larg - 4, 0.01, 0.01]);
                translate([2, cant_v_esp + cant_gusset, cant_h_esp])
                    cube([cant_larg - 4, 0.01, 0.01]);
                translate([2, cant_v_esp, cant_h_esp + cant_gusset])
                    cube([cant_larg - 4, 0.01, 0.01]);
            }
        }
        
        // ── FURO M3 FLANGE HORIZONTAL (parafuso pela tampa) ──
        // Centrado na flange horizontal
        translate([cant_larg/2, cant_h_prof/2, -0.1])
            cylinder(h = cant_h_esp + 0.2, d = cant_furo_d, $fn = 24);
        
        // Bolso hexagonal para porca M3 (topo do h-flange)
        translate([cant_larg/2, cant_h_prof/2, cant_h_esp - cant_porca_h])
            cylinder(h = cant_porca_h + 0.1, d = cant_porca_af / cos(30), $fn = 6);
        
        // ── FURO M3 FLANGE VERTICAL (parafuso pelo painel) ──
        // Centrado na flange vertical, a ~10mm do topo
        translate([cant_larg/2, -0.1, cant_v_alt - 10])
            rotate([-90, 0, 0])
                cylinder(h = cant_v_esp + 0.2, d = cant_furo_d, $fn = 24);
        
        // Bolso hexagonal para porca M3 (face interna do v-flange)
        translate([cant_larg/2, cant_v_esp - cant_porca_h, cant_v_alt - 10])
            rotate([-90, 0, 0])
                cylinder(h = cant_porca_h + 0.1, d = cant_porca_af / cos(30), $fn = 6);
    }
}

// === VEDAÇÃO PARA DIVISÓRIAS ===
// Frame que envolve a borda da divisória e veda contra as laterais
// PARTICIONADO EM 4 SEGMENTOS para caber na mesa 200×200mm
// Cada segmento: ~120mm × 6mm × 8mm (cabe facilmente)
// Encaixes dovetail nos cantos para montagem

// Parâmetros da divisória (244×240mm entre bases dos trilhos)
div_w = 244;   // largura X
div_h = 240;   // altura Y (entre bases dos trilhos)
frame_w = 6;   // Largura do frame
frame_h = 8;   // Altura (envolve a borda do MDF)
canal_frame = mdf + folga;  // Canal para o MDF

// Dovetail para cantos
dove_frame_l = 8;   // Comprimento do encaixe
dove_frame_w = 4;   // Largura na base
dove_frame_t = 6;   // Largura no topo (trapézio)

module dovetail_macho_frame() {
    hull() {
        cube([dove_frame_w, dove_frame_l, 0.1]);
        translate([-(dove_frame_t - dove_frame_w)/2, 0, frame_h - 0.1])
            cube([dove_frame_t, dove_frame_l, 0.1]);
    }
}

module dovetail_femea_frame() {
    folga_dove = 0.2;
    hull() {
        translate([-folga_dove, -0.1, -0.1])
            cube([dove_frame_w + folga_dove*2, dove_frame_l + 0.2, 0.1]);
        translate([-(dove_frame_t - dove_frame_w)/2 - folga_dove, -0.1, frame_h + 0.1])
            cube([dove_frame_t + folga_dove*2, dove_frame_l + 0.2, 0.1]);
    }
}

// Segmento horizontal (topo ou base) - comp ~122mm (metade de 244)
module vedacao_segmento_h(comprimento, com_macho_esq=true, com_macho_dir=true) {
    difference() {
        union() {
            // Barra horizontal
            cube([comprimento, frame_w, frame_h]);
            
            // Canal para MDF (rebaixo no centro)
        }
        
        // Canal para o MDF
        translate([-0.1, (frame_w - canal_frame)/2, (frame_h - canal_frame)/2])
            cube([comprimento + 0.2, canal_frame, canal_frame]);
        
        // Dovetail fêmea esquerda (se não tiver macho)
        if (!com_macho_esq) {
            translate([0, frame_w/2 - dove_frame_l/2, 0])
                dovetail_femea_frame();
        }
        
        // Dovetail fêmea direita
        if (!com_macho_dir) {
            translate([comprimento - dove_frame_w, frame_w/2 - dove_frame_l/2, 0])
                dovetail_femea_frame();
        }
    }
    
    // Dovetail macho esquerda
    if (com_macho_esq) {
        translate([-dove_frame_w, frame_w/2 - dove_frame_l/2, 0])
            dovetail_macho_frame();
    }
    
    // Dovetail macho direita
    if (com_macho_dir) {
        translate([comprimento, frame_w/2 - dove_frame_l/2, 0])
            dovetail_macho_frame();
    }
    
    // Lábio de vedação
    translate([0, frame_w - labio_esp, 0])
        cube([comprimento, labio_esp, labio_esp]);
    translate([0, frame_w - labio_esp, frame_h - labio_esp])
        cube([comprimento, labio_esp, labio_esp]);
}

// Segmento vertical (esquerda ou direita) - comp ~120mm (metade de 240)
module vedacao_segmento_v(comprimento, com_macho_base=true, com_macho_topo=true) {
    difference() {
        union() {
            // Barra vertical
            cube([frame_w, comprimento, frame_h]);
        }
        
        // Canal para o MDF
        translate([(frame_w - canal_frame)/2, -0.1, (frame_h - canal_frame)/2])
            cube([canal_frame, comprimento + 0.2, canal_frame]);
        
        // Dovetail fêmea base
        if (!com_macho_base) {
            translate([frame_w/2 - dove_frame_w/2, 0, 0])
            rotate([0, 0, 90])
            translate([-dove_frame_w, 0, 0])
                dovetail_femea_frame();
        }
        
        // Dovetail fêmea topo
        if (!com_macho_topo) {
            translate([frame_w/2 - dove_frame_w/2, comprimento - dove_frame_l, 0])
            rotate([0, 0, 90])
            translate([-dove_frame_w, 0, 0])
                dovetail_femea_frame();
        }
    }
    
    // Dovetail macho base
    if (com_macho_base) {
        translate([frame_w/2 + dove_frame_l/2, -dove_frame_w, 0])
        rotate([0, 0, 90])
            dovetail_macho_frame();
    }
    
    // Dovetail macho topo
    if (com_macho_topo) {
        translate([frame_w/2 + dove_frame_l/2, comprimento, 0])
        rotate([0, 0, 90])
            dovetail_macho_frame();
    }
    
    // Lábio de vedação
    translate([frame_w - labio_esp, 0, 0])
        cube([labio_esp, comprimento, labio_esp]);
    translate([frame_w - labio_esp, 0, frame_h - labio_esp])
        cube([labio_esp, comprimento, labio_esp]);
}

// 8 segmentos para montar frame completo (4 lados × 2 metades)
// Horizontais: 122mm cada (244/2)
// Verticais: 120mm cada (240/2)
module vedacao_segmento_h_a() { vedacao_segmento_h(122, com_macho_esq=false, com_macho_dir=true); }
module vedacao_segmento_h_b() { vedacao_segmento_h(122, com_macho_esq=false, com_macho_dir=false); }
module vedacao_segmento_v_a() { vedacao_segmento_v(120, com_macho_base=false, com_macho_topo=true); }
module vedacao_segmento_v_b() { vedacao_segmento_v(120, com_macho_base=false, com_macho_topo=false); }

// Módulo para visualização do frame completo montado
module vedacao_divisoria_montada() {
    // Base (2 segmentos)
    color("LimeGreen") vedacao_segmento_h_a();
    color("LimeGreen") translate([122, 0, 0]) vedacao_segmento_h_b();
    
    // Topo (2 segmentos)
    color("Lime") translate([0, div_h - frame_w, 0]) vedacao_segmento_h_a();
    color("Lime") translate([122, div_h - frame_w, 0]) vedacao_segmento_h_b();
    
    // Esquerda (2 segmentos)
    color("DodgerBlue") translate([0, frame_w, 0]) vedacao_segmento_v_a();
    color("DodgerBlue") translate([0, frame_w + 120, 0]) vedacao_segmento_v_b();
    
    // Direita (2 segmentos)
    color("DeepSkyBlue") translate([div_w - frame_w, frame_w, 0]) vedacao_segmento_v_a();
    color("DeepSkyBlue") translate([div_w - frame_w, frame_w + 120, 0]) vedacao_segmento_v_b();
}

// Layout de impressão - 8 segmentos em 1 batch (cabe em 200×200mm)
// Horizontais: 122mm × 6mm × 4 peças = ~130mm × ~30mm
// Verticais: 120mm × 6mm × 4 peças = ~130mm × ~30mm
// Total: ~130mm × 65mm ✓
module vedacao_print_batch() {
    gap = 4;
    
    // 4 horizontais (2 topo + 2 base)
    for (i = [0:1]) {
        translate([0, i * (frame_w + gap), 0])
            vedacao_segmento_h_a();
        translate([0, (2 + i) * (frame_w + gap), 0])
            vedacao_segmento_h_b();
    }
    
    // 4 verticais (2 esquerda + 2 direita) - rotacionadas para Y
    for (i = [0:1]) {
        translate([0, (4 + i) * (frame_w + gap), 0])
        rotate([0, 0, -90])
        translate([-120, 0, 0])
            vedacao_segmento_v_a();
        translate([0, (6 + i) * (frame_w + gap), 0])
        rotate([0, 0, -90])
        translate([-120, 0, 0])
            vedacao_segmento_v_b();
    }
}

// Versão antiga (para referência) - NÃO USAR, não cabe em 200×200
module vedacao_divisoria_OLD() {
    difference() {
        // Frame externo
        union() {
            // Lado esquerdo
            translate([0, 0, 0])
                cube([frame_w, div_h, frame_h]);
            // Lado direito
            translate([div_w - frame_w, 0, 0])
                cube([frame_w, div_h, frame_h]);
            // Topo
            translate([0, div_h - frame_w, 0])
                cube([div_w, frame_w, frame_h]);
            // Base (com abertura central para fluxo)
            translate([0, 0, 0])
                cube([div_w, frame_w, frame_h]);
        }
        
        // Canal para o MDF (centro do frame)
        translate([-0.1, -0.1, (frame_h - canal_frame)/2])
            cube([div_w + 0.2, div_h + 0.2, canal_frame]);
        
        // Abertura central (o furo da divisória)
        translate([frame_w + 5, frame_w + 5, -0.1])
            cube([div_w - 2*frame_w - 10, div_h - 2*frame_w - 10, frame_h + 0.2]);
    }
    
    // Lábios de vedação nas faces internas
    for (face = [0, 1]) {
        z_pos = face * (frame_h - labio_esp);
        // Esquerda
        translate([frame_w - labio_esp, frame_w, z_pos])
            cube([labio_esp, div_h - 2*frame_w, labio_esp]);
        // Direita
        translate([div_w - frame_w, frame_w, z_pos])
            cube([labio_esp, div_h - 2*frame_w, labio_esp]);
        // Topo
        translate([frame_w, div_h - frame_w, z_pos])
            cube([div_w - 2*frame_w, labio_esp, labio_esp]);
        // Base
        translate([frame_w, frame_w - labio_esp, z_pos])
            cube([div_w - 2*frame_w, labio_esp, labio_esp]);
    }
}

// === CLIP RETENÇÃO FILTRO PARA DIVISÓRIAS (PARAFUSO M3) ===
// Design estilo clip HVAC comercial (referência foto)
// Perfil Z: base parafusada → braço vertical → aba SOBRE o filtro
//
// Vista lateral (perfil Z):
//
//   aba ←←←←
//            ↑
//       braço ↑     FILTRO contra o MDF
//            ↑
//            └→→→→→→→ base (parafuso M3 aqui)
//                      ▓▓ FRAME MDF ▓▓
//
// A aba estende-se sobre o filtro (direção -Y)
// A base repousa no frame MDF (direção +Y)
// Braço vertical = espessura_filtro + MDF (3mm)
// Parametrizado: cada filtro tem espessura diferente
//
// Detalhes construtivos (inspirado na foto):
//   • Base com cantos arredondados (r=1.5mm)
//   • Filete triangular base→braço (reforço estrutural)
//   • Filete triangular braço→aba (reforço menor)
//   • Chanfro na ponta da aba (rampa para encaixe do filtro)
//   • Escareado para cabeça do parafuso
//
// Qtd: 8+8+4+8 = 28 clips retenção total
//
// Posições M3 por divisória (coordenadas NC):
//   Manta G3 (abertura 200×200mm, 8 clips):
//     (12,80)(12,160)(232,80)(232,160)(88,10)(156,10)(88,230)(156,230)
//   GM Cabine (abertura 212×200mm reduzida, 8 clips):
//     (8,80)(8,160)(236,80)(236,160)(82,10)(162,10)(82,230)(162,230)
//   Wega (abertura 223×160mm, 4 clips só topo/base):
//     (82,20)(162,20)(82,220)(162,220)
//   HEPA (abertura 100×130mm reduzida, 8 clips):
//     (57,100)(57,140)(187,100)(187,140)(105,40)(139,40)(105,200)(139,200)

// Parâmetros clip retenção filtro (comuns)
ret_largura = 20;     // Largura do clip X (mm)
ret_base_comp = 15;   // Comprimento da base Y (sobre o frame MDF)
ret_base_esp = 3;     // Espessura da base Z
ret_braco_esp = 2.5;  // Espessura do braço vertical Y (2.5mm p/ rigidez)
ret_aba_comp = 10;    // Comprimento da aba (projeção sobre o filtro)
ret_aba_esp = 2;      // Espessura da aba de retenção
ret_furo_d = 3.5;     // Diâmetro do furo M3 (com folga)
ret_r_base = 1.5;     // Raio cantos arredondados da base
ret_gusset = 5;       // Tamanho do reforço triangular base→braço
ret_chanfro = 2;      // Comprimento do chanfro na ponta da aba

// Módulo parametrizado — espessura_filtro determina altura do braço
module clip_parafuso_filtro(espessura_filtro = 10) {
    braco_alt = espessura_filtro + mdf;  // filtro + MDF 3mm
    z_aba = ret_base_esp + braco_alt - ret_aba_esp;  // Z base da aba
    gusset_b = min(ret_gusset, braco_alt * 0.6);     // gusset proporcional
    gusset_a = min(3, braco_alt * 0.4);              // gusset aba menor
    
    difference() {
        union() {
            // ── BASE COM CANTOS ARREDONDADOS ──
            // Placa horizontal parafusada no frame MDF
            // Y vai de 0 (borda interna, junto ao braço) a ret_base_comp
            hull() {
                translate([ret_r_base, ret_r_base, 0])
                    cylinder(h = ret_base_esp, r = ret_r_base, $fn = 24);
                translate([ret_largura - ret_r_base, ret_r_base, 0])
                    cylinder(h = ret_base_esp, r = ret_r_base, $fn = 24);
                translate([ret_r_base, ret_base_comp - ret_r_base, 0])
                    cylinder(h = ret_base_esp, r = ret_r_base, $fn = 24);
                translate([ret_largura - ret_r_base, ret_base_comp - ret_r_base, 0])
                    cylinder(h = ret_base_esp, r = ret_r_base, $fn = 24);
            }
            
            // ── BRAÇO VERTICAL ──
            // Sobe da borda interna (Y=0), contínuo desde Z=0 até topo
            cube([ret_largura, ret_braco_esp, ret_base_esp + braco_alt]);
            
            // ── ABA DE RETENÇÃO (estende SOBRE o filtro, direção -Y) ──
            // Projeta ret_aba_comp além da face interna do braço
            // De Y = -(ret_aba_comp - ret_braco_esp) até Y = ret_braco_esp
            translate([0, -(ret_aba_comp - ret_braco_esp), z_aba])
                cube([ret_largura, ret_aba_comp, ret_aba_esp]);
            
            // ── CHANFRO NA PONTA DA ABA ──
            // Rampa suave para facilitar inserção/remoção do filtro
            // Afina de ret_aba_esp para ~40% nos últimos ret_chanfro mm
            hull() {
                // Seção completa (onde chanfro começa)
                translate([0, -(ret_aba_comp - ret_braco_esp - ret_chanfro), z_aba])
                    cube([ret_largura, 0.01, ret_aba_esp]);
                // Ponta afinada (tip)
                translate([0, -(ret_aba_comp - ret_braco_esp), z_aba + ret_aba_esp * 0.6])
                    cube([ret_largura, 0.01, ret_aba_esp * 0.4]);
            }
            
            // ── REFORÇO BASE→BRAÇO (gusset triangular) ──
            // Triângulo estrutural no canto interno base/braço (lado frame)
            // Visível na foto como reforço diagonal
            hull() {
                translate([2, ret_braco_esp, ret_base_esp])
                    cube([ret_largura - 4, 0.01, 0.01]);
                translate([2, ret_braco_esp + gusset_b, ret_base_esp])
                    cube([ret_largura - 4, 0.01, 0.01]);
                translate([2, ret_braco_esp, ret_base_esp + gusset_b])
                    cube([ret_largura - 4, 0.01, 0.01]);
            }
            
            // ── REFORÇO BRAÇO→ABA (gusset menor) ──
            // Triângulo no canto interno braço/aba (lado filtro)
            hull() {
                translate([3, 0, z_aba])
                    cube([ret_largura - 6, 0.01, 0.01]);
                translate([3, -gusset_a, z_aba])
                    cube([ret_largura - 6, 0.01, 0.01]);
                translate([3, 0, z_aba - gusset_a])
                    cube([ret_largura - 6, 0.01, 0.01]);
            }
        }
        
        // ── FURO M3 PASSANTE (centro da base) ──
        translate([ret_largura/2, ret_base_comp/2, -0.1])
            cylinder(h = ret_base_esp + 0.2, d = ret_furo_d, $fn = 32);
        
        // ── ESCAREADO PARA CABEÇA DO PARAFUSO ──
        translate([ret_largura/2, ret_base_comp/2, ret_base_esp - 1.2])
            cylinder(h = 1.3, d1 = ret_furo_d, d2 = 6.5, $fn = 32);
    }
}

// === MÓDULOS DE CONVENIÊNCIA POR TIPO DE FILTRO ===
module clip_manta()  { clip_parafuso_filtro(10); }  // braço 13mm (Manta G3, 10mm)
module clip_gm()     { clip_parafuso_filtro(20); }  // braço 23mm (GM Cabine, 20mm)
module clip_wega()   { clip_parafuso_filtro(10); }  // braço 13mm (Wega, 10mm)
module clip_hepa()   { clip_parafuso_filtro(2); }   // braço 5mm  (HEPA borda 2mm)

// === RENDER ===
// Cantoneira individual (fixação tampa/base)
cantoneira_tampa();

// Visualização: clips retenção filtro por tipo (deslocados)
// Offset Y=8 para compensar aba que estende em -Y
translate([80, 8, 0])
    clip_manta();   // braço 13mm (Manta G3 / Wega 10mm)

translate([108, 8, 0])
    clip_gm();      // braço 23mm (GM Cabine 20mm)

translate([136, 8, 0])
    clip_hepa();    // braço 5mm (HEPA borda 2mm)

// Visualização: frame vedação divisória MONTADO (deslocado, escala 0.3)
translate([0, 60, 0])
    scale(0.3)
        vedacao_divisoria_montada();

// Texto informativo (não renderiza, só comentário)
// Impressão recomendada:
// - Material: PETG (melhor flexibilidade) ou PLA
// - Layer: 0.2mm
// - Infill: 80-100%
// - Walls: 3 perímetros mínimo
// - Qtd cantoneiras: 16 unidades (8 tampa + 8 base)
// - Qtd clips retenção filtro: 28 unidades (arquivos separados)
//     PRINT_CLIP_MANTA.scad — 8× braço 13mm
//     PRINT_CLIP_GM.scad    — 8× braço 23mm
//     PRINT_CLIP_WEGA.scad  — 4× braço 13mm
//     PRINT_CLIP_HEPA.scad  — 8× braço 5mm
// - Hardware cantoneiras: 32× M3×8mm + 32× porca M3
// - Hardware filtros: 28× M3 + 28× porca M3
