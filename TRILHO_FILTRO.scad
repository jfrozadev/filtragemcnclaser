// ==========================================
// TRILHO DESLIZANTE PARA FILTROS REMOVÍVEIS
// Impressão 3D - PLA/PETG (Ender 3 - 200×200mm)
// ==========================================
//
// CONCEITO: Trilhos em U colados/parafusados na face interna
// das laterais. Cada filtro (divisória MDF) desliza de cima
// para baixo nos trilhos. Remove tampa snap-fit → puxa filtro.
//
// Cada trilho = 2 METADES com encaixe dovetail no meio
//   Metade A: 122mm (com dovetail macho)
//   Metade B: 122mm (com dovetail fêmea)
//   Montado: 244mm (largura interna da caixa)
//
// 6 PARES de trilhos (esq + dir por pos):
//   1. Manta G3     (X=50mm,  esp=10mm)
//   2. GM Cabine     (X=75mm,  esp=20mm)
//   3. Wega Motor    (X=125mm,  esp=45mm)
//   4. HEPA          (X=155mm, esp=25mm)
//   5. Tela Carvão 1 (X=190mm, esp=3mm)
//   6. Tela Carvão 2 (X=230mm, esp=3mm)
//
// PEÇAS POR FILTRO:
//   2× metade A (esq+dir) + 2× metade B (esq+dir) = 4 peças
//   Total: 6×4 = 24 peças (12 impressões se imprimir 2 por vez)
//
// Alternativamente: os trilhos finos (tela carvão 3mm) e os
// padrão (10-25mm) podem compartilhar o mesmo perfil com canal
// ajustável. Filtros mais grossos (Wega 45mm) = trilho largo.
//
// ORIENTAÇÃO DE IMPRESSÃO:
//   Deitado (perfil U para cima) - sem suportes necessários
//   Layer 0.2mm | Infill 40% | Walls 3
//
// FIXAÇÃO NAS LATERAIS:
//   - Cola CA (cianoacrilato) + parafuso M2×8 (opcional)
//   - 2 furos Ø2.2mm no fundo do trilho para parafusos
//
// ENDER 3: 200×200mm bed
//   Metade 122mm → cabe facilmente horizontal
//   Largura máx do trilho: ~15mm → 12 metades em 1 impressão!
//
// ==========================================

// === PARÂMETROS GLOBAIS ===

// MDF
mdf = 3;              // Espessura MDF das divisórias (mm)
folga = 0.4;          // Folga do canal (MDF 3mm + 0.4 = canal 3.4mm)
caixa_int = 244;      // Largura interna da caixa (entre laterais)

// Trilho
trilho_comp = 122;    // Comprimento de cada metade (244/2)
trilho_alt = 240;     // Altura do trilho (deixa 5mm em cima para puxar)
trilho_parede = 2;    // Espessura da parede do U
trilho_base = 2;      // Espessura da base (cola no MDF lateral)
trilho_aba = 8;       // Altura da aba do U (guia o MDF)

// Dovetail (encaixe das 2 metades)
dove_larg = 6;        // Largura na base do dovetail
dove_topo = 8;        // Largura no topo (trapézio)
dove_alt = 8;         // Comprimento do encaixe (na direção do trilho)
dove_prof = 4;        // Profundidade (metade da espessura)

// Furos de fixação
furo_diam = 2.2;      // Diâmetro para parafuso M2
furo_dist = 30;       // Distância entre furos (do centro)
n_furos = 3;          // Furos por metade

// Puxador (aba no topo do filtro para puxar)
puxador_larg = 30;    // Largura do puxador
puxador_alt = 15;     // Quanto sobe acima do filtro
puxador_esp = 3;      // Espessura

// Canal para cada tipo de filtro (espessura)
// Canal = espessura do filtro + folga
// Os trilhos formam o canal: 2 abas paralelas com espaço entre elas

// === MÓDULOS ===

// Perfil em U (seção transversal do trilho)
// canal_w = largura do canal (esp. filtro + folga)
module perfil_u(canal_w, comprimento) {
    // Base (cola no MDF)
    largura_total = canal_w + 2 * trilho_parede;
    
