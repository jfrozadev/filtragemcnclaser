# 📦 CAIXA PLÁSTICA FILTRAGEM
## Caixa Organizadora Ordene 30L (307×425×305mm)
### MDF 300×300×3mm INTEIRO — só corte da abertura + furos M3

---

## 💡 CONCEITO

Caixa plástica comercial como estrutura. **MDF 300×300mm usado inteiro** (sem cortar o contorno externo).
O MDF encaixa justo na largura interna da caixa (~301mm). Guias 3D no fundo (50mm de altura) + **barras anti-tombo** no aro superior mantêm cada divisória firme.

```
┌─────────── CAIXA PLÁSTICA ───────────┐
│  ══ BARRA ANTI-TOMBO (aro) ══════    │ ← segura topo do MDF
│  MDF 300mm ← encaixa justo (301mm) → │
│  ┌───────────────────────────────┐    │
│  │        ┌──────────┐          │    │
│  │        │ ABERTURA │  ← laser │    │
│  │        │ FILTRO   │          │    │
│  │        └──────────┘          │    │
│  │     (furos M3 ao redor)      │    │
│  └───────────────────────────────┘    │
│  ──█──────────────────────────█──    │ ← guias piso 50mm
└───────────────────────────────────────┘
```

### Sustentação do MDF:
- ✅ **Embaixo**: Guias piso U (50mm alt.) — coladas no fundo
- ✅ **Em cima**: Barras anti-tombo — apoiam no aro da caixa
- ✅ **Laterais**: Paredes da caixa (301mm vs 300mm MDF)
- ✅ **3 eixos de contenção** → MDF não tomba!

### Vantagens:
- ✅ **Zero corte externo** — só abertura + furos
- ✅ Caixa pronta, vedada, com tampa
- ✅ MDF 300×300 direto da loja (sem desperdiço)
- ✅ Guias piso coladas + barras topo — **MDF não tomba!**
- ✅ Divisórias removíveis (levanta e sai)
- ✅ Menos tempo de laser (só aberturas)

---

## 📐 DIMENSÕES

### Caixa Plástica (Ordene Radical Color 30L):
| Parâmetro | Valor |
|-----------|-------|
| **Modelo** | Caixa Organizadora Plástico Transparente 30L |
| **Código** | 87164742 (Leroy Merlin) |
| **EAN** | 7898335072150 |
| **Externo** | 307 × 425 × 305 mm (L × P × A) |
| **Interno (est.)** | ~301 × 419 × 297 mm |
| **Parede** | ~3mm PP |

> ⚠️ **MEÇA SUA CAIXA!** Ajuste os parâmetros no OpenSCAD se necessário.

### MDF:
| Parâmetro | Valor |
|-----------|-------|
| **Chapa** | 300 × 300 × 3 mm (padrão, sem cortar) |
| **Encaixe** | 300mm no vão de 301mm (0.5mm folga/lado) |
| **Altura** | 300mm (sobra ~3mm acima do interno — ok com tampa) |

### Guia de Posição PISO (3D print):
| Parâmetro | Valor |
|-----------|-------|
| **Tipo** | Canal U colado no fundo |
| **Canal** | 3.4mm (MDF 3 + folga 0.4) |
| **Paredes** | 1.5mm cada |
| **Base** | 6.4mm × 2mm |
| **Altura guia** | **50mm** (anti-tombo) |
| **Comprimento** | 80mm |
| **Fixação** | Super Bonder gel |
| **Qtd** | 12 (6 posições × 2 lados) |

### Barra Anti-Tombo (3D print):
| Parâmetro | Valor |
|-----------|-------|
| **Tipo** | Barra com rasgos — apoiada no aro da caixa |
| **Largura** | 15mm (assenta no aro) |
| **Altura** | 20mm |
| **Rasgo** | 3.4mm × 14mm prof. (MDF entra por baixo) |
| **Seção 1** | 135mm — G3 + GM + Wega (3 rasgos) |
| **Seção 2** | 125mm — HEPA + C1 + C2 (3 rasgos) |
| **Fixação** | Apoio por gravidade (não precisa cola) |
| **Qtd** | 4 (2 seções × 2 lados) |

