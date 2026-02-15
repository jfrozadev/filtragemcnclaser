# 📦 CAIXA DE FILTRAGEM 250×250×250mm
## ✅ VERSÃO 12.0 - Abertura Reduzida + Clips Parametrizados por Filtro

---

## ⚠️ CORREÇÕES DESTA VERSÃO (CRÍTICAS):

### 🔧 PROBLEMAS ORIGINAIS:
1. Os arquivos originais tinham **dentes e ranhuras nas mesmas posições Y**
2. Os **slots das divisórias** nas laterais foram removidos (trilhos 3D substituem)

### ✅ CORREÇÕES APLICADAS:

**1. Frontal e Traseira - Padrão de dentes INVERTIDO:**
   - Antes: Dentes em Y=25-50, 75-100, 125-150, 175-200, 225-250
   - Agora: Dentes em Y=**0-25**, **50-75**, **100-125**, **150-175**, **200-225**

**2. Sistema de Encaixe Complementar:**
   ```
   LATERAL (ranhuras):    ░░███░░███░░███░░███░░███
   FRONTAL (dentes):      ███░░███░░███░░███░░███░░
   Posição Y:            0  25 50 75 100 ... 225 250
   
   █ = Sólido (25mm)
   ░ = Recuo/Dente (25mm)
   ```

**3. Slots das Divisórias REMOVIDOS:**
   - Divisórias agora deslizam nos trilhos 3D impressos
   - Sem abas nas divisórias, sem slots nas laterais

**4. Lateral Direita ESPELHADA:**
   - Slots espelhados para encaixar corretamente quando montada

**5. Filtro Wega:** 220×160mm (22×16cm) - VERIFICADO ✓

---

## ⚙️ PARÂMETROS DE CORTE

| Parâmetro | Valor |
|-----------|-------|
| **Potência** | S1000 (100%) |
| **Velocidade** | F150 mm/min |
| **Passagens** | 3× |
| **Air Assist** | OBRIGATÓRIO |

---

## 📐 DIMENSÕES DO CUBO 250mm

### Estrutura Principal:
| Peça | Dimensão | Espessura | Qtd |
|------|----------|-----------|-----|
| Laterais (Esq/Dir) | 250×250mm | 3mm | 2 |
| Frontal (entrada) | 244×250mm | 3mm | 1 |
| Traseira (saída) | 244×250mm | 3mm | 1 |
| Tampa | 250×250mm | 3mm | 1 |
| Base | 250×250mm | 3mm | 1 |

### Divisórias (retângulos simples 244×240mm, deslizam nos trilhos):
| Peça | Corpo | Furo do Filtro | Espessura Filtro |
|------|-------|----------------|------------------|
| Manta G3 | 244×240mm | 200×200mm | **10mm** |
| GM Cabine Bosch | 244×240mm | **212×200mm** (reduzida) | **20mm** |
| Wega Motor | 244×240mm | **223×160mm** | **10mm** |
| **FILTRO HEPA** | 244×240mm | **100×130mm** (reduzida) | borda **2mm** esp. × 5mm larg. |
| Tela Carvão (×2) | 244×240mm | Abertura 200×200mm + 16 furos M3 | — |

### Compartimento de Carvão Ativado:
| Item | Descrição |
|------|----------|
| Telas MDF (×2) | 244×240mm com abertura central 200×200mm (11_GAVETA.nc) |
| Caixa MDF (quadro) | 4 bordas ao redor da abertura com encaixe tela (13_CAIXA_CARVAO.nc) |
| Tela alumínio | Mosquiteira fixada com 16 paraf. M3+arruela por tela |
| Posições (slots) | X=190mm (Tela 1) e X=230mm (Tela 2) |
| Espaço interno | 37mm entre telas → ~500g carvão ativado |
| Caixa montada | Quadro 200×200×37mm (4 bordas encaixadas ao redor da abertura) |
| Abas conexão tela | 8 abas (10×3mm) encaixam em 8 slots nas telas, juntando 2 MDF |
| Snap-fit (3D print) | 16 clips (8 topo + 8 base) – SNAP_TAMPA.scad |
| Retenção filtro (3D print) | 28 clips paramétricos (8 Manta + 8 GM + 4 Wega + 8 HEPA) – SNAP_TAMPA.scad |

---

## 📁 ARQUIVOS DE CORTE (12 total)

