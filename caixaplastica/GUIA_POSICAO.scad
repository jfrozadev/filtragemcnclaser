// =====================================================
// GUIA DE POSIÇÃO — Caixa Plástica Ordene 30L
// Espaçadores no fundo da caixa que posicionam as divisórias
// =====================================================
//
// CONCEITO:
//   MDF 300×300×3mm encaixa justo na caixa (301mm interno).
//   Não precisa de trilhos laterais!
//   Apenas guias no fundo definem a posição Y de cada divisória.
//
//   VISTA LATERAL (corte):
//
//   ├── parede caixa ──┤
//   │                  │
//   │  MDF  MDF  MDF   │  ← divisórias 300×300mm
//   │  │ ║  │ ║  │     │     encaixam justo na largura
//   │  │ ║  │ ║  │     │
//   │  │ ║  │ ║  │     │
//   │  ▼ ║  ▼ ║  ▼     │
//   └──█══█══█══█══────┘  ← guias no fundo
//       ↑    ↑    ↑
//      guias definem posição Y
//
//   PERFIL DA GUIA (seção transversal em Y):
//
//     canal ← MDF 3mm desliza aqui
//   ┌─┐   ┌─┐
//   │ │ ░ │ │  ← paredes 1.5mm
//   │ │   │ │     50mm de altura
//   │ │   │ │     (anti-tombo)
//   │ └───┘ │
//   └───────┘  ← base 2mm (cola no fundo da caixa)
//
//   BARRA ANTI-TOMBO (repousa no aro da caixa):
//
//   ┌─────────■───────■──────────■───────┐
//   │        G3      GM       WEGA       │  ← rasgos para MDF
//   └────────────────────────────────────┘
//   Seção 1: G3+GM+Wega (135mm)  |  Seção 2: HEPA+C1+C2 (125mm)
//   2 seções × 2 lados = 4 peças
//
// =====================================================

// ═══ PARÂMETROS DA CAIXA ═══
caixa_int_w = 301;   // largura interna
caixa_int_d = 419;   // profundidade interna
caixa_int_h = 297;   // altura interna
parede_plastico = 3;

// ═══ PARÂMETROS MDF ═══
mdf_w = 300;          // largura MDF (chapa inteira)
mdf_h = 300;          // altura MDF
mdf_esp = 3;          // espessura
folga = 0.4;          // folga canal

// ═══ PARÂMETROS DA GUIA ═══
canal = mdf_esp + folga;     // 3.4mm
parede = 1.5;                // parede do canal
base_w = canal + 2*parede;   // 6.4mm largura total
base_h = 2;                  // altura da base (superfície de colagem)
guia_alt = 50;               // altura das paredes guia (anti-tombo)
guia_comp = 80;              // comprimento da guia (transversal à caixa)

// Comprimento cabe dentro da caixa (fundo, um de cada lado)
// 2 guias por posição: uma no fundo-esquerda, outra no fundo-direita

echo(str("=== GUIA DE POSIÇÃO + BARRA ANTI-TOMBO ==="));
echo(str("Guia piso: canal ", canal, "mm | ", base_w, "×", guia_comp, "×", guia_alt+base_h, "mm"));
echo(str("Barra topo: ", barra_larg, "×", barra_alt, "mm | S1=", barra1_comp, "mm | S2=", barra2_comp, "mm"));
echo(str("MDF 300×300 encaixa justo em 301mm (folga 0.5mm/lado)"));

// ═══ POSIÇÕES DAS DIVISÓRIAS (Y desde parede frontal) ═══
pos_manta_g3  = 50;
pos_gm_cabine = 95;
pos_wega      = 165;
pos_hepa      = 245;
pos_tela1     = 310;
pos_tela2     = 350;

posicoes = [pos_manta_g3, pos_gm_cabine, pos_wega, pos_hepa, pos_tela1, pos_tela2];
nomes = ["G3", "GM", "WEGA", "HEPA", "C1", "C2"];

// =====================================================
// MÓDULOS
// =====================================================

module guia_perfil() {
    // Perfil em U (seção transversal)
    // Base
    square([base_w, base_h]);
    // Parede esquerda
    translate([0, base_h])
        square([parede, guia_alt]);
    // Parede direita
    translate([parede + canal, base_h])
        square([parede, guia_alt]);
}

module guia_piso(comp = guia_comp, nome = "") {
    // Guia completa para colar no fundo da caixa
    difference() {
        linear_extrude(comp)
            guia_perfil();
        
        // Gravação do nome (se fornecido)
        if (nome != "") {
            translate([base_w/2, base_h + guia_alt - 0.3, comp/2])
                rotate([0, 0, 0])
                    linear_extrude(0.4)
                        text(nome, size = 4, halign = "center", valign = "center",
                             font = "Liberation Sans:style=Bold");
        }
    }
}