    translate([0, 0, 0])
    difference() {
        // Bloco sólido
        cube([largura_total, comprimento, trilho_base + trilho_aba]);
        
        // Canal interno (onde o filtro desliza)
        translate([trilho_parede, -0.1, trilho_base])
            cube([canal_w, comprimento + 0.2, trilho_aba + 0.1]);
    }
}

// Dovetail macho (trapézio que sai)
module dovetail_macho() {
    hull() {
        translate([0, 0, 0])
            cube([dove_larg, dove_alt, 0.1]);
        translate([-(dove_topo - dove_larg)/2, 0, dove_prof])
            cube([dove_topo, dove_alt, 0.1]);
    }
}

// Dovetail fêmea (encaixe negativo)
module dovetail_femea() {
    hull() {
        translate([-0.1, -0.1, -0.1])
            cube([dove_larg + 0.2, dove_alt + 0.2, 0.1]);
        translate([-(dove_topo - dove_larg)/2 - 0.1, -0.1, dove_prof + 0.1])
            cube([dove_topo + 0.2, dove_alt + 0.2, 0.1]);
    }
}

// Metade A (com dovetail macho na ponta)
module trilho_metade_a(canal_w) {
    largura_total = canal_w + 2 * trilho_parede;
    
    difference() {
        union() {
            // Perfil U
            perfil_u(canal_w, trilho_comp);
            
            // Dovetail macho (na ponta Y=trilho_comp)
            translate([largura_total/2 - dove_larg/2, trilho_comp, (trilho_base + trilho_aba)/2 - dove_alt/2])
            rotate([0, -90, 0])
            rotate([0, 0, 90])
                dovetail_macho();
        }
        
        // Furos de fixação (no fundo/base)
        for (i = [1:n_furos]) {
            translate([largura_total/2, trilho_comp * i/(n_furos+1), -0.1])
                cylinder(h = trilho_base + 0.2, d = furo_diam, $fn = 20);
        }
    }
}

// Metade B (com dovetail fêmea na ponta)
module trilho_metade_b(canal_w) {
    largura_total = canal_w + 2 * trilho_parede;
    
    difference() {
        // Perfil U
        perfil_u(canal_w, trilho_comp);
        
        // Dovetail fêmea (na ponta Y=0, receptor)
        translate([largura_total/2 - dove_larg/2, -dove_alt, (trilho_base + trilho_aba)/2 - dove_alt/2])
        rotate([0, -90, 0])
        rotate([0, 0, 90])
            dovetail_femea();
        
        // Furos de fixação
        for (i = [1:n_furos]) {
            translate([largura_total/2, trilho_comp * i/(n_furos+1), -0.1])
                cylinder(h = trilho_base + 0.2, d = furo_diam, $fn = 20);
        }
    }
}

// Par de trilhos montado (244mm) - para visualização
module trilho_completo(canal_w) {
    color("DodgerBlue")
        trilho_metade_a(canal_w);
    color("RoyalBlue")
    translate([0, trilho_comp, 0])
        trilho_metade_b(canal_w);
}

// Puxador (impresso junto ou separado)
module puxador() {
    difference() {
        union() {
            // Corpo que abraça a borda do filtro
            cube([puxador_larg, mdf + folga + 2*trilho_parede, puxador_alt]);
            
            // Reforço/rampa
            translate([0, 0, puxador_alt])
                cube([puxador_larg, mdf + folga + 2*trilho_parede, 2]);
        }
        
        // Canal para o MDF do filtro
        translate([trilho_parede, -0.1, -0.1])
            cube([puxador_larg - 2*trilho_parede, mdf + folga + 0.2, puxador_alt - 3]);
    }
}

// Trava de retenção (evita filtro cair, clip no fundo do trilho)
module trava() {
    // Pequena lingueta flexível no fim do trilho
    largura = 10;
    altura = 8;
    espessura = 1.2;
    gancho = 1.0;
    
    // Haste flexível
    cube([largura, espessura, altura]);
    
