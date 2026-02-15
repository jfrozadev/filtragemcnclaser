// ============================================================
// CLIP DE RETENÇÃO PARA MANTA G3
// Impressão 3D - PLA/PETG (Ender 3)
// ============================================================
//
// CONCEITO: Clips que prendem a manta G3 (10mm) na borda
// do furo 200×200mm do MDF da divisória.
//
// O clip abraça a borda do MDF (3mm) e tem uma aba que
// pressiona a manta contra o MDF. Para trocar a manta:
// aperta a lingueta flexível e puxa o clip.
//
// FIXAÇÃO: O clip tem 2 dentes snap-fit que passam por
// slots cortados no MDF na borda do furo.
//
// QUANTIDADE: 8 clips (2 por lado do furo)
//
// VISTA LATERAL (corte):
//
//   ┌── aba retenção (prensa manta) ──┐
//   │         manta G3 10mm           │
//   ╞═══MDF══[entalhe]════════════════╡  ← entalhe 30×2mm no MDF
//            │  base (sob o MDF)       │
//            └── dente ────── dente ───┘
//
// SEÇÃO DO CLIP:
//   Topo: aba 15mm sobre a manta (prensa para baixo)
//   Meio: parede (2mm) passa pelo entalhe na borda do furo
//   Base: 8mm por baixo do MDF com dentes snap-fit
//
// MONTAGEM:
//   1. Incline o clip pela abertura do furo
//   2. Deslize a base por baixo do MDF (área sólida)
//   3. A parede passa pelo entalhe 30×2mm na borda
//   4. Dentes clicam nos slots do MDF
//   5. Aba prensa a manta por cima
//
// ============================================================

// === PARÂMETROS ===
mdf = 3;            // Espessura MDF
folga = 0.3;        // Folga de encaixe
manta_esp = 10;     // Espessura da manta G3

// Clip
clip_larg = 30;     // Largura do clip ao longo da borda
clip_parede = 2;    // Espessura das paredes
aba_comp = 15;      // Comprimento da aba sobre a manta
aba_esp = 1.5;      // Espessura da aba (flexível, prensa a manta)
base_prof = 8;      // Profundidade da base por baixo do MDF

// Snap-fit
dente_h = 1.2;      // Altura do dente (entra no slot MDF)
dente_w = 8;        // Largura do dente
dente_pos1 = 7;     // Posição do dente 1 (distância do centro)
dente_pos2 = 7;     // Simétrico

// Slot no MDF (cortado CNC)
slot_w = 10;        // Largura do slot = dente_w + 2mm folga
slot_h = 2;         // Altura do slot = dente_h + folga
// 2 slots por clip, 8 clips = 16 slots no MDF

// Entalhe no MDF para parede do clip (CNC)
// Retângulo clip_larg × clip_parede na borda do furo
// 8 entalhes (1 por clip) — sem eles a parede colide com o MDF
entalhe_w    = clip_larg;   // 30mm (largura do clip)
entalhe_prof = clip_parede; // 2mm (espessura da parede)

// === MÓDULO PRINCIPAL ===
module clip_manta() {
    // O clip é orientado assim:
    // X = largura (30mm ao longo da borda)
    // Y = profundidade (base→aba)
    // Z = altura (de baixo do MDF para cima)
    //
    // Z=0 = face inferior do MDF
    // Z=mdf = face superior do MDF (onde a manta fica)
    // Z=mdf+manta_esp = topo da manta

    difference() {
        union() {
            // --- BASE (por baixo do MDF) ---
            // Placa que fica embaixo do MDF, segura o clip
            cube([clip_larg, base_prof, clip_parede]);
            
            // --- PAREDE VERTICAL (borda do furo) ---
            // Sobe pelo furo, abraçando a borda do MDF
            cube([clip_larg, clip_parede, mdf + manta_esp + aba_esp]);
            
            // --- ABA DE RETENÇÃO (sobre a manta) ---
            // Aba que prensa a manta contra o MDF
            // Posição: no topo da manta, avança sobre ela
            translate([0, 0, mdf + manta_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            
            // --- RAMPA DE ENTRADA ---
            // Chanfro na ponta da aba para facilitar encaixe da manta
            translate([0, aba_comp - 0.1, mdf + manta_esp])
            hull() {
                cube([clip_larg, 0.1, aba_esp]);
                translate([0, 3, aba_esp + 2])
                    cube([clip_larg, 0.1, 0.1]);
            }
            
            // --- DENTES SNAP-FIT (2 por clip) ---
            // Sobem a partir da base para engatar nos slots do MDF
            translate([clip_larg/2 - dente_pos1 - dente_w/2, base_prof, 0])
                dente_snap();
            translate([clip_larg/2 + dente_pos2 - dente_w/2, base_prof, 0])
                dente_snap();
        }
        
        // --- CANAL de flexão na aba ---
        // Permite que a aba flexione para acomodar variação de espessura
        translate([clip_parede + 2, clip_parede, mdf + manta_esp - 0.1])
            cube([clip_larg - 2*clip_parede - 4, aba_comp - clip_parede - 5, 0.8]);
    }
}

// Dente snap-fit
module dente_snap() {
    // Rampa de entrada (facilita encaixe)
    hull() {
        cube([dente_w, 0.1, clip_parede]);
        translate([0, dente_h, 0])
            cube([dente_w, 0.1, clip_parede + dente_h]);
    }
    // Face de retenção (plana, trava no slot)
    translate([0, dente_h, 0])
        cube([dente_w, 0.4, clip_parede + dente_h]);
}

// === VISUALIZAÇÃO ===

// Clip orientado para impressão (base na mesa, Z=0)
clip_manta();

// MDF fantasma para referência visual
%translate([-5, -2, 0])
    cube([clip_larg + 10, base_prof + aba_comp + 10, mdf]);

// Manta fantasma
%translate([-5, -2, mdf])
    color("LimeGreen", 0.3)
        cube([clip_larg + 10, aba_comp + 10, manta_esp]);
