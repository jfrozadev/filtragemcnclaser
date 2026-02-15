// ============================================================
// TESTE — DIVISÓRIA WEGA COMPLETA (MDF + 6 CLIPS + FILTRO)
// Vista completa da divisória com todos os clips posicionados
// Clips com dentes snap-fit que passam por slots no MDF
// NÃO há clips nos lados X (trilhos passam ali)
// Abra no OpenSCAD → F5 (preview)
// ============================================================
// MUDE 'vista':
//   1 = Vista de cima (planta)
//   2 = Vista 3D montada
//   3 = Vista 3D explodida
// ============================================================

vista = 2;  // [1:Planta, 2:3D Montado, 3:3D Explodido]
explode = 25;

// === DIMENSÕES DA DIVISÓRIA ===
mdf_w = 244;
mdf_h = 240;
mdf_t = 3;

// Furo 220×164mm centralizado
// X: (244-220)/2 = 12mm → X de 12 a 232
// Y: (240-164)/2 = 38mm → Y de 38 a 202
// 164mm = corpo 160mm + 2×2mm para paredes dos clips
furo_x1 = 12;     furo_x2 = 232;
furo_y1 = 38;     furo_y2 = 202;
furo_w = furo_x2 - furo_x1;  // 220
furo_h = furo_y2 - furo_y1;  // 164

// Filtro Wega (corpo 220×160×41mm mídia, frame/borda 246×183×4mm PU)
filtro_w = 220;
filtro_h = 160;
filtro_corpo = 45;
wega_borda_esp  = 4;
wega_borda_larg = 9.5;   // extensão frame além do furo em Y ((183-164)/2)
// Frame total: 246×183mm
frame_w = 246;
frame_h = 183;

// Clip Wega (snap-fit com dentes)
clip_larg = 30;
clip_parede = 2;
base_prof = 8;
base_esp = 2;
aba_comp = 11.5;     // wega_borda_larg (9.5) + 2mm garra
aba_esp = 1.5;
batente_alt = 2.5;   // lip desce 2.5mm abaixo da aba
dente_h = 1.5;
dente_w = 9;
dente_pos = 7;
folga_filtro = 0.5;
gap = mdf_t + wega_borda_esp + folga_filtro;

// Slots para dentes (10×2mm, 8mm do furo)
slot_w = 10;
slot_comp = 2;


// Posições dos 6 clips (centros)
// SÓ nos lados Y (superior/inferior) — lados X têm trilhos!
// [x, y, rotação_z]
clips_pos = [
    // Inferior (Y=40): 3 clips
    [60,  furo_y1, 180],
    [122, furo_y1, 180],
    [184, furo_y1, 180],
    // Superior (Y=200): 3 clips
    [60,  furo_y2, 0],
    [122, furo_y2, 0],
    [184, furo_y2, 0]
    // Lados X: SEM clips (margem 12mm usada pelos trilhos)
];

// Posições dos slots (12 total, 2 por clip)
// [x_center, y_center] do slot 10×2mm
slots_inf = [
    [53, 29], [67, 29],     // clip 60
    [115, 29], [129, 29],   // clip 122
    [177, 29], [191, 29]    // clip 184
];
slots_sup = [
    [53, 211], [67, 211],
    [115, 211], [129, 211],
    [177, 211], [191, 211]
];

// === MÓDULOS ===

module dente_snap_3d() {
    hull() {
        cube([dente_w, 0.1, base_esp]);
        translate([0, dente_h, 0])
            cube([dente_w, 0.1, base_esp + dente_h]);
    }
    translate([0, dente_h, 0])
        cube([dente_w, 0.5, base_esp + dente_h]);
}

module clip_wega_3d() {
    // Base (sob o MDF)
    cube([clip_larg, base_prof, base_esp]);
    // Parede (lado furo, Y<0)
    translate([0, -clip_parede, 0])
        cube([clip_larg, clip_parede, gap + aba_esp]);
    // Aba (sobre frame, conecta com parede)
    translate([0, -clip_parede, gap])
        cube([clip_larg, aba_comp + clip_parede, aba_esp]);
    // Batente (lip na borda externa do frame)
    translate([0, wega_borda_larg, gap - batente_alt])
        cube([clip_larg, aba_comp - wega_borda_larg, batente_alt + aba_esp]);
    // Dentes
    translate([clip_larg/2 - dente_pos - dente_w/2, base_prof, 0])
        dente_snap_3d();
    translate([clip_larg/2 + dente_pos - dente_w/2, base_prof, 0])
        dente_snap_3d();
}

module mdf_placa() {
    color("BurlyWood", 0.8)
    difference() {
        cube([mdf_w, mdf_h, mdf_t]);
        // Furo central 220×160mm
        translate([furo_x1, furo_y1, -0.1])
            cube([furo_w, furo_h, mdf_t + 0.2]);
        // Slots para dentes (12 total)
        for (s = concat(slots_inf, slots_sup))
            translate([s[0] - slot_w/2, s[1] - slot_comp/2, -0.1])
                cube([slot_w, slot_comp, mdf_t + 0.2]);
    }
}

module filtro_wega() {
    cx = mdf_w/2;
    cy = mdf_h/2;
    // Frame do filtro (246×183mm, repousa SOBRE o MDF ao redor do furo)
    color("LimeGreen", 0.4)
    translate([cx - frame_w/2, cy - frame_h/2, mdf_t])
        cube([frame_w, frame_h, wega_borda_esp]);
    // Corpo do filtro (abaixo do MDF, passa pelo furo 220×160)
    color("DarkSlateGray", 0.3)
    translate([cx - filtro_w/2, cy - filtro_h/2, mdf_t - (filtro_corpo - wega_borda_esp)])
        cube([filtro_w, filtro_h, filtro_corpo - wega_borda_esp]);
}

module colocar_clips(dz = 0) {
    color("Orange")
    for (cp = clips_pos) {
        translate([cp[0], cp[1], dz])
            rotate([0, 0, cp[2]])
                translate([-clip_larg/2, 0, 0])
                    clip_wega_3d();
    }
}


// === VISTA 1: PLANTA (CIMA) ===
if (vista == 1) {
    echo("=== VISTA PLANTA ===");
    echo("Furo 220x164mm (corpo 160mm + 4mm clips)");
    echo("12 slots 10x2mm para 6 clips");
    echo("Margem X=12mm (trilhos), Y=38mm");
    projection(cut=false)
        translate([0, 0, 0]) {
            mdf_placa();
            color("Orange", 0.5)
            for (cp = clips_pos)
                translate([cp[0], cp[1], 0])
                    rotate([0, 0, cp[2]])
                        translate([-clip_larg/2, -1, 0])
                            cube([clip_larg, base_prof + 2, 0.5]);
        }
}

// === VISTA 2: 3D MONTADO ===
if (vista == 2) {
    echo("=== 3D MONTADO ===");
    echo("Gire para verificar todos os 6 clips");
    mdf_placa();
    filtro_wega();
    colocar_clips();
}

// === VISTA 3: 3D EXPLODIDO ===
if (vista == 3) {
    echo("=== EXPLODIDO ===");
    translate([0, 0, -explode]) mdf_placa();
    filtro_wega();
    colocar_clips(explode);
}
