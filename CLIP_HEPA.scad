// ============================================================
// CLIP DE RETENÇÃO PARA FILTRO HEPA
// Impressão 3D - PLA/PETG (Ender 3)
// ============================================================
//
// CONCEITO: Clips que seguram o filtro HEPA pela borda (rim)
// contra o MDF da divisória. A borda do filtro repousa sobre
// o MDF ao redor do furo 100×130mm, e os clips prendem por cima.
//
// FILTRO HEPA:
//   Externo: ~110×140mm
//   Borda (rim): 5mm de largura, 2mm de espessura
//   Corpo: 25mm de profundidade (passa pelo furo)
//   Furo MDF: 100×130mm (borda de 5mm repousa no MDF)
//
// FIXAÇÃO: 2 dentes snap-fit por clip, passam por slots
// cortados no MDF a 8mm da borda do furo.
//
// QUANTIDADE: 8 clips (2 por lado do furo)
//
// VISTA LATERAL (corte):
//
//   ┌── aba (sobre borda HEPA) ──┐
//   │    borda 5mm, 2mm esp      │
//   ╞═══MDF══[entalhe]═══════════╡  ← entalhe 25×2mm no MDF
//            │  base (sob o MDF)  │
//            └── dente ── dente ──┘
//
// MONTAGEM:
//   1. Incline o clip pela abertura do furo
//   2. Deslize a base por baixo do MDF (área sólida)
//   3. A parede passa pelo entalhe 25×2mm na borda
//   4. Dentes clicam nos slots do MDF
//   5. Aba retém a borda do filtro HEPA por cima
//
// ============================================================

// === PARÂMETROS ===
mdf = 3;              // Espessura MDF
folga = 0.3;          // Folga de encaixe

// HEPA
hepa_borda_esp = 2;   // Espessura da borda do filtro HEPA
hepa_borda_larg = 5;  // Largura da borda (rim)

// Clip
clip_larg = 25;       // Largura do clip ao longo da borda
clip_parede = 2;      // Espessura das paredes
aba_comp = 7;         // Comprimento da aba (5mm borda + 2mm garra)
aba_esp = 1.2;        // Espessura da aba (flexível)
base_prof = 8;        // Profundidade da base por baixo do MDF

// Snap-fit
dente_h = 1.2;        // Altura do dente
dente_w = 8;          // Largura do dente
dente_pos1 = 6;       // Posição dente 1 (do centro do clip)
dente_pos2 = 6;       // Simétrico

// Slot no MDF (cortado CNC)
slot_w = 10;          // Largura do slot (dente_w + 2mm folga)
slot_h = 2;           // Altura do slot (dente_h + folga)
// 2 slots por clip × 8 clips = 16 slots

// Entalhe no MDF para parede do clip (CNC)
entalhe_w    = clip_larg;   // 25mm (largura do clip)
entalhe_prof = clip_parede; // 2mm (espessura da parede)

// === MÓDULO PRINCIPAL ===
module clip_hepa() {
    // X = largura (25mm ao longo da borda)
    // Y = profundidade (base → aba, perpendicular ao furo)
    // Z = altura (de baixo do MDF para cima)
    //
    // Z=0 = face inferior do MDF
    // Z=mdf = face superior do MDF (onde borda HEPA repousa)
    // Z=mdf+hepa_borda_esp = topo da borda HEPA

    difference() {
        union() {
            // --- BASE (por baixo do MDF) ---
            cube([clip_larg, base_prof, clip_parede]);

            // --- PAREDE VERTICAL (borda do furo) ---
            // Sobe pela borda, abraçando o MDF
            cube([clip_larg, clip_parede, mdf + hepa_borda_esp + aba_esp]);

            // --- ABA DE RETENÇÃO (sobre borda HEPA) ---
            // Mais curta que a do manta: apenas 7mm para cobrir
            // os 5mm de borda + 2mm de garra
            translate([0, 0, mdf + hepa_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);

            // --- RAMPA DE ENTRADA ---
            // Chanfro na ponta para facilitar encaixe do filtro
            translate([0, aba_comp - 0.1, mdf + hepa_borda_esp])
            hull() {
                cube([clip_larg, 0.1, aba_esp]);
                translate([0, 2, aba_esp + 1.5])
                    cube([clip_larg, 0.1, 0.1]);
            }

            // --- DENTES SNAP-FIT (2 por clip) ---
            translate([clip_larg/2 - dente_pos1 - dente_w/2, base_prof, 0])
                dente_snap();
            translate([clip_larg/2 + dente_pos2 - dente_w/2, base_prof, 0])
                dente_snap();
        }

        // --- CANAL de flexão na aba ---
        // Permite que a aba flexione ao inserir/remover filtro
        translate([clip_parede + 1.5, clip_parede, mdf + hepa_borda_esp - 0.1])
            cube([clip_larg - 2*clip_parede - 3, aba_comp - clip_parede - 3, 0.6]);
    }
}

// Dente snap-fit (idêntico ao CLIP_MANTA_G3)
module dente_snap() {
    hull() {
        cube([dente_w, 0.1, clip_parede]);
        translate([0, dente_h, 0])
            cube([dente_w, 0.1, clip_parede + dente_h]);
    }
    translate([0, dente_h, 0])
        cube([dente_w, 0.4, clip_parede + dente_h]);
}

// === VISUALIZAÇÃO ===

// Clip orientado para impressão (base na mesa)
clip_hepa();

// MDF fantasma para referência
%translate([-5, -2, 0])
    cube([clip_larg + 10, base_prof + aba_comp + 10, mdf]);

// Borda do HEPA fantasma
%translate([0, 0, mdf])
    color("DodgerBlue", 0.4)
        cube([clip_larg, hepa_borda_larg, hepa_borda_esp]);
