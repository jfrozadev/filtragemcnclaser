// ============================================================
// CLIP DE RETENÇÃO PARA FILTRO WEGA (Motor)
// Impressão 3D - PLA/PETG (Ender 3)
// ============================================================
//
// CONCEITO: Clip de borda que prende o filtro Wega na
// divisória MDF. O lip engancha na borda do furo por baixo.
// Aba pressiona o frame do filtro. Batente trava.
// Instalação 100% pela face do frame (SEM slots/furos no MDF).
//
// FILTRO WEGA:
//   Corpo (mídia plissada): 220×160×41mm (passa pelo furo)
//   Frame/borda (poliuretano): 246×183×4mm (aba fina no topo)
//   Frame estende 9.5mm além do furo em Y (lados dos clips)
//   Frame estende 13mm além do furo em X (lados dos trilhos)
//   Frame repousa SOBRE o MDF ao redor do furo
//
// VISTA LATERAL (corte Y-Z):
//
//   ┌───────── aba ──────────┐
//   │                          ┌─┐ ← batente
//   │    frame 4mm             │ │
//   │    (Y=0..9.5)            │ │
//   │════ MDF 3mm ═════════════╡ │
//   └─lip─┘     (furo)        └─┘
//    3mm
//
// CONCEITO CHAVE:
//   Lip engancha na borda do furo por BAIXO (3mm sob o MDF)
//   Parede no lado do FURO (Y<0) → não colide com o frame
//   Aba cobre o TOPO do frame (Y=0..11.5)
//   Batente abraça a BORDA EXTERNA do frame (Y=9.5..11.5)
//   = Clip instalado pela face do frame, sem varar o MDF
//
// MONTAGEM:
//   1. Coloque o filtro: corpo pelo furo, frame repousa sobre MDF
//   2. Posicione o clip: incline e encaixe o lip sob o MDF
//   3. Pressione a aba: frame entra no canal (batente trava)
//   4. Frame preso: lip + aba + batente + MDF
//
// COORDENADAS:
//   X: largura (0..clip_larg, ao longo da borda do furo)
//   Y: 0 = borda do furo, +Y = MDF sólido/frame, -Y = furo
//   Z: 0 = face inferior do lip; Z=lip_esp → face inf. MDF
//
// QUANTIDADE: 6 clips (3 em cima + 3 em baixo do furo)
// Lados X: SEM clips (margem usada pelos trilhos)
// FIXAÇÃO: lip na borda do furo (SEM slots/furos extras no MDF)
// ============================================================

// === PARÂMETROS ===

// MDF
mdf = 3;

// Folgas
folga_mdf    = 0.3;   // folga de encaixe
folga_filtro = 0.5;   // folga vertical p/ borda do filtro

// Filtro Wega Motor
//   Corpo (mídia plissada): 220×160×41mm (passa pelo furo)
//   Frame/borda (poliuretano): 246×183×4mm (aba fina no topo)
filtro_comp  = 220;
filtro_larg  = 160;
filtro_prof  = 45;
wega_borda_esp  = 4;    // espessura da borda/frame (~4mm PU)
wega_borda_larg = 9.5;  // extensão do frame além do furo em Y
// Frame total: 246×183mm = furo(220×164) + 2×13mm (X) + 2×9.5mm (Y)
// Furo CNC = corpo(220×160) + 2×2mm (paredes clips) = 220×164mm

// Clip — dimensões principais
clip_larg   = 30;     // largura ao longo da borda do furo
clip_parede = 2;      // espessura da parede (na borda do furo)

// Lip (engancha sob o MDF na borda do furo)
lip_prof = 3;         // quanto avança sob o MDF sólido (3mm)
lip_esp  = 2;         // espessura do lip

// Aba (sobre o frame do filtro, avança +Y sobre o MDF)
aba_comp   = 11.5;    // wega_borda_larg (9.5) + 2mm garra
aba_esp    = 1.5;     // espessura da aba

// Batente externo (na borda externa do frame)
batente_alt = 2.5;    // quanto desce abaixo da aba

// CNC — NÃO requer slots no MDF!
// O lip simplesmente engancha na borda do furo existente.
// Apenas o furo 220×164mm é necessário na divisória.


// === MÓDULO PRINCIPAL ===
module clip_wega() {
    // Z=0: face inferior do lip (abaixo do MDF)
    // Z=lip_esp: face inferior do MDF
    // Z=lip_esp+mdf: face superior do MDF (frame repousa aqui)
    // Y=0: borda do furo, +Y: MDF sólido/frame, -Y: furo

    gap = lip_esp + mdf + wega_borda_esp + folga_filtro;

    // --- LIP (engancha sob o MDF, 3mm na área sólida, +Y) ---
    cube([clip_larg, lip_prof, lip_esp]);

    // Rampa no lip (facilita encaixe na borda do MDF)
    translate([0, lip_prof, 0])
        hull() {
            cube([clip_larg, 0.1, lip_esp]);
            translate([0, 1.5, 0])
                cube([clip_larg, 0.1, 0.3]);
        }

    // --- PAREDE VERTICAL (lado furo, Y<0) ---
    // No espaço do furo, NÃO colide com o frame
    translate([0, -clip_parede, 0])
        cube([clip_larg, clip_parede, gap + aba_esp]);

    // --- ABA (sobre o frame, de Y=-clip_parede até Y=aba_comp) ---
    translate([0, -clip_parede, gap])
        cube([clip_larg, aba_comp + clip_parede, aba_esp]);

    // --- BATENTE EXTERNO (na borda externa do frame) ---
    translate([0, wega_borda_larg, gap - batente_alt])
        cube([clip_larg, aba_comp - wega_borda_larg, batente_alt + aba_esp]);

    // --- RAMPA DE INSERÇÃO (chanfro no batente, guia o frame) ---
    translate([0, aba_comp - 0.1, gap])
        hull() {
            cube([clip_larg, 0.1, aba_esp]);
            translate([0, 2, aba_esp + 1.5])
                cube([clip_larg, 0.1, 0.1]);
        }
}


// === IMPRESSÃO 3D (Ender 3) ===
// Lip na mesa de impressão, parede vertical para cima
// Aba tem overhang de ~8mm (OK com PLA, suporte se necessário)

clip_wega();

// === VERIFICAÇÃO (descomente p/ ver montagem) ===
// Comente "clip_wega();" acima e descomente abaixo:
//
// color("Orange") clip_wega();
//
// // MDF fantasma — lip fica sob esta placa
// %translate([-5, -3, lip_esp]) cube([clip_larg+10, lip_prof+8, mdf]);
//
// // Frame do filtro (acima do MDF, repousa sobre o MDF)
// color("LimeGreen", 0.3)
//     translate([-5, 0, lip_esp + mdf])
//         cube([clip_larg+10, wega_borda_larg, wega_borda_esp]);