    // Gancho na ponta
    translate([0, -gancho, altura - 1.5])
        cube([largura, gancho + espessura, 1.5]);
}

// === CONFIGURAÇÕES POR FILTRO ===
// [nome, posição_x, espessura_filtro, canal_necessario]

// Canais calculados:
// - MDF 3mm: canal = 3 + 0.4 = 3.4mm
// - Manta G3 (10mm): acolchoada, canal = 12mm (filtro comprime)
// - GM Cabine (20mm): canal = 21mm
// - Wega Motor (45mm): canal = 46mm
// - HEPA (25mm): canal = 26mm

canais = [
    [15,   12],   // Manta G3: esp efetiva ~10mm c/ MDF holder
    [40,   21],   // GM Cabine Bosch
    [90,   46],   // Wega Motor (o mais largo!)
    [120,  26],   // HEPA
    [165, 3.4],   // Tela Carvão 1 (MDF 3mm)
    [210, 3.4],   // Tela Carvão 2 (MDF 3mm)
];

// ============================
// RENDER / VISUALIZAÇÃO
// ============================

// --- Opção 1: Metade A individual (para impressão) ---
// Descomente para gerar STL de cada tipo:

// Trilho fino (Tela Carvão, MDF 3mm)
trilho_metade_a(3.4);

// --- Opção 2: Par montado (visualização) ---
translate([20, 0, 0])
    trilho_completo(3.4);

// Trilho médio (GM Cabine 20mm)
translate([40, 0, 0])
    trilho_metade_a(21);

translate([75, 0, 0])
    trilho_completo(21);

// Trilho largo (Wega 45mm)
translate([110, 0, 0])
    trilho_metade_a(46);

// --- Opção 3: Puxador ---
translate([0, -30, 0])
    color("Orange")
        puxador();

// --- Opção 4: Trava ---
translate([40, -30, 0])
    color("Red")
        trava();

// ============================
// LAYOUT PARA IMPRESSÃO (Ender 3)
// Exemplo: 4 metades finas na cama
// ============================
/*
// Layout para cama 200×200mm
for (i = [0:3]) {
    translate([i * 12, 0, 0])
        trilho_metade_a(3.4);
}
for (i = [0:3]) {
    translate([i * 12, 130, 0])
        trilho_metade_b(3.4);
}
// 8 peças em 1 impressão! (~58×122mm cada → cabem 12)
*/

// ============================
// INFORMAÇÕES DE IMPRESSÃO
// ============================
// - Material: PLA ou PETG
// - Layer: 0.2mm (0.28 para speed)
// - Infill: 40% (grid ou gyroid)
// - Walls: 3 perímetros
// - Suporte: NÃO necessário (perfil U imprime deitado)
// - Orientação: abas do U para cima
// - Tempo estimado por par: ~40min (fino) / ~1h20 (médio) / ~2h (largo)
//
// QUANTIDADE TOTAL DE PEÇAS:
// | Filtro       | Canal  | Peças |
// |------------- |--------|-------|
// | Manta G3     | 12mm   |  4    |
// | GM Cabine    | 21mm   |  4    |
// | Wega Motor   | 46mm   |  4    |
// | HEPA         | 26mm   |  4    |
// | Tela Carv 1  | 3.4mm  |  4    |
// | Tela Carv 2  | 3.4mm  |  4    |
// | TOTAL        |        | 24    |
// | + 6 puxadores + 6 travas = 36 peças total
//
// IMPRESSÕES OTIMIZADAS (agrupando por tamanho):
// Batch 1: 8× metades finas (3.4mm) → 1 print ~50min
// Batch 2: 4× metades Manta G3 (12mm) → 1 print ~1h
// Batch 3: 4× metades GM (21mm) → 1 print ~1h20
// Batch 4: 4× metades HEPA (26mm) → 1 print ~1h30
// Batch 5: 4× metades Wega (46mm) → 1 print ~2h
// Batch 6: 6× puxadores + 6× travas → 1 print ~45min
// Total: ~6 impressões, ~7h30 de tempo de impressão