---

## 🎯 LAYOUT DOS FILTROS

```
ENTRADA Ø70mm                                    SAÍDA Ø150mm
    │                                                 │
    ▼                                                 ▼
┌───┬───┬────┬─────┬──────┬────┬───┬───┬───┬────┬────┐
│   │G3 │    │ GM  │      │WEGA│   │HPA│   │ C1 │ C2 │
│50 │   │ 95 │     │ 165  │    │245│   │310│    │350 │
└───┴───┴────┴─────┴──────┴────┴───┴───┴───┴────┴────┘
0mm              profundidade (425mm ext)            419mm
```

| # | Divisória | Pos Y | Abertura | Esp. Filtro | Furos M3 |
|---|-----------|-------|----------|-------------|----------|
| 1 | Manta G3 | 50mm | 200×200mm | 10mm | 8 |
| 2 | GM Cabine | 95mm | 212×200mm | 20mm | 8 |
| 3 | Wega Motor | 165mm | 223×160mm | 45mm | 4 |
| 4 | HEPA | 245mm | 100×130mm | 25mm | 8 |
| 5 | Tela Carvão 1 | 310mm | 200×200mm | 3mm (MDF) | 16 |
| 6 | Tela Carvão 2 | 350mm | 200×200mm | 3mm (MDF) | 16 |

### Espaçamentos:
| Trecho | mm | Função |
|--------|----|--------|
| Parede → G3 | 50 | Plenum entrada |
| G3 → GM | 35 | Expansão |
| GM → Wega | 50 | Expansão |
| Wega → HEPA | 35 | Expansão |
| HEPA → Tela 1 | 40 | Expansão |
| Tela 1 → Tela 2 | 37 | Carvão ativado (~700g) |
| Tela 2 → Parede | 66 | Plenum saída |

---

## ⚙️ CORTE CNC LASER

| Parâmetro | Valor |
|-----------|-------|
| **CNC** | Two Trees TTS-10 |
| **Material** | MDF 3mm |
| **Potência** | S900 |
| **Velocidade** | F200 mm/min |
| **Passagens** | 4× |
| **Air Assist** | OBRIGATÓRIO |

**Importante:** Os NC files cortam APENAS a abertura e os furos M3. O contorno externo 300×300mm **NÃO é cortado**.

---

## 📁 ARQUIVOS

### Corte CNC (5 divisórias):
| # | Arquivo | Abertura | Furos M3 |
|---|---------|----------|----------|
| 1 | `01_DIVISORIA_MANTA_G3.nc` | 200×200mm em (50,50) | 8 |
| 2 | `02_DIVISORIA_GM.nc` | 212×200mm em (44,50) | 8 |
| 3 | `03_DIVISORIA_WEGA.nc` | 223×160mm em (38.5,70) | 4 |
| 4 | `04_DIVISORIA_HEPA.nc` | 100×130mm em (100,85) | 8 |
| 5 | `05_TELA_CARVAO.nc` | 200×200mm em (50,50) | 16 (×2 chapas) |

### Impressão 3D:
| # | Arquivo | Descrição |
|---|---------|-----------|
| 6 | `GUIA_POSICAO.scad` | Guia U parametrizável (OpenSCAD) |

### Visualização:
| # | Arquivo | Descrição |
|---|---------|-----------|
| 7 | `MONTAGEM_3D.html` | Montagem 3D interativa (12 passos) |

### Reutilizados (pasta pai):
| Arquivo | Descrição |
|---------|-----------|
| `../FLANGE_70mm.scad` | Flange entrada Ø70mm |
| `../FLANGE_150mm.scad` | Flange saída Ø150mm |
| `../SNAP_TAMPA.scad` | Clips retenção filtro (M3) |

---

## 🔧 FUROS NA CAIXA (Furadeira)

### Apenas flanges! (serra-copo)
```
FRONTAL:                      TRASEIRA:
┌──────────────────┐          ┌──────────────────┐
│    ┌────────┐    │          │  ┌────────────┐  │
│    │ Ø70mm  │    │          │  │  Ø150mm    │  │
│    │ENTRADA │    │          │  │  SAÍDA     │  │
│    └────────┘    │          │  └────────────┘  │
│ centro: ~153×152 │          │ centro: ~153×152 │
└──────────────────┘          └──────────────────┘
```