| # | Arquivo | Descrição |
|---|---------|-----------|
| 1 | `01_LATERAL_ESQ.nc` | 250×250mm com ranhuras + snap-fit + furos M2 trilhos |
| 2 | `02_LATERAL_DIR.nc` | Idêntica (espelhada) + snap-fit + furos M2 trilhos |
| 3 | `03_FRONTAL.nc` | 244×250mm com dentes + furo 70mm + snap-fit |
| 4 | `04_TRASEIRA.nc` | 244×250mm com dentes + furo 150mm + snap-fit |
| 5 | `05_TAMPA.nc` | 250×250mm placa lisa (fixação por snap-fit) |
| 6 | `06_BASE.nc` | 250×250mm + 4 furos para pés de borracha |
| 7 | `07_DIVISORIA_MANTA_G3.nc` | 244×240mm + furo 200×200mm + 8 furos M3 Ø3.5mm |
| 8 | `08_DIVISORIA_GM.nc` | 244×240mm + furo **212×200mm** + 8 furos M3 Ø3.5mm |
| 9 | `09_DIVISORIA_WEGA.nc` | 244×240mm + furo **223×160mm** + **4** furos M3 Ø3.5mm |
| 10 | `10_DIVISORIA_HEPA.nc` | 244×240mm + furo **100×130mm** + 8 furos M3 Ø3.5mm |
| 11 | `11_GAVETA.nc` | 2× tela carvão 244×240mm (abertura 200×200, M3 + 8 slots quadro) |
| 12 | `12_FLANGES.nc` | Entrada 70mm + Saída 150mm |
| 13 | `13_CAIXA_CARVAO.nc` | 4× bordas MDF quadro carvão (ao redor abertura, c/ abas tela) |
| 14 | `TRILHO_FILTRO.scad` | Trilhos deslizantes 3D (filtros removíveis, Ender 3) |
| 15 | `TRILHO_PRINT_LAYOUT.scad` | Layout de impressão COMPLETO (10 batches, 200×200mm) |
| 16 | `SNAP_TAMPA.scad` | Clips snap-fit + vedação divisória particionada |
| 17 | `FLANGE_150mm.scad` | Flange 150mm (180×180mm base, cabe em 200×200) |
| 18 | `FLANGE_70mm.scad` | Flange 70mm (100×100mm base) |
| 19 | `TRILHO_3D.html` | Visualização 3D interativa dos trilhos |

---

## 🔧 SISTEMA DE ENCAIXE

### Finger Joints (Laterais ↔ Frontal/Traseira):
```
LATERAL (ranhuras):     FRONTAL (dentes):
    ┌───┐                   ├───┤
────┘   └────           ────┤   ├────
 (3mm profundidade)      (3mm salientes)
 
Os DENTES do frontal/traseira entram
nas RANHURAS das laterais!
```

### Divisórias (Deslizam nos Trilhos 3D):
```
LATERAL:               DIVISÓRIA:
   │     │                244×240mm
   │ ███ │ ← trilho 3D    ──────
   │ ││  │                │ MDF │  ← desliza no U
   │ ███ │ ← trilho 3D    ──────
   │     │
   
Trilhos em U fixados com cola CA + Allen M2×5mm
Divisórias deslizam de cima, sem abas/slots
```

### Compartimento Carvão (Quadro ao Redor da Abertura):
```
LATERAL:
   │ ▭ │ X=190mm  (Tela 1)
   │   │  ← quadro carvão (37mm) ao redor da abertura
   │ ▭ │ X=230mm  (Tela 2)
   
VISTA FRONTAL (quadro entre as 2 telas):
   ┌────────────────────────┐
   │  ┌──────────────────┐  │
   │  │  abertura 200×200  │  │ ← borda 22mm da tela
   │  │  (carvão + tela)   │  │
   │  └──────────────────┘  │
   └────────────────────────┘
     ↑ quadro MDF (4 bordas com encaixe tab-slot)

VISTA LATERAL (corte mostrando encaixe):
   Tela2 ═══╤════════╤═══  ← aba atravessa slot
            │ carvão │
            │  37mm  │     ← borda MDF 3mm
            │        │
   Tela1 ═══╧════════╧═══  ← aba atravessa slot

4 bordas MDF formam quadro ao redor da abertura
8 abas (2/borda) atravessam 8 slots nas telas
Encaixes juntam Tela 1 + Quadro + Tela 2
Tela alumínio (mosquiteira) parafusada c/ M3+arruela
16 furos 3.5mm por placa (4 por lado)
Encaixam nos trilhos laterais como as outras divisórias
```

