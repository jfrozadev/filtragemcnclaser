// ============================================================
// COMPARAÇÃO — TODOS OS 4 CLIPS LADO A LADO
// Abra no OpenSCAD → F5 para ver os 4 clips em escala real
// ============================================================
// Compara: tamanho, aba, base, dentes de cada clip
// ============================================================

mdf = 3;
esp = 40;  // espaçamento entre clips

// ===================== MANTA G3 =====================
module clip_manta() {
    manta_esp = 10;
    clip_larg = 30; clip_parede = 2;
    aba_comp = 15; aba_esp = 1.5;
    base_prof = 8;
    dente_h = 1.2; dente_w = 8; dente_pos = 7;

    difference() {
        union() {
            cube([clip_larg, base_prof, clip_parede]);
            cube([clip_larg, clip_parede, mdf + manta_esp + aba_esp]);
            translate([0,0,mdf+manta_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            translate([0, aba_comp-0.1, mdf+manta_esp])
                hull() { cube([clip_larg,0.1,aba_esp]);
                    translate([0,3,aba_esp+2]) cube([clip_larg,0.1,0.1]); }
            for (dx=[clip_larg/2-dente_pos-dente_w/2,
                     clip_larg/2+dente_pos-dente_w/2])
                translate([dx, base_prof, 0]) {
                    hull() { cube([dente_w,0.1,clip_parede]);
                        translate([0,dente_h,0]) cube([dente_w,0.1,clip_parede+dente_h]); }
                    translate([0,dente_h,0]) cube([dente_w,0.4,clip_parede+dente_h]);
                }
        }
        translate([clip_parede+2,clip_parede,mdf+manta_esp-0.1])
            cube([clip_larg-2*clip_parede-4, aba_comp-clip_parede-5, 0.8]);
    }
}

// ===================== GM CABINE =====================
module clip_gm() {
    filtro_borda_esp = 2;
    clip_larg = 25; clip_parede = 1.6;
    aba_comp = 8; aba_esp = 0.8;
    base_prof = 8;
    dente_h = 1.2; dente_w = 8; dente_pos = 6;

    difference() {
        union() {
            cube([clip_larg, base_prof, clip_parede]);
            cube([clip_larg, clip_parede, mdf + filtro_borda_esp + aba_esp]);
            translate([0,0,mdf+filtro_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            translate([0,aba_comp-0.1,mdf+filtro_borda_esp])
                hull() { cube([clip_larg,0.1,aba_esp]);
                    translate([0,1.5,aba_esp+1]) cube([clip_larg,0.1,0.1]); }
            for (dx=[clip_larg/2-dente_pos-dente_w/2,
                     clip_larg/2+dente_pos-dente_w/2])
                translate([dx, base_prof, 0]) {
                    hull() { cube([dente_w,0.1,clip_parede]);
                        translate([0,dente_h,0]) cube([dente_w,0.1,clip_parede+dente_h]); }
                    translate([0,dente_h,0]) cube([dente_w,0.4,clip_parede+dente_h]);
                }
        }
        for (i=[0:2])
            translate([clip_parede+2+i*8,clip_parede,mdf+filtro_borda_esp-0.1])
                cube([4, aba_comp-clip_parede-2, 0.5]);
    }
}

// ===================== WEGA (snap-fit com dentes) =====================
module clip_wega() {
    wega_borda_esp = 4;
    folga_filtro = 0.5;
    clip_larg = 30; clip_parede = 2;
    base_prof = 8; base_esp = 2;
    aba_avanco = 8; aba_esp = 1.5;
    dente_h = 1.5; dente_w = 9; dente_pos = 7;
    gap = mdf + wega_borda_esp + folga_filtro;

    // Base (sob o MDF)
    cube([clip_larg, base_prof, base_esp]);
    // Parede (borda do furo)
    cube([clip_larg, clip_parede, gap + aba_esp]);
    // Aba (sobre filtro, -Y)
    translate([0, -aba_avanco, gap])
        cube([clip_larg, aba_avanco + clip_parede, aba_esp]);
    // Dentes snap-fit
    for (dx = [clip_larg/2 - dente_pos - dente_w/2,
               clip_larg/2 + dente_pos - dente_w/2])
        translate([dx, base_prof, 0]) {
            hull() {
                cube([dente_w, 0.1, base_esp]);
                translate([0, dente_h, 0])
                    cube([dente_w, 0.1, base_esp + dente_h]);
            }
            translate([0, dente_h, 0])
                cube([dente_w, 0.5, base_esp + dente_h]);
        }
}

// ===================== HEPA =====================
module clip_hepa() {
    hepa_borda_esp = 2;
    clip_larg = 25; clip_parede = 2;
    aba_comp = 7; aba_esp = 1.2;
    base_prof = 8;
    dente_h = 1.2; dente_w = 8; dente_pos = 6;

    difference() {
        union() {
            cube([clip_larg, base_prof, clip_parede]);
            cube([clip_larg, clip_parede, mdf + hepa_borda_esp + aba_esp]);
            translate([0,0,mdf+hepa_borda_esp])
                cube([clip_larg, aba_comp, aba_esp]);
            translate([0,aba_comp-0.1,mdf+hepa_borda_esp])
                hull() { cube([clip_larg,0.1,aba_esp]);
                    translate([0,2,aba_esp+1.5]) cube([clip_larg,0.1,0.1]); }
            for (dx=[clip_larg/2-dente_pos-dente_w/2,
                     clip_larg/2+dente_pos-dente_w/2])
                translate([dx, base_prof, 0]) {
                    hull() { cube([dente_w,0.1,clip_parede]);
                        translate([0,dente_h,0]) cube([dente_w,0.1,clip_parede+dente_h]); }
                    translate([0,dente_h,0]) cube([dente_w,0.4,clip_parede+dente_h]);
                }
        }
        translate([clip_parede+1.5,clip_parede,mdf+hepa_borda_esp-0.1])
            cube([clip_larg-2*clip_parede-3, aba_comp-clip_parede-3, 0.6]);
    }
}


// === DISPOSIÇÃO ===

// Manta G3
translate([0, 0, 0]) {
    color("Orange") clip_manta();
    color("White") translate([0, -8, 0])
        rotate([90,0,0]) text("MANTA G3", size=4);
    color("Gray") translate([0, -4, 0])
        rotate([90,0,0]) text("30mm | aba 15mm | manta 10mm", size=2);
}

// GM Cabine
translate([esp, 0, 0]) {
    color("DodgerBlue") clip_gm();
    color("White") translate([0, -8, 0])
        rotate([90,0,0]) text("GM CABINE", size=4);
    color("Gray") translate([0, -4, 0])
        rotate([90,0,0]) text("25mm | aba 8mm | borda 2mm", size=2);
}

// Wega
translate([2*esp, 0, 0]) {
    color("LimeGreen") clip_wega();
    color("White") translate([0, -8, 0])
        rotate([90,0,0]) text("WEGA", size=4);
    color("Gray") translate([0, -4, 0])
        rotate([90,0,0]) text("30mm | aba 12mm | borda 10mm", size=2);
}

// HEPA
translate([3*esp, 0, 0]) {
    color("Crimson") clip_hepa();
    color("White") translate([0, -8, 0])
        rotate([90,0,0]) text("HEPA", size=4);
    color("Gray") translate([0, -4, 0])
        rotate([90,0,0]) text("25mm | aba 7mm | borda 2mm", size=2);
}

// MDF de referência (transparente)
%translate([-10, -2, 0])
    cube([3*esp + 40, base_prof + 20, mdf]);

echo("==========================================");
echo("COMPARAÇÃO DOS 4 CLIPS:");
echo("  MANTA G3:   30mm larg, aba 15mm, manta 10mm");
echo("  GM CABINE:  25mm larg, aba 8mm,  borda 2mm (ultra-fina)");
echo("  WEGA:       30mm larg, aba 8mm, dentes snap-fit em slots");
echo("  HEPA:       25mm larg, aba 7mm,  borda 2mm");
echo("==========================================");
