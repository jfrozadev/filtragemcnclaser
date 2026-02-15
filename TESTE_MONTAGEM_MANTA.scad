// ============================================================
// TESTE DE MONTAGEM — CLIP MANTA G3 + MDF + MANTA
// Abra no OpenSCAD → F5 (preview) → gire com mouse
// ============================================================
// MUDE 'vista' PARA TESTAR:
//   1 = Montado, 2 = Explodido, 3 = Corte, 4 = Animação
// ============================================================

vista = 1;        // [1:Montado, 2:Explodido, 3:Corte, 4:Animação]
explode = 15;

// === PARÂMETROS DO CLIP MANTA G3 ===
mdf = 3;
manta_esp = 10;
clip_larg = 30;
clip_parede = 2;
aba_comp = 15;
aba_esp = 1.5;
base_prof = 8;
dente_h = 1.2;
dente_w = 8;
dente_pos = 7;
slot_w = 10;
slot_prof = 2;

module clip_manta() {
    difference() {
        union() {
            // Base
            cube([clip_larg, base_prof, clip_parede]);
            // Parede
            cube([clip_larg, clip_parede, mdf + manta_esp + aba_esp]);
            // Aba
            translate([0, 0, mdf + manta_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            // Rampa
            translate([0, aba_comp - 0.1, mdf + manta_esp])
                hull() {
                    cube([clip_larg, 0.1, aba_esp]);
                    translate([0, 3, aba_esp + 2])
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
        translate([clip_parede + 2, clip_parede, mdf + manta_esp - 0.1])
            cube([clip_larg - 2*clip_parede - 4, aba_comp - clip_parede - 5, 0.8]);
    }
}

module mdf_secao() {
    color("BurlyWood", 0.7)
    difference() {
        translate([-15, -30, 0])
            cube([clip_larg + 30, 55, mdf]);
        // Entalhe para parede do clip (30×2mm na borda do furo)
        translate([-0.1, -0.1, -0.1])
            cube([clip_larg + 0.2, clip_parede + 0.2, mdf + 0.2]);
        // Slots para dentes
        for (dx = [clip_larg/2 - dente_pos - slot_w/2,
                   clip_larg/2 + dente_pos - slot_w/2])
            translate([dx, base_prof - slot_prof + 0.5, -0.1])
                cube([slot_w, slot_prof + 1, mdf + 0.2]);
    }
}

module manta() {
    color("LimeGreen", 0.5)
    translate([-5, -2, mdf])
        cube([clip_larg + 10, aba_comp + 5, manta_esp]);
}

module cotas() {
    color("Red") {
        translate([-8, base_prof/2, 0])
            cube([0.3, 0.3, mdf + manta_esp + aba_esp]);
        translate([-12, 0, 0])
            cube([0.3, 0.3, mdf]);
        translate([-12, 0, mdf])
            cube([0.3, 0.3, manta_esp]);
    }
    color("White") {
        translate([-20, -5, mdf/2])
            rotate([90,0,0]) text("MDF 3mm", size=2);
        translate([-25, -5, mdf + manta_esp/2])
            rotate([90,0,0]) text("Manta 10mm", size=2);
        translate([-20, -5, mdf + manta_esp + aba_esp/2])
            rotate([90,0,0]) text("Aba 15mm", size=2);
    }
}

// === VISTAS ===
if (vista == 1) {
    echo("=== MANTA G3: VERIFICAR ===");
    echo("1. Aba de 15mm cobre a manta?");
    echo("2. Dentes encaixam nos slots?");
    echo("3. Manta comprimida entre aba e MDF?");
    mdf_secao(); manta();
    color("Orange") clip_manta();
    cotas();
}
if (vista == 2) {
    translate([0,0,-explode]) mdf_secao();
    manta();
    translate([0,0,explode]) color("Orange") clip_manta();
}
if (vista == 3) {
    difference() {
        union() { mdf_secao(); manta(); color("Orange") clip_manta(); }
        translate([clip_larg/2, -40, -10])
            cube([clip_larg+20, 100, 50]);
    }
    cotas();
}
if (vista == 4) {
    mdf_secao(); manta();
    color("Orange") translate([0,0,25*(1-$t)]) clip_manta();
}
