// ==========================================
// SNAP-FIT CLIP PARA TAMPA E BASE - CAIXA DE FILTRAGEM
// + CLIP RETENÇÃO FILTRO (PARAFUSO M3) PARA DIVISÓRIAS
// Impressão 3D - PLA/PETG (Ender 3)
// ==========================================
// SISTEMA HÍBRIDO:
// - 16 clips snap-fit: 8 tampa (topo) + 8 base (inferior)
//   Encaixam na tampa/base (3mm) e travam na borda lateral/frontal/traseira
// - 28 clips retenção filtro (parafuso M3×10mm):
//     8× Manta G3  (10mm espessura, braço 13mm)
//     8× GM Cabine  (20mm espessura, braço 23mm)
//     4× Wega        (10mm espessura, braço 13mm, só topo/base)
//     8× HEPA        (25mm espessura, braço 28mm)
//   Perfil Z: base parafusada no frame MDF → braço vertical →
//   aba horizontal pressiona filtro contra a divisória
// ==========================================

// Parâmetros da caixa
mdf = 3;          // Espessura MDF
folga = 0.3;      // Folga para encaixe
parede = 2;       // Espessura da parede do clip

// Parâmetros do clip
largura_clip = 20;   // Largura do clip ao longo da borda
altura_ext = 30;     // Altura externa (pé dobrado, desce pelo lado externo)
altura_int = 24;     // Altura interna (pé dobrado, desce por dentro da caixa)
gancho = 1.2;        // Profundidade do gancho snap-fit
angulo_gancho = 45;  // Ângulo da rampa de entrada

// Slot no MDF para o gancho
slot_largura = 22;   // 20mm clip + 2mm folga
slot_altura = 2;     // 1.2mm gancho + folga
slot_pos_borda = 27; // Distância do gancho até a borda LATERAL (altura_ext - mdf = 30 - 3 = 27mm)

// Lábio de vedação
labio_h = 1.5;    // Altura do lábio
labio_esp = 0.8;  // Espessura do lábio (flexível)

module snap_clip_tampa() {
    // Parte que abraça a borda (U invertido)
    difference() {
        union() {
            // Parte superior (sobre a tampa)
            translate([0, 0, 0])
                cube([largura_clip, mdf + folga + 2*parede, parede]);
            
            // Parede externa (desce por fora da caixa)
            translate([0, 0, -altura_ext])
                cube([largura_clip, parede, altura_ext + parede]);
            
            // Parede interna (desce por dentro da caixa)
            translate([0, mdf + folga + parede, -altura_int])
                cube([largura_clip, parede, altura_int + parede]);
            
            // Gancho externo (snap-fit)
            translate([0, 0, -altura_ext])
                gancho_snap(largura_clip, parede, gancho, angulo_gancho);
            
            // Gancho interno (snap-fit)
            translate([0, mdf + folga + parede, -altura_int])
                mirror([0, 1, 0])
                    gancho_snap(largura_clip, parede, gancho * 0.8, angulo_gancho);
            
            // Lábio de vedação (interno, flexível)
            translate([0, parede, -labio_h])
                cube([largura_clip, mdf + folga, labio_esp]);
        }
        
        // Canal para facilitar flexão do lábio
        translate([largura_clip/2, parede + (mdf+folga)/2, -labio_h - 0.1])
            cube([largura_clip - 4, mdf + folga - 1, labio_esp + 0.2], center=true);
    }
}

module gancho_snap(w, wall_t, hook_d, angle) {
    // Rampa de entrada + gancho de retenção
    hull() {
        cube([w, wall_t, 0.1]);
        translate([0, -hook_d, 0])
            cube([w, 0.1, hook_d / tan(angle)]);
    }
    // Gancho de retenção (face plana para travar)
    translate([0, -hook_d, 0])
        cube([w, hook_d, 0.6]);
}

// === CLIP PARA CANTOS (L-shaped) ===
// Para os 4 cantos da caixa onde lateral encontra frontal/traseira
module snap_clip_canto() {
    snap_clip_tampa();
    