### Trilhos Deslizantes (Filtros Removíveis por Cima):
```
VISTA LATERAL (corte da lateral esquerda):
   TAMPA (remove snap-fit)
   │                    │
   │  ↑ filtro sobe ↑   │
   │  ┌───────────┐  │
   │╣█╣ divisória  ╣█╣│  ← trilho U impresso 3D
   │╣█╣ MDF 3mm   ╣█╣│    colado na lateral
   │╣█╣           ╣█╣│
   │  └───────────┘  │
   │   └─ trava ─┘   │  ← clipe de retenção (evita cair)
   └──────────────────┘
   BASE

PERFIL DO TRILHO (seção transversal):
   ┌─┐   ┌─┐
   │ │   │ │  ← abas guiam o MDF
   │ ╠═══╣ │  ← canal (esp. filtro + 0.4mm)
   └─┴───┴─┘  ← base (cola no MDF lateral)

2 METADES com junta reta (122mm + 122mm = 244mm):
   Cabe na Ender 3 (200×200mm)
   Fixadas com cola CA + parafuso M2 (sem dovetail)
```

| Filtro | Pos X | Canal | Peças (2×metade A + 2×metade B) |
|--------|-------|-------|-------------------------------|
| Manta G3 | 50mm | 17mm | 4 |
| GM Cabine | 75mm | 21mm | 4 |
| Wega Motor | 125mm | 46mm | 4 |
| HEPA | 155mm | 26mm | 4 |
| Tela Carvão 1 | 190mm | 3.4mm | 4 |
| Tela Carvão 2 | 230mm | 3.4mm | 4 |
| **TOTAL** | | | **24 + 6 puxadores + 6 travas = 36** |

### 🖨️ LAYOUT IMPRESSÃO 3D (Ender 3 - 200×200mm)

**Todas as peças cabem na mesa de 200×200mm!**

| Batch | Peças | Qtd | Tempo | Tamanho |
|-------|-------|-----|-------|---------|
| 1 | Trilhos Tela Carvão (3.4mm) | 8 | ~50min | 80×122mm ✓ |
| 2 | Trilhos Manta G3 (17mm) | 4 | ~1h | 88×122mm ✓ |
| 3 | Trilhos GM Cabine (21mm) | 4 | ~1h20 | 109×122mm ✓ |
| 4 | Trilhos HEPA (26mm) | 4 | ~1h30 | 129×122mm ✓ |
| 5A | Trilhos Wega A (46mm) | 2 | ~1h | 103×122mm ✓ |
| 5B | Trilhos Wega B (46mm) | 2 | ~1h | 103×122mm ✓ |
| 6 | Puxadores + Travas | 12 | ~45min | 200×33mm ✓ |
| 7 | Snap Clips + Retenção | 44 | ~5h30 | 184×135mm ✓ |
| 8 | Vedação Divisória (8 seg) | 8 | ~1h30 | 130×65mm ✓ |
| 9 | Flange 150mm | 1 | ~3h | 180×180mm ✓ |
| 10 | Flange 70mm | 1 | ~1h30 | 100×100mm ✓ |
| **TOTAL** | | **62** | **~15h30** | |

**Arquivo:** `TRILHO_PRINT_LAYOUT.scad` — abrir no OpenSCAD, descomentar batch desejado, F6+F7 para exportar STL.

### Sistema Híbrido de Clips:
```
SNAP-FIT (fechar caixa - tampa + base):
  16 clips impressos em PLA/PETG (8 topo + 8 base)
  Perna ext: 30mm | Perna int: 24mm | Gancho: 1.2mm
  Slots MDF: 22×2mm perfurados nos 4 painéis
  Posições: Y=220mm (topo) e Y=30mm (base)

RETENÇÃO FILTRO (fixar filtro na divisória - parafuso M3):
  32 clips retenção impressos em PLA/PETG
  8 por divisória × 4 divisórias (Manta G3, GM, Wega, HEPA)
  Base: 20×15×3mm | Braço: 20×2×12mm | Aba: 20×10×2mm
  8 furos M3 Ø3.5mm por divisória ao redor da abertura do filtro:
    Manta G3: (12,80)(12,160)(232,80)(232,160)(88,10)(156,10)(88,230)(156,230)
    GM Cabine: (5,80)(5,160)(239,80)(239,160)(82,7)(162,7)(82,232)(162,232)
    Wega: (6,80)(6,160)(238,80)(238,160)(82,19)(162,19)(82,221)(162,221)
    HEPA: (57,90)(57,150)(187,90)(187,150)(102,40)(142,40)(102,200)(142,200)
  Fixação: parafuso M3×10mm + porca M3

TOTAL: 48 clips (16 snap-fit + 32 retenção filtro)

Vedação divisória (opcional):
  8 segmentos com encaixes dovetail (~122mm cada)
  Particionada para caber na mesa 200×200mm
```

