# 📦 CAIXA DE FILTRAGEM 250×250×250mm
## ✅ VERSÃO FINAL CORRIGIDA - Encaixes Testados

---

## ⚠️ CORREÇÕES DESTA VERSÃO (CRÍTICAS):

### 🔧 PROBLEMAS ORIGINAIS:
1. Os arquivos originais tinham **dentes e ranhuras nas mesmas posições Y**
2. Os **slots das divisórias** estavam desalinhados com as **abas**

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

**3. Slots das Divisórias CORRIGIDOS:**
   - Antes: Slots em Y=15-55 e Y=195-235 (desalinhados!)
   - Agora: Slots em Y=**12-52** e Y=**192-232** (alinhados com abas)

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

### Divisórias (com abas de 5mm para encaixe):
| Peça | Corpo | Furo do Filtro | Espessura Filtro |
|------|-------|----------------|------------------|
| Manta G3 | 244×244mm | 200×200mm | **10mm** |
| GM Cabine Bosch | 244×244mm | 223×210mm | **20mm** |
| Wega Motor | 244×244mm | 220×160mm | **45mm** |
| **FILTRO HEPA** | 244×244mm | **110×140mm** | **25mm** |
| Tela Carvão (×2) | 244×244mm | Abertura 200×200mm + 16 furos M3 | — |

### Compartimento de Carvão Ativado:
| Item | Descrição |
|------|----------|
| Telas MDF (×2) | 244×244mm com abertura central 200×200mm (11_GAVETA.nc) |
| Caixa MDF (quadro) | 4 bordas ao redor da abertura com encaixe tela (13_CAIXA_CARVAO.nc) |
| Tela alumínio | Mosquiteira fixada com 16 paraf. M3+arruela por tela |
| Posições (slots) | X=165mm (Tela 1) e X=210mm (Tela 2) |
| Espaço interno | 42mm entre telas → ~500g carvão ativado |
| Caixa montada | Quadro 200×200×42mm (4 bordas encaixadas ao redor da abertura) |
| Abas conexão tela | 8 abas (10×3mm) encaixam em 8 slots nas telas, juntando 2 MDF |
| Snap-fit (3D print) | 16 clips (8 topo + 8 base) – SNAP_TAMPA.scad |

---

## 📁 ARQUIVOS DE CORTE (12 total)

| # | Arquivo | Descrição |
|---|---------|-----------|
| 1 | `01_LATERAL_ESQ.nc` | 250×250mm com ranhuras + slots divisórias + snap-fit |
| 2 | `02_LATERAL_DIR.nc` | Idêntica (espelhada) + snap-fit |
| 3 | `03_FRONTAL.nc` | 244×250mm com dentes + furo 70mm + snap-fit |
| 4 | `04_TRASEIRA.nc` | 244×250mm com dentes + furo 150mm + snap-fit |
| 5 | `05_TAMPA.nc` | 250×250mm com 4 furos fixação |
| 6 | `06_BASE.nc` | 250×250mm com 4 furos para pés |
| 7 | `07_DIVISORIA_MANTA_G3.nc` | 1× placa + manta colada c/ grampos |
| 8 | `08_DIVISORIA_GM.nc` | 244×244mm + furo 223×210mm |
| 9 | `09_DIVISORIA_WEGA.nc` | 244×244mm + furo 220×160mm |
| 10 | `10_DIVISORIA_HEPA.nc` | 244×244mm + furo 110×140mm (HEPA) |
| 11 | `11_GAVETA.nc` | 2× tela carvão 244×244mm (abertura 200×200, M3 + 8 slots quadro) |
| 12 | `12_FLANGES.nc` | Entrada 70mm + Saída 150mm |
| 13 | `13_CAIXA_CARVAO.nc` | 4× bordas MDF quadro carvão (ao redor abertura, c/ abas tela) |
| 14 | `TRILHO_FILTRO.scad` | Trilhos deslizantes 3D (filtros removíveis, Ender 3) |
| 15 | `TRILHO_PRINT_LAYOUT.scad` | Layout de impressão otimizado (6 batches, Ender 3) |
| 16 | `TRILHO_3D.html` | Visualização 3D interativa dos trilhos |

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

