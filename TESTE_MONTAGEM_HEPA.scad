// ============================================================
// TESTE DE MONTAGEM — CLIP HEPA + MDF + FILTRO
// Abra no OpenSCAD → F5 (preview) → gire com mouse
// ============================================================
// MUDE 'vista' PARA TESTAR:
//   1 = Montado, 2 = Explodido, 3 = Corte, 4 = Animação
// ============================================================

vista = 1;        // [1:Montado, 2:Explodido, 3:Corte, 4:Animação]
explode = 12;

// === PARÂMETROS DO CLIP HEPA ===
mdf = 3;
hepa_borda_esp = 2;
hepa_borda_larg = 5;
clip_larg = 25;
clip_parede = 2;
aba_comp = 7;
aba_esp = 1.2;
base_prof = 8;
dente_h = 1.2;
dente_w = 8;
dente_pos = 6;
slot_w = 10;
slot_prof = 2;

module clip_hepa() {
    difference() {
        union() {
            // Base
            cube([clip_larg, base_prof, clip_parede]);
            // Parede
            cube([clip_larg, clip_parede, mdf + hepa_borda_esp + aba_esp]);
            // Aba
            translate([0, 0, mdf + hepa_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            // Rampa
            translate([0, aba_comp - 0.1, mdf + hepa_borda_esp])
                hull() {
                    cube([clip_larg, 0.1, aba_esp]);
                    translate([0, 2, aba_esp + 1.5])
                        cube([clip_larg, 0.1, 0.1]);
                }
            // Dentes
            for (dx = [clip_larg/2 - dente_pos - dente_w/2,
                       clip_larg/2 + dente_pos - dente_w/2])
                translate([dx, base_prof, 0]) {
                    hull() {
                        cube([dente_w, 0.1, clip_parede]);
                        translate([0, dente_h, 0])
                            cube([dente_w, 0.1, clip_parede + dente_h]);
                    }
                    translate([0, dente_h, 0])
                        cube([dente_w, 0.4, clip_parede + dente_h]);
                }
        }
        // Canal de flexão
        translate([clip_parede + 1.5, clip_parede, mdf + hepa_borda_esp - 0.1])
            cube([clip_larg - 2*clip_parede - 3, aba_comp - clip_parede - 3, 0.6]);
    }
}

module mdf_secao() {
    color("BurlyWood", 0.7)
    difference() {
        translate([-12, -30, 0])
            cube([clip_larg + 24, 50, mdf]);
        // Entalhe para parede do clip (25×2mm na borda do furo)
        translate([-0.1, -0.1, -0.1])
            cube([clip_larg + 0.2, clip_parede + 0.2, mdf + 0.2]);
        // Slots para dentes
        for (dx = [clip_larg/2 - dente_pos - slot_w/2,
                   clip_larg/2 + dente_pos - slot_w/2])
            translate([dx, base_prof - slot_prof + 0.5, -0.1])
                cube([slot_w, slot_prof + 1, mdf + 0.2]);
    }
}

module filtro_borda() {
    color("DodgerBlue", 0.5)
    translate([-3, 0, mdf])
        cube([clip_larg + 6, hepa_borda_larg, hepa_borda_esp]);
}

module cotas() {
    color("Red") {
        translate([-8, base_prof/2, 0])
            cube([0.3, 0.3, mdf + hepa_borda_esp + aba_esp]);
        translate([-11, 0, 0]) cube([0.3, 0.3, mdf]);
        translate([-11, 0, mdf]) cube([0.3, 0.3, hepa_borda_esp]);
    }
    color("White") {
        translate([-20, -5, mdf/2])
            rotate([90,0,0]) text("MDF 3mm", size=1.5);
        translate([-25, -5, mdf + hepa_borda_esp/2])
            rotate([90,0,0]) text("Borda 2mm", size=1.5);
        translate([-20, -5, mdf + hepa_borda_esp + aba_esp/2])
            rotate([90,0,0]) text("Aba 7mm", size=1.5);
    }
}

// === VISTAS ===
if (vista == 1) {
    echo("=== HEPA: VERIFICAR ===");
    echo("1. Aba curta (7mm) cobre a borda de 5mm?");
    echo("2. Vedação suficiente ao redor?");
    echo("3. Furo pequeno (100x130mm) centralizado?");
    mdf_secao(); filtro_borda();
    color("Orange") clip_hepa();
    cotas();
}
if (vista == 2) {
    translate([0,0,-explode]) mdf_secao();
    filtro_borda();
    translate([0,0,explode]) color("Orange") clip_hepa();
}
if (vista == 3) {
    difference() {
        union() { mdf_secao(); filtro_borda(); color("Orange") clip_hepa(); }
        translate([clip_larg/2, -40, -10])
            cube([clip_larg+20, 100, 40]);
    }
    cotas();
}
if (vista == 4) {
    mdf_secao(); filtro_borda();
    color("Orange") translate([0,0,20*(1-$t)]) clip_hepa();
}
