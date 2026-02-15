// ============================================================
// TESTE DE MONTAGEM — CLIP GM CABINE + MDF + FILTRO
// Abra no OpenSCAD → F5 (preview) → gire com mouse
// ============================================================
// MUDE 'vista' PARA TESTAR:
//   1 = Montado, 2 = Explodido, 3 = Corte, 4 = Animação
// ============================================================

vista = 1;        // [1:Montado, 2:Explodido, 3:Corte, 4:Animação]
explode = 12;

// === PARÂMETROS DO CLIP GM CABINE ===
mdf = 3;
filtro_borda_esp = 2;
filtro_borda_larg = 5;
clip_larg = 25;
clip_parede = 1.6;
aba_comp = 8;
aba_esp = 0.8;
base_prof = 8;
dente_h = 1.2;
dente_w = 8;
dente_pos = 6;
slot_w = 10;
slot_prof = 2;

module clip_gm() {
    difference() {
        union() {
            // Base
            cube([clip_larg, base_prof, clip_parede]);
            // Parede
            cube([clip_larg, clip_parede, mdf + filtro_borda_esp + aba_esp]);
            // Aba ultra-fina
            translate([0, 0, mdf + filtro_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            // Ponta curvada
            translate([0, aba_comp - 0.1, mdf + filtro_borda_esp])
                hull() {
                    cube([clip_larg, 0.1, aba_esp]);
                    translate([0, 1.5, aba_esp + 1])
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
        // 3 ranhuras de flexão
        for (i = [0:2])
            translate([clip_parede + 2 + i*8, clip_parede, mdf + filtro_borda_esp - 0.1])
                cube([4, aba_comp - clip_parede - 2, 0.5]);
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
    color("WhiteSmoke", 0.6)
    translate([-3, 0, mdf])
        cube([clip_larg + 6, filtro_borda_larg, filtro_borda_esp]);
}

module cotas() {
    color("Red") {
        translate([-8, base_prof/2, 0])
            cube([0.3, 0.3, mdf + filtro_borda_esp + aba_esp]);
        translate([-11, 0, 0]) cube([0.3, 0.3, mdf]);
        translate([-11, 0, mdf]) cube([0.3, 0.3, filtro_borda_esp]);
    }
    color("White") {
        translate([-22, -5, mdf/2])
            rotate([90,0,0]) text("MDF 3mm", size=1.5);
        translate([-28, -5, mdf + filtro_borda_esp/2])
            rotate([90,0,0]) text("Borda 2mm", size=1.5);
        translate([-22, -5, mdf + filtro_borda_esp + aba_esp/2])
            rotate([90,0,0]) text("Aba 0.8mm", size=1.5);
    }
}

// === VISTAS ===
if (vista == 1) {
    echo("=== GM CABINE: VERIFICAR ===");
    echo("1. Aba ultra-fina (0.8mm) faz pressão suave?");
    echo("2. Ranhuras permitem flexão sem quebrar?");
    echo("3. Borda de papelão (2mm) não amassa?");
    mdf_secao(); filtro_borda();
    color("Orange") clip_gm();
    cotas();
}
if (vista == 2) {
    translate([0,0,-explode]) mdf_secao();
    filtro_borda();
    translate([0,0,explode]) color("Orange") clip_gm();
}
if (vista == 3) {
    difference() {
        union() { mdf_secao(); filtro_borda(); color("Orange") clip_gm(); }
        translate([clip_larg/2, -40, -10])
            cube([clip_larg+20, 100, 40]);
    }
    cotas();
}
if (vista == 4) {
    mdf_secao(); filtro_borda();
    color("Orange") translate([0,0,20*(1-$t)]) clip_gm();
}