module guia_dupla(comp = guia_comp, nome = "") {
    // Par de guias para 1 posição (esq + dir, espelhadas no fundo da caixa)
    guia_piso(comp, nome);
    // A segunda guia fica do outro lado do fundo
    // (distância = largura interna da caixa - comprimento guia)
    translate([0, 0, caixa_int_w - comp])
        guia_piso(comp, nome);
}

// =====================================================
// BARRA ANTI-TOMBO (topo da caixa)
// =====================================================
// Impede que as divisórias tombem para frente/trás.
// Repousa sobre o aro da caixa, com rasgos nos pontos
// de cada divisória. 2 seções (cabem na impressora) × 2 lados = 4 peças.

barra_larg    = 15;     // largura (assenta no aro da caixa)
barra_alt     = 20;     // altura da barra
barra_encaixe = 14;     // profundidade do rasgo (MDF entra por baixo)

// Seção 1: G3(50) + GM(95) + Wega(165) → Y=40..175 = 135mm
// Seção 2: HEPA(245) + C1(310) + C2(350) → Y=235..360 = 125mm
barra1_ini = 40;   barra1_comp = 135;
barra2_ini = 235;  barra2_comp = 125;

barra1_rasgos = [pos_manta_g3  - barra1_ini,
                 pos_gm_cabine - barra1_ini,
                 pos_wega      - barra1_ini];

barra2_rasgos = [pos_hepa  - barra2_ini,
                 pos_tela1 - barra2_ini,
                 pos_tela2 - barra2_ini];

module barra_topo(comp, rasgos, nome="") {
    difference() {
        cube([comp, barra_larg, barra_alt]);
        // Rasgos (de baixo para cima) — MDF entra por baixo
        for (p = rasgos) {
            translate([p - canal/2, -0.1, -0.1])
                cube([canal, barra_larg + 0.2, barra_encaixe + 0.1]);
        }
        // Gravação do nome
        if (nome != "") {
            translate([comp/2, barra_larg/2, barra_alt - 0.3])
                linear_extrude(0.4)
                    text(nome, size=5, halign="center", valign="center",
                         font="Liberation Sans:style=Bold");
        }
    }
}

module batch_barras() {
    // 4 peças: seção1 esq, seção1 dir, seção2 esq, seção2 dir
    esp = 3;
    barra_topo(barra1_comp, barra1_rasgos, "S1-E");
    translate([0, barra_larg + esp, 0])
        barra_topo(barra1_comp, barra1_rasgos, "S1-D");
    translate([0, (barra_larg + esp) * 2, 0])
        barra_topo(barra2_comp, barra2_rasgos, "S2-E");
    translate([0, (barra_larg + esp) * 3, 0])
        barra_topo(barra2_comp, barra2_rasgos, "S2-D");
}

// =====================================================
// LAYOUT DE IMPRESSÃO
// =====================================================

module batch_todas_guias() {
    // 6 posições × 2 guias = 12 peças
    // Cada peça: 6.4 × 80 × 52mm (base 2 + guia 50)
    // Para barras anti-tombo ver: batch_barras()
    
    espaco = 3;
    for (i = [0 : len(posicoes) - 1]) {
        // Guia esquerda
        translate([(base_w + espaco) * (i * 2), 0, 0])
            guia_piso(guia_comp, str(nomes[i], "E"));
        // Guia direita
        translate([(base_w + espaco) * (i * 2 + 1), 0, 0])
            guia_piso(guia_comp, str(nomes[i], "D"));
    }
}

// =====================================================
// RENDERIZAÇÃO
// =====================================================

// Visualizar uma guia (50mm anti-tombo)
guia_piso(guia_comp, "G3");

// Descomentar para ver layout de guias piso:
// batch_todas_guias();

// Descomentar para ver layout de barras anti-tombo:
// batch_barras();

// Descomentar para ver uma barra seção 1:
// barra_topo(barra1_comp, barra1_rasgos, "S1");

// Descomentar para ver perfil 2D:
// guia_perfil();

// =====================================================
// INSTRUÇÕES DE USO
// =====================================================
//
// 1. Imprimir 12 guias de piso (batch_todas_guias)
//    + 4 barras anti-tombo (batch_barras)
//    ~1h30 total, ~40g PLA
//
// 2. Marcar posições no fundo da caixa com régua:
//    Y=50 (G3), 95 (GM), 165 (Wega), 245 (HEPA), 310 (C1), 350 (C2)
//
// 3. Colar guias piso (50mm alt.) com Super Bonder gel:
//    - 1 guia esq + 1 dir por posição (12 total)
//    - Canal alinhado com a marca
//    - MDF desliza de cima para baixo no canal
//
// 4. Encaixar barras anti-tombo no aro (topo) da caixa:
//    - 2 barras lado esquerdo + 2 lado direito (4 total)
//    - Rasgos alinham com o topo de cada divisória
//    - Impedem o MDF de tombar para frente/trás
//
// 5. MDF 300×300mm encaixa justo na largura (301mm interno)
//    Guias piso (embaixo) + barras topo (em cima) = MDF firme!
//
// SEM FUROS NA CAIXA! Só cola nas guias de piso.
// =====================================================