    // Extensão em L para o canto
    translate([largura_clip, 0, 0])
    rotate([0, 0, 90])
        snap_clip_tampa();
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
// Perfil Z: base parafusada → braço vertical → aba sobre o filtro
// Braço vertical = espessura_filtro + MDF (3mm)
// Parametrizado: cada filtro tem espessura diferente
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
ret_largura = 20;     // Largura do clip (mm)
ret_base_comp = 15;   // Comprimento da base (sobre o frame MDF)
ret_base_esp = 3;     // Espessura da base (sobre o MDF)
ret_braco_esp = 2;    // Espessura do braço vertical
ret_aba_comp = 10;    // Comprimento da aba (sobre o filtro)
ret_aba_esp = 2;      // Espessura da aba de retenção
ret_furo_d = 3.5;     // Diâmetro do furo M3 (com folga)

// Módulo parametrizado — espessura_filtro determina altura do braço
module clip_parafuso_filtro(espessura_filtro = 10) {
    braco_alt = espessura_filtro + mdf;  // filtro + MDF 3mm
    
    difference() {
        union() {
            // Base horizontal (parafusada no frame MDF ao redor da abertura)
            cube([ret_largura, ret_base_comp, ret_base_esp]);
            
            // Braço vertical (sobe da borda interna da base)
            translate([0, 0, ret_base_esp])
                cube([ret_largura, ret_braco_esp, braco_alt]);
            
            // Aba de retenção (se estende sobre o filtro, pressiona)
            translate([0, 0, ret_base_esp + braco_alt - ret_aba_esp])
                cube([ret_largura, ret_aba_comp, ret_aba_esp]);
            
            // Reforço (gusset entre base e braço)
            hull() {
                translate([2, ret_braco_esp, ret_base_esp])
                    cube([ret_largura - 4, 4, 0.1]);
                translate([2, ret_braco_esp, ret_base_esp])
                    cube([ret_largura - 4, 0.1, 4]);
            }
        }
        
        // Furo para parafuso M3 (passante na base)
        translate([ret_largura/2, ret_base_comp/2, -0.1])
            cylinder(h = ret_base_esp + 0.2, d = ret_furo_d, $fn = 24);
        
        // Rebaixo para cabeça do parafuso (escareado)
        translate([ret_largura/2, ret_base_comp/2, ret_base_esp - 1.5])
            cylinder(h = 1.6, d1 = ret_furo_d, d2 = 6.5, $fn = 24);
    }
}

// === MÓDULOS DE CONVENIÊNCIA POR TIPO DE FILTRO ===
module clip_manta()  { clip_parafuso_filtro(10); }  // braço 13mm
module clip_gm()     { clip_parafuso_filtro(20); }  // braço 23mm
module clip_wega()   { clip_parafuso_filtro(10); }  // braço 13mm
module clip_hepa()   { clip_parafuso_filtro(25); }  // braço 28mm

// === RENDER ===
// Clip individual (tampa/base - mesmo clip para ambos)
snap_clip_tampa();

// Visualização: clip de canto (deslocado)
translate([40, 0, 0])
    snap_clip_canto();

// Visualização: clips retenção filtro por tipo (deslocados)
translate([80, 0, 0])
    clip_manta();   // braço 13mm (Manta G3 / Wega 10mm)

translate([105, 0, 0])
    clip_gm();      // braço 23mm (GM Cabine 20mm)

translate([130, 0, 0])
    clip_hepa();    // braço 28mm (HEPA 25mm)

// Visualização: frame vedação divisória MONTADO (deslocado, escala 0.3)
translate([0, 50, 0])
    scale(0.3)
        vedacao_divisoria_montada();

// Visualização: batch de impressão da vedação (deslocado)
translate([0, 120, 0])
    scale(0.5)
        vedacao_print_batch();

// Texto informativo (não renderiza, só comentário)
// Impressão recomendada:
// - Material: PETG (melhor flexibilidade) ou PLA
// - Layer: 0.2mm
// - Infill: 80-100%
// - Walls: 3 perímetros mínimo
// - Orientação: clip deitado, ponte para cima
// - Qtd clips snap-fit: 16 unidades (8 topo + 8 base)
// - Qtd clips retenção filtro: 28 unidades
//     8× Manta (braço 13mm) + 8× GM (braço 23mm)
//     4× Wega (braço 13mm) + 8× HEPA (braço 28mm)
// - Parafusos: 28× M3×10mm + 28× porca M3
// - Qtd vedação: 8 segmentos por divisória (opcional)
//
// LAYOUT IMPRESSÃO CLIPS (200×200mm):
//   16 snap-fit + 28 retenção = 44 clips total
//   Snap-fit: 4 fileiras × 4 colunas = ~92mm × 45mm
//   Retenção: agrupados por altura (3 tamanhos diferentes)
//
// LAYOUT IMPRESSÃO VEDAÇÃO (200×200mm):
//   8 segmentos (~122mm × 6mm cada)
//   Deitados lado a lado = ~130mm × 65mm ✓
