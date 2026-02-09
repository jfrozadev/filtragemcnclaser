// ==========================================
// SNAP-FIT CLIP PARA TAMPA E BASE - CAIXA DE FILTRAGEM
// Impressão 3D - PLA/PETG (Ender 3)
// ==========================================
// 16 clips: 8 tampa (topo) + 8 base (inferior)
// Encaixam na tampa/base (3mm) e travam na borda lateral/frontal/traseira
// Vedação com lábio flexível
// Pé dobrado: altura 30mm (ext) / 24mm (int)
// Requer slots 22×2mm cortados no MDF a 30mm da borda
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
slot_pos_borda = 30; // Distância do gancho até a borda (= altura_ext)

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
module vedacao_divisoria() {
    // Parâmetros da divisória
    div_size = 244;
    aba = 5;
    
    frame_w = 6;   // Largura do frame
    frame_h = 8;   // Altura (envolve a borda do MDF)
    canal = mdf + folga;  // Canal para o MDF
    
    difference() {
        // Frame externo
        union() {
            // Lado esquerdo
            translate([0, 0, 0])
                cube([frame_w, div_size, frame_h]);
            // Lado direito
            translate([div_size - frame_w, 0, 0])
                cube([frame_w, div_size, frame_h]);
            // Topo
            translate([0, div_size - frame_w, 0])
                cube([div_size, frame_w, frame_h]);
            // Base (com abertura central para fluxo)
            translate([0, 0, 0])
                cube([div_size, frame_w, frame_h]);
        }
        
        // Canal para o MDF (centro do frame)
        translate([-0.1, -0.1, (frame_h - canal)/2])
            cube([div_size + 0.2, div_size + 0.2, canal]);
        
        // Abertura central (o furo da divisória)
        translate([frame_w + 5, frame_w + 5, -0.1])
            cube([div_size - 2*frame_w - 10, div_size - 2*frame_w - 10, frame_h + 0.2]);
    }
    
    // Lábios de vedação nas faces internas
    for (face = [0, 1]) {
        z_pos = face * (frame_h - labio_esp);
        // Esquerda
        translate([frame_w - labio_esp, frame_w, z_pos])
            cube([labio_esp, div_size - 2*frame_w, labio_esp]);
        // Direita
        translate([div_size - frame_w, frame_w, z_pos])
            cube([labio_esp, div_size - 2*frame_w, labio_esp]);
        // Topo
        translate([frame_w, div_size - frame_w, z_pos])
            cube([div_size - 2*frame_w, labio_esp, labio_esp]);
        // Base
        translate([frame_w, frame_w - labio_esp, z_pos])
            cube([div_size - 2*frame_w, labio_esp, labio_esp]);
    }
}

// === RENDER ===
// Clip individual (tampa/base - mesmo clip para ambos)
snap_clip_tampa();

// Visualização: clip de canto (deslocado)
translate([40, 0, 0])
    snap_clip_canto();

// Visualização: frame vedação divisória (deslocado, escala reduzida)
translate([0, 50, 0])
    scale(0.2)
        vedacao_divisoria();

// Texto informativo (não renderiza, só comentário)
// Impressão recomendada:
// - Material: PETG (melhor flexibilidade) ou PLA
// - Layer: 0.2mm
// - Infill: 80-100%
// - Walls: 3 perímetros mínimo
// - Orientação: clip deitado, ponte para cima
// - Qtd: 16 unidades (8 topo + 8 base)
