
# 📄 Bellabeat Case Study: How Can a Wellness Technology Company Play It Smart?

## 🧭 ASK

### Business Task
A Bellabeat, empresa de tecnologia focada no bem-estar feminino, deseja entender **como as usuárias utilizam seus dispositivos de rastreamento de saúde**. O objetivo é usar esses dados para gerar **insights acionáveis** que orientem **estratégias de marketing e produto**.

## 📂 PREPARE

### Dataset Utilizado
- **Fonte:** [FitBit Fitness Tracker Data (Kaggle)](https://www.kaggle.com/datasets/arashnic/fitbit)
- **Período:** Maio de 2016
- **Usuárias:** 33 mulheres

### Arquivos principais:
- `dailyActivity_merged.csv` – Atividades diárias (passos, distância, calorias)
- `sleepDay_merged.csv` – Sono (tempo dormido e na cama)
- `merged_data` – Junção de ambos por ID e data

### Considerações:
- Dados limitados a usuárias altamente engajadas (até 31 dias de uso).
- Pode conter viés de amostragem.
- Ainda assim, útil para entender padrões e formular hipóteses.

## 🧼 PROCESS

### Ações Realizadas
- Remoção de duplicatas
- Conversão de datas (`mdy` e `mdy_hms`)
- Verificação de valores ausentes (não foram encontrados)
- Junção dos datasets para análise combinada

## 📊 ANALYZE

### Estatísticas Descritivas

| Métrica                     | Valor         |
|----------------------------|---------------|
| Média de sono (min)        | 419 min       |
| Média de sono (horas)      | 6.99 h        |
| Eficiência média do sono   | 91,6%         |
| Média de passos por dia    | Analisado no gráfico |
| Média de calorias por dia  | Analisado no gráfico |
| Dias registrados por usuária | 28.5 dias   |

### Principais Correlações

| Variáveis Comparadas            | Correlação | Interpretação                          |
|--------------------------------|------------|----------------------------------------|
| Sono (min) x Passos            | -0.19      | Correlação negativa fraca              |
| Passos x Calorias              | 0.59       | Correlação positiva moderada           |

## 📈 SHARE

### Visualizações

#### 1. Distribuição dos passos

```r
ggplot(activity_data, aes(x = TotalSteps)) +
  geom_histogram(binwidth = 1000, fill = "skyblue")
```

#### 2. Distribuição dos minutos de sono

```r
ggplot(sleep_data, aes(x = TotalMinutesAsleep)) +
  geom_histogram(binwidth = 30, fill = "purple")
```

#### 3. Correlação entre sono e passos

```r
ggplot(merged_data, aes(x = TotalMinutesAsleep, y = TotalSteps)) +
  geom_point() + geom_smooth(method = "lm")
```

#### 4. Correlação entre passos e calorias

```r
ggplot(activity_data, aes(x = TotalSteps, y = Calories)) +
  geom_point() + geom_smooth(method = "lm")
```

## 🚀 ACT

### Insights e Ações Recomendadas

| Insight | Recomendação |
|--------|--------------|
| Média de sono é 6.99h (abaixo do ideal) | Criar funcionalidades de incentivo à melhora do sono |
| Eficiência do sono é alta (91,6%) | Enviar reforço positivo e manter boas práticas |
| Passos x Calorias: correlação moderada (0.59) | Motivar metas visuais de passos e calorias |
| Sono x Passos: correlação negativa (-0.19) | Personalizar sugestões sem assumir relação direta |
| Usuárias usaram os dispositivos em média 28,5 dias | Investir em heavy users e reter usuárias com <10 dias |

## 📌 Conclusão

O uso dos dados da Fitbit permitiu identificar padrões importantes no comportamento das usuárias da Bellabeat. Com insights baseados em dados reais, a empresa pode **melhorar a retenção, engajamento e eficácia de suas estratégias de marketing e produto**. Além disso, esses dados podem fundamentar o desenvolvimento de **novos recursos personalizados no app** para promover bem-estar integral.
