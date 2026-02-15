// ============================================================
// TESTE DE MONTAGEM — CLIP WEGA + MDF + FILTRO
// Abra no OpenSCAD → F5 (preview) → gire com mouse
// ============================================================
// MUDE 'vista' PARA TESTAR:
//   1 = Montado (verificar encaixe)
//   2 = Explodido (ver peças separadas)
//   3 = Corte lateral (ver seção interna)
//   4 = Animação (View > Animate, FPS=1, Steps=30)
// ============================================================

vista = 1;        // [1:Montado, 2:Explodido, 3:Corte, 4:Animação]
explode = 20;     // distância explosão (mm)

// === PARÂMETROS DO CLIP WEGA (lip na borda do furo) ===
mdf = 3;
folga_filtro = 0.5;
wega_borda_esp  = 4;
wega_borda_larg = 9.5;   // extensão do frame além do furo em Y
clip_larg   = 30;
clip_parede = 2;
lip_prof    = 3;      // lip engancha 3mm sob o MDF
lip_esp     = 2;      // espessura do lip
aba_comp    = 11.5;   // wega_borda_larg (9.5) + 2mm garra
aba_esp     = 1.5;
batente_alt = 2.5;    // batente desce 2.5mm abaixo da aba

gap = lip_esp + mdf + wega_borda_esp + folga_filtro;

// === MÓDULOS ===

module clip_wega() {
    // Lip (engancha sob o MDF, +Y = MDF sólido)
    cube([clip_larg, lip_prof, lip_esp]);
    // Rampa no lip
    translate([0, lip_prof, 0])
        hull() {
            cube([clip_larg, 0.1, lip_esp]);
            translate([0, 1.5, 0])
                cube([clip_larg, 0.1, 0.3]);
        }
    // Parede (lado furo, Y<0, evita colisão com frame)
    translate([0, -clip_parede, 0])
        cube([clip_larg, clip_parede, gap + aba_esp]);
    // Aba (sobre frame, conecta com parede)
    translate([0, -clip_parede, gap])
        cube([clip_larg, aba_comp + clip_parede, aba_esp]);
    // Batente (na borda externa do frame)
    translate([0, wega_borda_larg, gap - batente_alt])
        cube([clip_larg, aba_comp - wega_borda_larg, batente_alt + aba_esp]);
    // Rampa de inserção (chanfro no batente)
    translate([0, aba_comp - 0.1, gap])
        hull() {
            cube([clip_larg, 0.1, aba_esp]);
            translate([0, 2, aba_esp + 1.5])
                cube([clip_larg, 0.1, 0.1]);
        }
}

module mdf_secao() {
    // MDF com furo — SEM slots (lip não precisa furar o MDF)
    color("BurlyWood", 0.7)
    difference() {
        translate([-15, -5, lip_esp])
            cube([clip_larg + 30, lip_prof + 20, mdf]);
        // Furo (Y<0 livre, parede passa pelo espaço do furo)
        translate([-16, -clip_parede - 1, lip_esp - 0.1])
            cube([clip_larg + 32, clip_parede + 1.1, mdf + 0.2]);
    }
}

module filtro_secao() {
    // Frame do filtro repousa SOBRE o MDF dentro do canal-U
    color("LimeGreen", 0.6)
    translate([-5, 0, lip_esp + mdf])
        cube([clip_larg + 10, wega_borda_larg, wega_borda_esp]);
}

module cotas() {
    color("Red") {
        translate([-8, lip_prof/2, 0])
            cube([0.3, 0.3, lip_esp]);
        translate([-12, 0, lip_esp])
            cube([0.3, 0.3, mdf]);
        translate([-12, -5, lip_esp + mdf])
            cube([0.3, 0.3, wega_borda_esp]);
    }
    color("White") {
        translate([-20, -5, lip_esp + mdf/2])
            rotate([90,0,0]) text("MDF 3mm", size=2);
        translate([-25, -5, lip_esp + mdf + wega_borda_esp/2])
            rotate([90,0,0]) text("Frame 4mm", size=2);
        translate([-20, -5, gap + aba_esp/2])
            rotate([90,0,0]) text("Aba", size=2);
        translate([-20, -5, lip_esp/2])
            rotate([90,0,0]) text("Lip 3mm", size=2);
    }
}

// === VISTAS ===

if (vista == 1) {
    echo("=== VERIFICAR ===");
    echo("1. Lip engancha sob o MDF na borda do furo?");
    echo("2. Aba cobre frame do filtro?");
    echo("3. Batente trava na borda externa do frame?");
    echo("4. Clip NÃO invade zona do furo (Y<0)?");
    echo("5. SEM slots — lip hook na borda do furo");
    echo("6. Trilhos nos lados X — clips SÓ nos lados Y");

    mdf_secao();
    filtro_secao();
    color("Orange") clip_wega();
    cotas();
}

if (vista == 2) {
    translate([0, 0, -explode]) mdf_secao();
    filtro_secao();
    translate([0, 0, explode]) color("Orange") clip_wega();
}

if (vista == 3) {
    difference() {
        union() {
            mdf_secao();
            filtro_secao();
            color("Orange") clip_wega();
        }
        translate([clip_larg/2, -50, -20])
            cube([clip_larg + 20, 120, 60]);
    }
    cotas();
}

if (vista == 4) {
    mdf_secao();
    filtro_secao();
    // Clip encaixa: lip engancha sob o MDF
    anim_z = 15 * (1 - $t);
    anim_r = -0.3 * (1 - $t);
    color("Orange")
    translate([0, 0, anim_z])
    rotate([anim_r, 0, 0])
        clip_wega();
}