---

## 🛠️ ORDEM DE MONTAGEM

1. **Base** → Colocar na mesa
2. **Lateral Esquerda** → Cole sobre a borda da base
3. **Lateral Direita** → Paralela, a 244mm de distância
4. **Frontal** → Dentes nos slots das laterais
5. **Traseira** → Igual ao frontal
6. **Trilhos 3D** → Fixar nas laterais com cola CA + parafuso Allen M2×5mm (furos Ø2.5mm pré-cortados, 12/lateral)
7. **Divisórias filtro** → Deslizar de cima pelos trilhos + fixar cada filtro com 8 clips retenção (M3×10mm) ao redor da abertura
8. **Telas carvão (×2)** → Deslizar nos trilhos X=190 e X=230
9. **Caixa carvão** → Encaixar 4 tiras + preencher com carvão
10. **Tampa** → Encaixar com 16 clips snap-fit (sem parafusos)

---

## 🎯 VERIFICAÇÃO 3D

Abra `MONTAGEM_3D.html` no navegador para:
- Ver a montagem passo a passo (12 passos)
- Verificar encaixes visuais, incluindo trilhos
- Rotacionar e dar zoom no modelo

Abra `TRILHO_3D.html` para:
- Ver trilhos deslizantes em detalhe
- Animar deslizamento dos filtros
- Ver encaixe dovetail das 2 metades

| Divisória | Posição X | Espessura | Espaço até próximo | Função |
|-----------|-----------|-----------|-------------------|--------|
| *(plenum entrada)* | *3mm* | — | *47mm→G3* | *Expansão do ar (47mm)* |
| Manta G3 | **50mm** | 10mm | 22mm→GM | Pré-filtro (partículas grandes) |
| GM Cabine Bosch | **75mm** | 20mm | 47mm→Wega | Filtro cabine (partículas médias) |
| Wega Motor | **125mm** | 45mm | 27mm→HEPA | Filtro motor (partículas finas) |
| **FILTRO HEPA** | **155mm** | 25mm | 32mm→Tela 1 | **Filtro HEPA** |
| Tela Carvão 1 | **190mm** | 3mm (MDF) | 37mm→Tela 2 | Retém carvão (lado interno) |
| Tela Carvão 2 | **230mm** | 3mm (MDF) | 17mm→Traseira | Retém carvão (lado traseira) |

---

## 📋 MATERIAIS

- MDF 3mm: ~15 chapas 300×300mm
- Manta G3 (pré-filtro) 10mm - fixada com 8 clips 3D (CLIP_MANTA_G3.scad)
- Filtro GM Cabine Bosch 20mm
- Filtro Wega Motor 45mm
- **Filtro HEPA** (110×140×25mm)
- Carvão ativado ~500g (granulado)
- Tela alumínio mosquiteira (2× para telas carvão)
- 32× Parafuso M3 + arruela (16 por tela)
- Cola PVA + Silicone
- 16× Clips snap-fit impressos em PLA/PETG (SNAP_TAMPA.scad)
- 32× Clips retenção filtro impressos em PLA/PETG (SNAP_TAMPA.scad)
- 32× Parafuso M3×10mm + 32× porca M3 (fixação clips retenção nas divisórias)
- 8× Clips manta G3 impressos em PLA/PETG (CLIP_MANTA_G3.scad)
- 24× Trilhos deslizantes impressos em PLA/PETG (TRILHO_FILTRO.scad)
- 6× Puxadores + 6× Travas impressos (TRILHO_FILTRO.scad)
- 8× Vedação divisória (opcional) impressos (SNAP_TAMPA.scad)
- 2× Flanges impressos (FLANGE_150mm.scad + FLANGE_70mm.scad)
- 24× Parafuso Allen M2×5mm (fixação trilhos, 12 por lateral — rosca no PLA, sem porca)
- Filamento PLA/PETG ~150g

---

**Versão:** 11.0 — Sistema híbrido clips (snap-fit tampa/base + retenção filtro parafuso divisórias)  
**Data:** Fevereiro 2026