**Laterais: SEM FUROS** — guias são coladas com Super Bonder gel.

---

## 🛠️ ORDEM DE MONTAGEM

1. **Caixa plástica** → Limpar e marcar posições internas
2. **Furar flanges** → Serra-copo Ø70mm (frente) e Ø150mm (atrás)
3. **Instalar flanges 3D** → Parafusar nas faces da caixa
4. **Marcar posições no fundo** → Régua: Y=50, 95, 165, 245, 310, 350mm
5. **Colar guias piso** → Super Bonder gel, 12 guias (50mm alt.) — 2 por posição
6. **Encaixar barras anti-tombo** → 4 barras no aro da caixa (2 seções × 2 lados)
7. **Cortar divisórias** → CNC laser: 7 chapas MDF 300×300mm (só abertura + furos)
8. **Manta G3** → Encaixar MDF na guia Y=50, fixar filtro com 8 clips M3
9. **GM Cabine** → Guia Y=95, filtro 20mm + 8 clips
10. **Wega Motor** → Guia Y=165, filtro 45mm + 4 clips
11. **HEPA** → Guia Y=245, filtro HEPA 25mm + 8 clips
12. **Tela Carvão 1** → Guia Y=310, tela alumínio (16 M3+arruela)
13. **Carvão** → ~700g carvão ativado granulado
14. **Tela Carvão 2** → Guia Y=350, tela alumínio
15. **Tampa** → Fechar com trava original da caixa

---

## 🖨️ IMPRESSÃO 3D

### Guias piso (1 batch):
| Peças | Tamanho cada | Tempo | Filamento |
|-------|-------------|-------|-----------|
| 12 guias (6 pos × 2) | 6.4×80×52mm | ~1h | ~25g |

### Barras anti-tombo (1 batch):
| Peças | Tamanho | Tempo | Filamento |
|-------|---------|-------|-----------|
| 2× Seção 1 | 135×15×20mm | ~30min | ~8g |
| 2× Seção 2 | 125×15×20mm | ~25min | ~7g |

### Acessórios (pasta pai):
| Item | Qtd | Tempo |
|------|-----|-------|
| Flange 70mm | 1 | ~1h30 |
| Flange 150mm | 1 | ~3h |
| Clips retenção | 28 | ~4h |

**Total: ~10h de impressão | ~140g PLA/PETG**

---

## 📋 LISTA DE MATERIAIS

| Item | Qtd | Observação |
|------|-----|-----------|
| Caixa Ordene 30L | 1 | 307×425×305mm (Leroy Merlin) |
| **MDF 300×300×3mm** | **7** | **Usadas inteiras — sem corte externo** |
| Manta G3 (pré-filtro) | 1 | 200×200×10mm |
| Filtro GM Cabine Bosch | 1 | 212×200×20mm |
| Filtro Wega Motor | 1 | 223×160×45mm |
| Filtro HEPA | 1 | 110×140×25mm |
| Carvão ativado | ~700g | Granulado |
| Tela alumínio mosquiteira | 2× | 250×250mm recortada |
| Parafuso M3×10mm + porca | ~80× | Clips + tela alumínio |
| Arruela M3 | 64× | 32 por tela carvão |
| Super Bonder gel | 1 | Fixar guias no fundo |
| Filamento PLA/PETG | ~100g | Guias + flanges + clips |
| Serra-copo Ø70 + Ø150mm | 1+1 | Para furar flanges |

---

## 🎯 VERIFICAÇÃO 3D

Abra `MONTAGEM_3D.html` no navegador:
- **12 passos interativos** (incluindo barras anti-tombo no passo 6)
- Setas ←→, barra de espaço, Home/End para navegar
- Botão "Mostrar Tudo" para ver montagem completa
- Rotacionar e zoom com mouse

---

**Versão:** 3.0 — Guias 50mm + Barras anti-tombo  
**Data:** Fevereiro 2026