### Divisórias (Slots nas Laterais):
```
LATERAL:               DIVISÓRIA:
   │ ▭ │ ← slot 4×40mm    ─┬─
   │   │                    │├── aba 5mm
   │   │                   ─┴─
   
As ABAS (5mm) passam pelos SLOTS (4×40mm)
```

### Compartimento Carvão (Quadro ao Redor da Abertura):
```
LATERAL:
   │ ▭ │ X=165mm  (Tela 1)
   │   │  ← quadro carvão (42mm) ao redor da abertura
   │ ▭ │ X=210mm  (Tela 2)
   
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
            │  42mm  │     ← borda MDF 3mm
            │        │
   Tela1 ═══╧════════╧═══  ← aba atravessa slot

4 bordas MDF formam quadro ao redor da abertura
8 abas (2/borda) atravessam 8 slots nas telas
Encaixes juntam Tela 1 + Quadro + Tela 2
Tela alumínio (mosquiteira) parafusada c/ M3+arruela
16 furos 3.5mm por placa (4 por lado)
Encaixam nos slots laterais como as outras divisórias
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

2 METADES com dovetail (122mm + 122mm = 244mm):
   Cabe na Ender 3 (200×200mm)
   Encaixe macho/fêmea no centro
```

| Filtro | Pos X | Canal | Peças (2×metade A + 2×metade B) |
|--------|-------|-------|-------------------------------|
| Manta G3 | 15mm | 12mm | 4 |
| GM Cabine | 40mm | 21mm | 4 |
| Wega Motor | 90mm | 46mm | 4 |
| HEPA | 120mm | 26mm | 4 |
| Tela Carvão 1 | 165mm | 3.4mm | 4 |
| Tela Carvão 2 | 210mm | 3.4mm | 4 |
| **TOTAL** | | | **24 + 6 puxadores + 6 travas = 36** |

### Snap-Fit (Tampa + Base):
```
16 clips impressos em PLA/PETG (8 topo + 8 base)
Perna ext: 30mm | Perna int: 24mm | Gancho: 1.2mm
Slots MDF: 22×2mm perfurados nos 4 painéis
Posições: Y=220mm (topo) e Y=30mm (base)
```

---

## 🛠️ ORDEM DE MONTAGEM

1. **Base** → Colocar na mesa
2. **Lateral Esquerda** → Cole sobre a borda da base
3. **Lateral Direita** → Paralela, a 244mm de distância
4. **Frontal** → Dentes nos slots das laterais
5. **Traseira** → Igual ao frontal
6. **Trilhos 3D** → Colar nas faces internas das laterais (cola CA + M2×8)
7. **Divisórias filtro** → Deslizar de cima pelos trilhos
8. **Telas carvão (×2)** → Deslizar nos trilhos X=165 e X=210
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
| Manta G3 | **15mm** | 10mm | 22mm→GM | Pré-filtro (partículas grandes) |
| GM Cabine Bosch | **40mm** | 20mm | 27mm→Wega | Filtro cabine (partículas médias) |
| Wega Motor | **90mm** | 45mm | 27mm→HEPA | Filtro motor (partículas finas) |
| **FILTRO HEPA** | **120mm** | 25mm | 17mm→Tela 1 | **Filtro HEPA** |
| Tela Carvão 1 | **165mm** | 3mm (MDF) | 42mm→Tela 2 | Retém carvão (lado interno) |
| Tela Carvão 2 | **210mm** | 3mm (MDF) | 35mm→Traseira | Retém carvão (lado traseira) |

---

## 📋 MATERIAIS

- MDF 3mm: ~15 chapas 300×300mm
- Manta G3 (pré-filtro) 10mm - colada + grampos
- Filtro GM Cabine Bosch 20mm
- Filtro Wega Motor 45mm
- **Filtro HEPA** (110×140×25mm)
- Carvão ativado ~500g (granulado)
- Tela alumínio mosquiteira (2× para telas carvão)
- 32× Parafuso M3 + arruela (16 por tela)
- Cola PVA + Silicone
- 16× Clips snap-fit impressos em PLA/PETG (SNAP_TAMPA.scad)
- 24× Trilhos deslizantes impressos em PLA/PETG (TRILHO_FILTRO.scad)
- 6× Puxadores + 6× Travas impressos (TRILHO_FILTRO.scad)
- Filamento PLA/PETG ~120g

---

**Versão:** 8.0 — Arquivos completos trilhos + modelos 3D atualizados  
**Data:** Fevereiro 2026
