// ============================================================
// CLIP RETENTOR PARA FILTRO DE CABINE GM BOSCH
// Impressão 3D - PLA/PETG (Ender 3)
// ============================================================
//
// CONCEITO: Retentores leves para filtro de cabine automotivo.
// O filtro é de PAPEL com moldura fina de papelão (~1-2mm esp),
// muito leve (~100g). Não precisa de muita força de retenção.
//
// O clip é um retentor de pressão: encaixa no MDF pelo lado
// de trás (snap-fit nos slots), e tem uma aba flexível fina
// que faz pressão suave sobre a borda do filtro.
//
// FILTRO DE CABINE GM BOSCH:
//   Externo: ~223×210mm
//   Moldura: ~5mm de borda, ~1-2mm espessura (papelão fino)
//   Espessura: 20mm (corpo plissado)
//   Furo MDF: 213×200mm (borda de 5mm repousa no MDF)
//
// FIXAÇÃO: 2 dentes snap-fit por clip, passam por slots
// cortados no MDF a 8mm da borda do furo.
//
// QUANTIDADE: 8 clips (2 por lado do furo)
//
// VISTA LATERAL (corte):
//
//   ╭── aba flexível (pressão leve) ──╮
//   │   borda filtro (~1-2mm papel)   │
//   ╞═══MDF══[entalhe]════════════════╡  ← entalhe 25×2mm no MDF
//            │  base (sob o MDF)       │
//            └── dente ────── dente ───┘
//
// MONTAGEM:
//   1. Incline o clip pela abertura do furo
//   2. Deslize a base por baixo do MDF (área sólida)
//   3. A parede passa pelo entalhe 25×2mm na borda
//   4. Dentes clicam nos slots do MDF
//   5. Aba faz pressão suave sobre a borda do filtro
//
// DIFERENÇA DOS OUTROS CLIPS:
//   - Aba muito fina (0.8mm) e flexível — apenas pressão leve
//   - Aba mais longa (8mm) para distribuir a força
//   - Sem rampa agressiva — filtro é mole, encaixa fácil
//   - Clip menor e mais leve (25mm largura)
//   - Ponta da aba curvada para cima — facilita inserção
//
// ============================================================

// === PARÂMETROS ===
mdf = 3;              // Espessura MDF
folga = 0.3;          // Folga de encaixe

// Filtro cabine
filtro_borda_esp = 2; // Espessura da moldura (papelão fino)
filtro_borda_larg = 5;// Largura da borda

// Clip
clip_larg = 25;       // Largura do clip ao longo da borda
clip_parede = 1.6;    // Espessura paredes (mais fino, filtro leve)
aba_comp = 8;         // Comprimento aba (5mm borda + 3mm cobertura)
aba_esp = 0.8;        // Espessura aba (BEM fina, só pressão leve)
base_prof = 8;        // Profundidade base por baixo do MDF

// Snap-fit
dente_h = 1.2;        // Altura do dente
dente_w = 8;          // Largura do dente
dente_pos1 = 6;       // Posição dente 1 (do centro)
dente_pos2 = 6;       // Simétrico

// Slot no MDF
slot_w = 10;          // Largura do slot
slot_h = 2;           // Altura do slot

// Entalhe no MDF para parede do clip (CNC)
entalhe_w    = clip_larg;   // 25mm (largura do clip)
entalhe_prof = clip_parede; // 1.6mm (~2mm no CNC)

// === MÓDULO PRINCIPAL ===
module clip_gm_cabine() {
    // X = largura (25mm ao longo da borda)
    // Y = profundidade (base → aba)
    // Z = altura (de baixo do MDF para cima)
    //
    // Z=0 = face inferior do MDF
    // Z=mdf = face superior do MDF
    // Z=mdf+filtro_borda_esp = topo da moldura do filtro

    difference() {
        union() {
            // --- BASE (por baixo do MDF) ---
            cube([clip_larg, base_prof, clip_parede]);

            // --- PAREDE VERTICAL (borda do furo) ---
            cube([clip_larg, clip_parede, mdf + filtro_borda_esp + aba_esp]);

            // --- ABA FLEXÍVEL (sobre borda do filtro) ---
            // Fina (0.8mm) para fazer pressão suave
            // Mais longa (8mm) para segurar bem a borda mole
            translate([0, 0, mdf + filtro_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);

            // --- PONTA CURVADA (facilita inserção) ---
            // Levanta a ponta da aba para o filtro deslizar por baixo
            translate([0, aba_comp - 0.1, mdf + filtro_borda_esp])
            hull() {
                cube([clip_larg, 0.1, aba_esp]);
                translate([0, 1.5, aba_esp + 1])
                    cube([clip_larg, 0.1, 0.1]);
            }

            // --- DENTES SNAP-FIT (2 por clip) ---
            translate([clip_larg/2 - dente_pos1 - dente_w/2, base_prof, 0])
                dente_snap();
            translate([clip_larg/2 + dente_pos2 - dente_w/2, base_prof, 0])
                dente_snap();
        }

        // --- RANHURAS de flexão na aba ---
        // 3 ranhuras longitudinais tornam a aba mais flexível
        // Fundamental para não amassar o filtro de papel!
        for (i = [0:2]) {
            translate([clip_parede + 2 + i * 8, clip_parede, mdf + filtro_borda_esp - 0.1])
                cube([4, aba_comp - clip_parede - 2, 0.5]);
        }
    }
}

// Dente snap-fit
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

// Clip para impressão
clip_gm_cabine();

// MDF fantasma
%translate([-5, -2, 0])
    cube([clip_larg + 10, base_prof + aba_comp + 10, mdf]);

// Filtro cabine fantasma (borda fina)
%translate([0, 0, mdf])
    color("WhiteSmoke", 0.4)
        cube([clip_larg, filtro_borda_larg, filtro_borda_esp]);
